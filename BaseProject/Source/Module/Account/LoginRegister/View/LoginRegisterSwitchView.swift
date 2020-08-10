//
//  LoginRegisterSwitchView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/11.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  登录注册切换开关视图
//  [注1] 之后应抽取成单独的自定义控件；

import UIKit

protocol LoginRegisterSwitchViewProtocol: class {
    func loginRegisterSwitchView(_ switchView: LoginRegisterSwitchView, didSelected type: LoginRegisterType) -> Void
}

class LoginRegisterSwitchView: UIView {

    // MARK: - Internal Property

    static let viewHeight: CGFloat = 32
    static let viewWidth: CGFloat = 186 // 93 * 2

    var type: LoginRegisterType = .login {
        didSet {
            self.setupType(type)
        }
    }

    /// 回调
    weak var delegate: LoginRegisterSwitchViewProtocol?
    var typeSelectedAction: ((_ switchView: LoginRegisterSwitchView, _ selectedType: LoginRegisterType) -> Void)?

    // MARK: - Private Property

    let mainView: UIView = UIView()
    let loginBtn: UIButton = UIButton.init(type: .custom)
    let registerBtn: UIButton = UIButton.init(type: .custom)

    fileprivate let itemH: CGFloat = LoginRegisterSwitchView.viewHeight

    fileprivate var selectedBtn: UIButton?
    fileprivate var selectedIndex: Int = 0
    fileprivate let itemBtnTagBase: Int = 250

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
extension LoginRegisterSwitchView {
    class func loadXib() -> LoginRegisterSwitchView? {
        return Bundle.main.loadNibNamed("LoginRegisterSwitchView", owner: nil, options: nil)?.first as? LoginRegisterSwitchView
    }
}

// MARK: - LifeCircle Function
extension LoginRegisterSwitchView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension LoginRegisterSwitchView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.backgroundColor = UIColor.init(hex: 0x2D385C)
        mainView.set(cornerRadius: self.itemH * 0.5, borderWidth: 0.5, borderColor: UIColor.init(hex: 0x00BDD2))
        let font: UIFont = UIFont.systemFont(ofSize: 18)
        let normalTitleColor: UIColor = UIColor.init(hex: 0x00BDD2)
        let selectedTitleColor: UIColor = UIColor.white
        let normalBgColor: UIColor = UIColor.init(hex: 0x2D385C)
        let selectedBgColor: UIColor = UIColor.init(hex: 0x00BDD2)
        // 1. loginBtn
        mainView.addSubview(self.loginBtn)
        self.loginBtn.set(title: "common.login".localized, titleColor: normalTitleColor, image: nil, bgImage: UIImage.imageWithColor(normalBgColor), for: .normal)
        self.loginBtn.set(title: "common.login".localized, titleColor: selectedTitleColor, image: nil, bgImage: UIImage.imageWithColor(selectedBgColor), for: .selected)
        self.loginBtn.set(font: font, cornerRadius: self.itemH * 0.5, borderWidth: 0, borderColor: UIColor.clear)
        self.loginBtn.addTarget(self, action: #selector(itemBtnClick(_:)), for: .touchUpInside)
        self.loginBtn.tag = self.itemBtnTagBase + 0
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalToSuperview()
            make.trailing.equalTo(mainView.snp.centerX)
        }
        // 2. registerBtn
        mainView.addSubview(self.registerBtn)
        self.registerBtn.set(title: "common.register".localized, titleColor: normalTitleColor, image: nil, bgImage: UIImage.imageWithColor(normalBgColor), for: .normal)
        self.registerBtn.set(title: "common.register".localized, titleColor: selectedTitleColor, image: nil, bgImage: UIImage.imageWithColor(selectedBgColor), for: .selected)
        self.registerBtn.set(font: font, cornerRadius: self.itemH * 0.5, borderWidth: 0, borderColor: UIColor.clear)
        self.registerBtn.addTarget(self, action: #selector(itemBtnClick(_:)), for: .touchUpInside)
        self.registerBtn.tag = self.itemBtnTagBase + 1
        self.registerBtn.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(mainView.snp.centerX)
        }
        // 3. 默认选中
        if let selectedBtn = mainView.viewWithTag(self.itemBtnTagBase + self.selectedIndex) as? UIButton {
            selectedBtn.isSelected = true
            self.selectedBtn = selectedBtn
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension LoginRegisterSwitchView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension LoginRegisterSwitchView {
    fileprivate func setupType(_ type: LoginRegisterType) -> Void {
        switch type {
        case .login:
            self.selectedIndex = 0
        case .register:
            self.selectedIndex = 1
        }
        self.selectedBtn?.isSelected = false
        if let selectedBtn = self.viewWithTag(self.itemBtnTagBase + self.selectedIndex) as? UIButton {
            selectedBtn.isSelected = true
            self.selectedBtn = selectedBtn
        }
    }
}

// MARK: - Event Function
extension LoginRegisterSwitchView {

    /// itemBtn按钮响应
    @objc fileprivate func itemBtnClick(_ button: UIButton) -> Void {
        if button == self.selectedBtn {
            return
        }
        let index: Int = button.tag - self.itemBtnTagBase
        button.isSelected = true
        self.selectedBtn?.isSelected = false
        self.selectedBtn = button
        self.selectedIndex = index
        switch index {
        case 0:
            self.delegate?.loginRegisterSwitchView(self, didSelected: .login)
            self.typeSelectedAction?(self, .login)
        case 1:
            self.delegate?.loginRegisterSwitchView(self, didSelected: .register)
            self.typeSelectedAction?(self, .register)
        default:
            break
        }
    }

    @objc fileprivate func loginBtnClick(_ button: UIButton) -> Void {
        self.delegate?.loginRegisterSwitchView(self, didSelected: .login)
        self.typeSelectedAction?(self, .login)
    }
    @objc fileprivate func registerBtnClick(_ button: UIButton) -> Void {
        self.delegate?.loginRegisterSwitchView(self, didSelected: .register)
        self.typeSelectedAction?(self, .register)
    }
}

// MARK: - Extension Function
extension LoginRegisterSwitchView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension LoginRegisterSwitchView {

}
