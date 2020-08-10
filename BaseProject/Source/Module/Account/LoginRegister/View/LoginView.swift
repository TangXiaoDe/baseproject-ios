//
//  LoginView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/11.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  登录视图

import UIKit

protocol LoginViewProtocol: class {
    func loginView(_ loginView: LoginView, didCliedkedLogin loginBtn: UIButton, account: String, password: String) -> Void
    func loginView(_ loginView: LoginView, didCliedkedLogin loginBtn: UIButton, account: String, smsCode: String) -> Void
    func loginView(_ loginView: LoginView, didCliedkedForgetPwd forgetPwdBtn: UIButton) -> Void
    func loginView(_ loginView: LoginView, didChangedLoginType loginType: LoginType) -> Void
}

class LoginView: UIView {

    // MARK: - Internal Property

    var showType: LoginType = .password {
        didSet {
            self.setupShowType(showType)
        }
    }

    /// 会滴
    weak var delegate: LoginViewProtocol?

    // MARK: - Private Property

    let mainView: UIView = UIView()

    let loginTopContainer: UIView = UIView()
    let passwordLoginView: PasswordLoginInputView = PasswordLoginInputView.loadXib()!
    let smsCodeLoginView: SmsCodeLoginInputView = SmsCodeLoginInputView.loadXib()!

    let bottomView: UIView = UIView()
    let loginBtn: CommonDoneBtn = CommonDoneBtn.init(type: .custom)
    let loginTypeBtn: UIButton = UIButton.init(type: .custom)
    let forgetPwdBtn: UIButton = UIButton.init(type: .custom)

    fileprivate let lrMargin: CGFloat = 12
    fileprivate let doneBtnH: CGFloat = 44

    fileprivate let loginInputH: CGFloat = 112
    fileprivate let doneBtnTopMargin: CGFloat = 65
    fileprivate let typeBtnTopMargin: CGFloat = 20

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension LoginView {
    class func loadXib() -> LoginView? {
        return Bundle.main.loadNibNamed("LoginView", owner: nil, options: nil)?.first as? LoginView
    }
}

// MARK: - LifeCircle Function
extension LoginView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension LoginView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. container
        mainView.addSubview(self.loginTopContainer)
        self.initialLoginTopContainer(self.loginTopContainer)
        self.loginTopContainer.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.loginInputH)
        }
        // 2. loginBtn
        mainView.addSubview(self.loginBtn)
        self.loginBtn.gradientLayer.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - self.lrMargin * 2.0, height: self.doneBtnH)
        self.loginBtn.addTarget(self, action: #selector(loginBtnClick(_:)), for: .touchUpInside)
        self.loginBtn.set(title: "donebtn.login".localized, titleColor: UIColor.white, for: .normal)
        self.loginBtn.set(title: "donebtn.login".localized, titleColor: UIColor.init(hex: 0x8C97AC), for: .disabled)
        self.loginBtn.set(font: UIFont.systemFont(ofSize: 18), cornerRadius: 5, borderWidth: 0, borderColor: UIColor.clear)
        self.loginBtn.snp.makeConstraints { (make) in
            make.height.equalTo(self.doneBtnH)
            make.leading.equalToSuperview().offset(lrMargin)
            make.trailing.equalToSuperview().offset(-lrMargin)
            make.top.equalTo(self.loginTopContainer.snp.bottom).offset(doneBtnTopMargin)
        }
        // 3. typeBtn
        mainView.addSubview(self.loginTypeBtn)
        self.loginTypeBtn.contentHorizontalAlignment = .left
        self.loginTypeBtn.set(title: "login.type.smscode".localized, titleColor: AppColor.theme, for: .normal)
        self.loginTypeBtn.set(font: UIFont.systemFont(ofSize: 14))
        self.loginTypeBtn.addTarget(self, action: #selector(loginTypeBtnClick(_:)), for: .touchUpInside)
        self.loginTypeBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(lrMargin)
            make.top.equalTo(self.loginBtn.snp.bottom).offset(typeBtnTopMargin)
            make.bottom.equalToSuperview()
        }
        // 4. forgetPwdBtn
        mainView.addSubview(self.forgetPwdBtn)
        self.forgetPwdBtn.contentHorizontalAlignment = .right
        self.forgetPwdBtn.set(title: "login.forgetpwd".localized, titleColor: UIColor.init(hex: 0x8C97AC), for: .normal)
        self.forgetPwdBtn.set(font: UIFont.systemFont(ofSize: 12))
        self.forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnClick(_:)), for: .touchUpInside)
        self.forgetPwdBtn.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-lrMargin)
            make.centerY.equalTo(self.loginTypeBtn)
        }
    }

    /// 登录顶部的容器布局
    fileprivate func initialLoginTopContainer(_ container: UIView) -> Void {
        // 1. passwordInputView
        container.addSubview(self.passwordLoginView)
        self.passwordLoginView.inputChangedAction = { (_ inputView: PasswordLoginInputView) in
            self.couldDoneProcess()
        }
        self.passwordLoginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. smscodeInputView
        container.addSubview(self.smsCodeLoginView)
        self.smsCodeLoginView.inputChangedAction = { (_ inputView: SmsCodeLoginInputView) in
            self.couldDoneProcess()
        }
        self.smsCodeLoginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 显示默认
        self.setupShowType(self.showType)
    }

}
// MARK: - Private UI Xib加载后处理
extension LoginView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension LoginView {
    fileprivate func setupShowType(_ showType: LoginType) -> Void {
        switch showType {
        case .password:
            self.passwordLoginView.isHidden = false
            self.smsCodeLoginView.isHidden = true
            self.loginTypeBtn.setTitle("login.type.smscode".localized, for: .normal)
        case .smscode:
            self.passwordLoginView.isHidden = true
            self.smsCodeLoginView.isHidden = false
            self.loginTypeBtn.setTitle("login.type.password".localized, for: .normal)
        }
        self.couldDoneProcess()
    }

    fileprivate func couldDoneProcess() -> Void {
        switch self.showType {
        case .password:
            self.loginBtn.isEnabled = self.passwordLoginView.couldDone()
        case .smscode:
            self.loginBtn.isEnabled = self.smsCodeLoginView.couldDone()
        }
    }
}

extension LoginView {
    /// 账号密码登录
    fileprivate func passwordLoginBtnClick(_ button: UIButton) -> Void {
        guard let account = self.passwordLoginView.accountField.text, let password = self.passwordLoginView.passwordField.text else {
            return
        }
        self.delegate?.loginView(self, didCliedkedLogin: button, account: account, password: password)
    }
    /// 验证码密码登录
    fileprivate func smsCodeLoginBtnClick(_ button: UIButton) -> Void {
        guard let account = self.smsCodeLoginView.accountField.text, let code = self.smsCodeLoginView.smsCodeField.text else {
            return
        }
        self.delegate?.loginView(self, didCliedkedLogin: button, account: account, smsCode: code)
    }
}

// MARK: - Event Function
extension LoginView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }

    @objc fileprivate func loginBtnClick(_ button: UIButton) -> Void {
        self.endEditing(true)
        switch self.showType {
        case .password:
            self.passwordLoginBtnClick(button)
        case .smscode:
            self.smsCodeLoginBtnClick(button)
        }
    }
    @objc fileprivate func loginTypeBtnClick(_ button: UIButton) -> Void {
        self.endEditing(true)
        var newType: LoginType
        switch self.showType {
        case .password:
            newType = .smscode
        case .smscode:
            newType = .password
        }
        self.showType = newType
        self.delegate?.loginView(self, didChangedLoginType: newType)
    }
    @objc fileprivate func forgetPwdBtnClick(_ button: UIButton) -> Void {
        self.endEditing(true)
        self.delegate?.loginView(self, didCliedkedForgetPwd: button)
    }
}

// MARK: - Extension Function
extension LoginView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension LoginView {

}
