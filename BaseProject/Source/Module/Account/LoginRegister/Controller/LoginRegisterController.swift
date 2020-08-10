//
//  LoginRegisterController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/5/29.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  登录注册页，左右切换登录注册

import UIKit
import ObjectMapper
import Reachability

/// 登录注册页
class LoginRegisterController: BaseViewController {
    // MARK: - Internal Property

    fileprivate let barView: AppHomeNavBar = AppHomeNavBar.init()

    fileprivate let topBgImgView: UIImageView = UIImageView()
    fileprivate let logoView: UIImageView = UIImageView()
    fileprivate let switchView: LoginRegisterSwitchView = LoginRegisterSwitchView()
    fileprivate let horScrollView: UIScrollView = UIScrollView()
    fileprivate let loginView: LoginView = LoginView()
    fileprivate let registerView: RegisterView = RegisterView.loadXib()!

    fileprivate let topBgImgSize: CGSize = CGSize.init(width: 375, height: 235).scaleAspectForWidth(kScreenWidth)
    fileprivate let logoTopMargin: CGFloat = kStatusBarHeight + 60
    fileprivate let logoSize: CGSize = CGSize.init(width: 84, height: 82)
    fileprivate let switchTopMargin: CGFloat = 30
    fileprivate let horScrollTopMargin: CGFloat = 23
    fileprivate let horScrollH: CGFloat = kScreenHeight - kBottomHeight - LoginRegisterSwitchView.viewHeight - kStatusBarHeight - 60 - 82 - 30 - 23 // logoTopMargin,logoH,switchTopMargin,switchH,scrollTop

    // MARK: - Private Property

    fileprivate(set) var type: LoginRegisterType = LoginRegisterType.login
    fileprivate var selectedIndex: Int = 0

    fileprivate let loadingView: AppLoadingView = AppLoadingView.init(title: "请求中")

    /// 注册是否需要同步
    fileprivate var isRegisterSync: Bool = false

    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension LoginRegisterController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
        // 网络检测
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChangedNotificationProcess(_:)), name: NSNotification.Name.app.reachabilityChanged, object: nil)
        VersionManager.share.updateProcess()    // 版本更新判断
        // 初始数据(配置、广告)再次加载，避免首次问题
        AppUtil.getSystemConfig()              // 应用启动配置(来自服务器)
        AdvertManager.share.downloadAllAds()     // 广告
        // navbar 设置
        let titleFont: UIFont = UIFont.pingFangSCFont(size: 18, weight: .medium)
        self.navigationController?.setNavBarTheme(titleFont: titleFont, titleColor: UIColor.white, tintColor: UIColor.white, barTintColor: UIColor.init(hex: 0x2D385C), isTranslucent: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotifiationProcess(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotifiationProcess(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - UI
extension LoginRegisterController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        // 0. bgLayer
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(hex: 0x2E3D64).cgColor, UIColor.init(hex: 0x1F2A46).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 1)
        self.view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = UIScreen.main.bounds
        // 1. navigationbar
        self.view.addSubview(self.barView)
        self.barView.title = "common.login".localized
        self.barView.leftItem.isHidden = true
        self.barView.rightItem.isHidden = true
        self.barView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(kStatusBarHeight)
            make.height.equalTo(kNavigationBarHeight)
        }
        // 2. topBg
        self.view.addSubview(self.topBgImgView)
        self.topBgImgView.image = UIImage.init(named: "IMG_bg_login_top")
        self.topBgImgView.set(cornerRadius: 0)
        self.topBgImgView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(self.topBgImgSize.height)
        }
        // 3. logoView
        self.view.addSubview(self.logoView)
        self.logoView.set(cornerRadius: 0)
        self.logoView.image = UIImage.init(named: "IMG_login_imeet_logo")
        self.logoView.snp.makeConstraints { (make) in
            make.size.equalTo(self.logoSize)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(self.logoTopMargin)
        }
        // 4. switch
        self.view.addSubview(self.switchView)
        self.switchView.delegate = self
        self.switchView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.logoView.snp.bottom).offset(self.switchTopMargin)
            make.height.equalTo(LoginRegisterSwitchView.viewHeight)
            make.width.equalTo(LoginRegisterSwitchView.viewWidth)
        }
        // 5. horScroll
        self.view.addSubview(self.horScrollView)
        self.initialHorScrollView(self.horScrollView)
        self.horScrollView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottomMargin)
            make.top.equalTo(self.switchView.snp.bottom).offset(horScrollTopMargin)
        }
        // View Hierarchy
        self.view.bringSubviewToFront(self.barView)
    }
    fileprivate func initialHorScrollView(_ scrollView: UIScrollView) -> Void {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        // 使用容器 而不是直接使用对应View，是为了更方便扩展。
        // 1. loginContainer
        let loginContainer: UIView = UIView()
        scrollView.addSubview(loginContainer)
        self.initialLoginContainer(loginContainer)
        loginContainer.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.leading.equalToSuperview()
            make.height.equalTo(horScrollH)
        }
        // 2. registerContainer
        let registerContainer: UIView = UIView()
        scrollView.addSubview(registerContainer)
        self.initialRegisterContainer(registerContainer)
        registerContainer.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.leading.equalTo(loginContainer.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(horScrollH)
        }
    }
    fileprivate func initialLoginContainer(_ container: UIView) -> Void {
        // 1. scrollView
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        container.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. loginView
        scrollView.addSubview(self.loginView)
        self.loginView.delegate = self
        self.loginView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
            make.width.equalTo(kScreenWidth)
        }
    }
    fileprivate func initialRegisterContainer(_ container: UIView) -> Void {
        // 1. scrollView
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        container.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. registerView
        scrollView.addSubview(self.registerView)
        self.registerView.delegate = self
        self.registerView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(RegisterView.viewHeight)
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
        }
    }

}

// MARK: - Data(数据处理与加载)
extension LoginRegisterController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }

    /// 标题修改
    fileprivate func titleWithType(type: LoginRegisterType, loginType: LoginType) -> String {
        var title: String = ""
        switch type {
        case .register:
            title = type.title
        case .login:
            title = loginType.title
        }
        return title
    }

}

// MARK: - Event(事件响应)
extension LoginRegisterController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

// MARK: - Notification
extension LoginRegisterController {
    /// 网络环境变更通知处理
    @objc fileprivate func reachabilityChangedNotificationProcess(_ notification: Notification) -> Void {
        guard let conn = notification.object as? AppReachability.Connection else {
            return
        }
        switch conn {
        case .wifi:
            break
        case .cellular:
            break
        case .none:
            // 提示网络设置
            AppUtil.showNetworkSettingAlert()
        }
    }

    /// 键盘弹出通知处理
    @objc fileprivate func keyboardWillShowNotifiationProcess(_ notification: Notification) -> Void {
        if !self.registerView.inviteCodeField.isFirstResponder && !self.registerView.confirmPwdField.isFirstResponder && !self.registerView.passwordField.isFirstResponder && !self.registerView.verifyCodeField.isFirstResponder {
            return
        }
        guard let userInfo = notification.userInfo else {
            return
        }
        let kbBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let kbH: CGFloat = kbBounds.size.height
        // 根据响应控件确定键盘上升高度
        var topMaxY: CGFloat = 0
        var kbTopMargin: CGFloat = 25.0
        if self.registerView.inviteCodeField.isFirstResponder {
            let inviteCodeFrame = self.registerView.inviteCodeView!.frame
            let inviteMaxY = self.registerView.convert(CGPoint.init(x: 0, y: inviteCodeFrame.origin.y + inviteCodeFrame.size.height), to: self.view).y
            topMaxY = inviteMaxY
        } else if self.registerView.confirmPwdField.isFirstResponder {
            let confrimPwdFrame = self.registerView.confirmPwdView!.frame
            let confirmPwdMaxY = self.registerView.convert(CGPoint.init(x: 0, y: confrimPwdFrame.origin.y + confrimPwdFrame.size.height), to: self.view).y
            topMaxY = confirmPwdMaxY
            kbTopMargin = 65.0
        } else if self.registerView.passwordField.isFirstResponder {
            let pwdFrame = self.registerView.pwdView!.frame
            let pwdMaxY = self.registerView.convert(CGPoint.init(x: 0, y: pwdFrame.origin.y + pwdFrame.size.height), to: self.view).y
            topMaxY = pwdMaxY
            kbTopMargin = 65.0
        } else if self.registerView.verifyCodeField.isFirstResponder {
            let verifyCodeFrame = self.registerView.verifyCodeView!.frame
            let verifyCodeMaxY = self.registerView.convert(CGPoint.init(x: 0, y: verifyCodeFrame.origin.y + verifyCodeFrame.size.height), to: self.view).y
            topMaxY = verifyCodeMaxY
            kbTopMargin = 65.0
        }
        let bottomMargin = kScreenHeight - topMaxY
        if bottomMargin < kbH + kbTopMargin {
            let margin: CGFloat = kbH + kbTopMargin - bottomMargin
            let transform = CGAffineTransform.init(translationX: 0, y: -margin)
            UIView.animate(withDuration: duration, animations: {
                self.view.transform = transform
            }, completion: nil)
        }
    }

    /// 键盘关闭通知处理
    @objc fileprivate func keyboardWillHideNotifiationProcess(_ notification: Notification) -> Void {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}

// MARK: - Extension Function

// MARK: - Request
extension LoginRegisterController {
    /// 密码登录请求
    fileprivate func passwordLoginRequest(account: String, password: String, ticket: String, randStr: String) -> Void {
//        self.view.isUserInteractionEnabled = false
//        loadingView.title = "登录中"
//        loadingView.show()
//        AccountNetworkManager.pwdLogin(account: account, password: password, ticket: ticket, randStr: randStr) { [weak self](status, msg, model) in
//            guard let `self` = self else {
//                return
//            }
//            guard status, let model = model else {
//                self.view.isUserInteractionEnabled = true
//                self.loadingView.dismiss()
//                Toast.showToast(title: msg)
//                return
//            }
//            NetworkManager.share.configAuthorization(model.token)
//            // token获取成功，请求当前用户信息
//            self.requestCurrentUserInfo(with: model, for: account)
//        }
    }
    /// 短信验证码登录请求
    fileprivate func smsCodeLoginRequest(account: String, smsCode: String) -> Void {
        self.view.isUserInteractionEnabled = false
//        loadingView.title = "登录中"
//        loadingView.show()
//        AccountNetworkManager.smsCodeLogin(account: account, smsCode: smsCode) { [weak self](status, msg, model) in
//            guard let `self` = self else {
//                return
//            }
//            guard status, let model = model else {
//                self.view.isUserInteractionEnabled = true
//                self.loadingView.dismiss()
//                Toast.showToast(title: msg)
//                return
//            }
//            NetworkManager.share.configAuthorization(model.token)
//            // token获取成功，请求当前用户信息
//            self.requestCurrentUserInfo(with: model, for: account)
//        }
    }
    /// 注册请求
    fileprivate func registerRequest(account: String, smsCode: String, password: String, confirmPwd: String, inviteCode: String?) -> Void {
//        self.view.isUserInteractionEnabled = false
//        loadingView.title = "注册中"
//        loadingView.show()
//        AccountNetworkManager.register(account: account, password: password, confirmPwd: confirmPwd, smsCode: smsCode, inviteCode: inviteCode) { [weak self](status, msg, data) in
//            guard let `self` = self else {
//                return
//            }
//            guard status, let data = data else {
//                self.view.isUserInteractionEnabled = true
//                self.loadingView.dismiss()
//                Toast.showToast(title: msg)
//                return
//            }
//            NetworkManager.share.configAuthorization(data.token.token)
//            // token获取成功，请求当前用户信息
//            self.requestCurrentUserInfo(with: data.token, for: account, isRegister: true)
//            self.isRegisterSync = data.syncStatus
//        }
    }

    /// 请求当前用户信息
    private func requestCurrentUserInfo(with token: AccountTokenModel, for account: String, isRegister: Bool = false) -> Void {
//        UserNetworkManager.getCurrentUser { [weak self](status, msg, model) in
//            guard let `self` = self else {
//                return
//            }
//            self.view.isUserInteractionEnabled = true
//            self.loadingView.dismiss()
//            guard status, let model = model else {
//                // 注册时 只要用户请求成功，即使用户信息获取失败，也要进入主界面
//                if isRegister {
//                    AppConfig.share.internal.settedJPushAlias = false
//                    self.showRegisterPopView()
//                } else {
//                    Toast.showToast(title: msg)
//                }
//                return
//            }
//            let accountInfo = AccountModel.init(account: account, token: token, isLast: true, userInfo: model)
//            AccountManager.share.addLoginAccountInfo(accountInfo)
//            JPushHelper.instance.setAlias("\(model.id)")
//            if isRegister {
//                self.showRegisterPopView()
//            } else {
//                self.enterMainPage()
//            }
//        }
    }

}

// MARK: - EnterPage
extension LoginRegisterController {
    /// 进入忘记密码界面
    fileprivate func enterForgetPwdPage() -> Void {
//        let forgetPwdVC = LoginPwdForgetController.init(scene: LoginPwdForgetScene.login)
//        self.navigationController?.pushViewController(forgetPwdVC, animated: true)
    }
    /// 进入协议界面
    fileprivate func enterAgreementPage() -> Void {
        let webVC = XDWKWebViewController.init(type: XDWebViwSourceType.strUrl(strUrl: UrlManager.strAgreementUrl))
        self.enterPageVC(webVC)
    }
    /// 进入主页
    fileprivate func enterMainPage() -> Void {
        RootManager.share.type = .main
    }
    /// 进入注册完成性别设置界面
    fileprivate func enterRegisterCompletePage() -> Void {
//        let sexChooseVC = RegisterSexChooseController()
//        self.navigationController?.pushViewController(sexChooseVC, animated: true)
        self.enterMainPage()
    }

    fileprivate func showRegisterPopView() -> Void {
        let popView: RegisterPopView = RegisterPopView()
        popView.isSync = self.isRegisterSync
        popView.doneBtnClickAction = { (popView, doneBtn) in
            popView.removeFromSuperview()
            self.enterRegisterCompletePage()
        }
        PopViewUtil.showPopView(popView)
    }

}

// MARK: - Delegate Function

// MARK: - <LoginRegisterSwitchViewProtocol>
extension LoginRegisterController: LoginRegisterSwitchViewProtocol {
    func loginRegisterSwitchView(_ switchView: LoginRegisterSwitchView, didSelected type: LoginRegisterType) -> Void {
        self.type = type
        let x: CGFloat = (type == .login ? 0 : kScreenWidth)
        self.horScrollView.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
        self.view.endEditing(true)
        self.navigationItem.title = self.titleWithType(type: self.type, loginType: self.loginView.showType)
    }
}

// MARK: - <UIScrollViewDelegate>
extension LoginRegisterController: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollIndex: Int = Int(scrollView.contentOffset.x / kScreenWidth)
        self.selectedIndex = scrollIndex
        switch scrollIndex {
        case 0:
            self.switchView.type = .login
            self.type = .login
        case 1:
            self.switchView.type = .register
            self.type = .register
        default:
            break
        }
        self.navigationItem.title = self.titleWithType(type: self.type, loginType: self.loginView.showType)
    }
}

// MARK: - <LoginViewProtocol>
extension LoginRegisterController: LoginViewProtocol {
    func loginView(_ loginView: LoginView, didCliedkedLogin loginBtn: UIButton, account: String, password: String) -> Void {
//        // 腾讯防水墙
//        let appId: String = AppConfig.share.third.tcCaptcha.pwdLoginId
//        TCWebCodesBridge.shared().loadTencentCaptcha(self.view, appid: appId) { (resultDic) in
//            if let result = Mapper<TCWebCodesResultModel>().map(JSONObject: resultDic), 0 == result.code {
//                self.passwordLoginRequest(account: account, password: password, ticket: result.ticket, randStr: result.randStr)
//            } else {
//                Toast.showToast(title: "滑块验证失败\n请滑到指定位置，或检查你的网络")
//            }
//        }
    }
    func loginView(_ loginView: LoginView, didCliedkedLogin loginBtn: UIButton, account: String, smsCode: String) -> Void {
        self.smsCodeLoginRequest(account: account, smsCode: smsCode)
    }
    func loginView(_ loginView: LoginView, didCliedkedForgetPwd forgetPwdBtn: UIButton) -> Void {
        self.enterForgetPwdPage()
    }
    func loginView(_ loginView: LoginView, didChangedLoginType loginType: LoginType) {
        self.navigationItem.title = self.titleWithType(type: self.type, loginType: self.loginView.showType)
    }
}

// MARK: - <RegisterViewProtocol>
extension LoginRegisterController: RegisterViewProtocol {
    func registerView(_ registerView: RegisterView, didCliedkedAgreement agreementBtn: UIButton) -> Void {
        self.enterAgreementPage()
    }
    func registerView(_ registerView: RegisterView, didCliedkedRegister registerBtn: UIButton, account: String, password: String, confirmPwd: String, smsCode: String, inviteCode: String?) -> Void {
        self.registerRequest(account: account, smsCode: smsCode, password: password, confirmPwd: confirmPwd, inviteCode: inviteCode)
    }
}
