//
//  SmsCodeLoginInputView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/11.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  验证码登录输入视图

import UIKit
import ObjectMapper
import ChainOneKit

class SmsCodeLoginInputView: UIView {

    // MARK: - Internal Property

    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var smsCodeField: UITextField!
    @IBOutlet weak var sendSmsBtn: UIButton!

    /// 回调
    var inputChangedAction: ((_ inputView: SmsCodeLoginInputView) -> Void)?

    // MARK: - Private Property

    fileprivate let countdownLabel: UILabel = UILabel()

    fileprivate let accountLen: Int = 11
    fileprivate let codeLen: Int = 10

    fileprivate let sendCodeBtnH: CGFloat = 28
    fileprivate let sendCodeBtnW: CGFloat = 84

    /// 定时器相关
    fileprivate let maxLeftSecond: Int = 60
    fileprivate var leftSecond: Int = 60
    fileprivate var timer: Timer? = nil

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

    deinit {
        self.stopTimer()
    }

}

// MARK: - Internal Function
extension SmsCodeLoginInputView {
    class func loadXib() -> SmsCodeLoginInputView? {
        return Bundle.main.loadNibNamed("SmsCodeLoginInputView", owner: nil, options: nil)?.first as? SmsCodeLoginInputView
    }

    /// 是否可登录
    func couldDone() -> Bool {
        var flag: Bool = false
        guard let account = self.accountField.text, let code = self.smsCodeField.text else {
            return flag
        }
        flag = !account.isEmpty && !code.isEmpty
        return flag
    }
}

// MARK: - LifeCircle Function
extension SmsCodeLoginInputView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension SmsCodeLoginInputView {

    /// 界面布局
    fileprivate func initialUI() -> Void {

    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {

    }

}
// MARK: - Private UI Xib加载后处理
extension SmsCodeLoginInputView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        self.backgroundColor = UIColor.clear
        // 1. accountField
        let accountClearBtn: UIButton = UIButton.init(type: .custom)
        accountClearBtn.setImage(UIImage.init(named: "IMG_icon_input_clear"), for: .normal)
        accountClearBtn.bounds = CGRect.init(x: 0, y: 0, width: 22, height: 30)
        accountClearBtn.addTarget(self, action: #selector(accountClearBtnClick(_:)), for: .touchUpInside)
        self.accountField.rightView = accountClearBtn
        self.accountField.rightViewMode = .whileEditing
        self.accountField.addTarget(self, action: #selector(accountFieldValueChanged(_:)), for: .editingChanged)
        self.accountField.attributedPlaceholder = NSAttributedString.init(string: "input.placeholder.phone".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x525C6E)])
        // 2. verifyCodeField
        self.smsCodeField.addTarget(self, action: #selector(smsCodeFieldValueChanged(_:)), for: .editingChanged)
        self.smsCodeField.attributedPlaceholder = NSAttributedString.init(string: "input.placeholder.smscode".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x525C6E)])
        // 3. sendSmsBtn
        self.sendSmsBtn.set(font: UIFont.systemFont(ofSize: 12), cornerRadius: 5, borderWidth: 0.5, borderColor: AppColor.theme)
        self.sendSmsBtn.setTitle("smscode.send".localized, for: .normal)
        // 4. countLabel
        self.addSubview(self.countdownLabel)
        self.countdownLabel.set(text: nil, font: UIFont.systemFont(ofSize: 12), textColor: UIColor(hex: 0x8C97AC), alignment: .center)
        self.countdownLabel.set(cornerRadius: 5, borderWidth: 1, borderColor: UIColor.init(hex: 0x8C97AC))
        self.countdownLabel.isHidden = true // 默认隐藏
        self.countdownLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.sendSmsBtn)
        }
    }
}

// MARK: - Data Function
extension SmsCodeLoginInputView {

}

// MARK: - Event Function
extension SmsCodeLoginInputView {
    /// 发送验证码按钮点击
    @IBAction func sendSmsBtnClick(_ sender: UIButton) {
        self.endEditing(true)
        guard let account = self.accountField.text, !account.isEmpty else {
            return
        }
//        let window: UIWindow = UIApplication.shared.keyWindow!
//        // 腾讯防水墙
//        let appId = AppConfig.share.third.tcCaptcha.smsLoginId
//        TCWebCodesBridge.shared().loadTencentCaptcha(window, appid: appId) { (resultDic) in
//            if let result = Mapper<TCWebCodesResultModel>().map(JSONObject: resultDic), 0 == result.code {
//                // 发送验证码请求
//                self.sendSmsCodeRequest(account: account, ticket: result.ticket, randStr: result.randStr)
//            } else {
//                Toast.showToast(title: "滑块验证失败\n请滑到指定位置，或检查你的网络")
//            }
//        }
    }

    /// 账号输入框输入值变更
    @objc fileprivate func accountFieldValueChanged(_ textField: UITextField) -> Void {
        TextFieldHelper.limitTextField(textField, withMaxLen: self.accountLen)
        self.inputChangedAction?(self)
    }
    /// 密码输入框输入值变更
    @objc fileprivate func smsCodeFieldValueChanged(_ textField: UITextField) -> Void {
        TextFieldHelper.limitTextField(textField, withMaxLen: self.codeLen)
        self.inputChangedAction?(self)
    }
    /// 账号清除按钮点击
    @objc fileprivate func accountClearBtnClick(_ textField: UITextField) -> Void {
        self.accountField.text = nil
        self.inputChangedAction?(self)
    }
}

// MARK: - Extension Function
extension SmsCodeLoginInputView {
    /// 发送短信验证码请求
    fileprivate func sendSmsCodeRequest(account: String, ticket: String, randStr: String) -> Void {
        self.isUserInteractionEnabled = false
        AccountNetworkManager.sendUnAuthSMSCode(account: account, scene: .smscodeLogin, ticket: ticket, randStr: randStr) {  [weak self](status, msg) in
            guard let `self` = self else {
                return
            }
            //self.sendSmsCodeBtn.setTitle("重新发送验证码", for: .normal)
            self.isUserInteractionEnabled = true
            guard status else {
                Toast.showToast(title: msg)
                return
            }
            Toast.showToast(title: "验证码已经发送到您的手机")
            self.startTimer()
        }
    }

}

// MARK: - Timer
extension SmsCodeLoginInputView {
    /// 开启计时器
    fileprivate func startTimer() -> Void {
        // 相关控件设置
        self.sendSmsBtn.isHidden = true
        self.countdownLabel.isHidden = false
        self.countdownLabel.text = "\(self.maxLeftSecond)" + "smscode.countdown.sufix".localized
        self.leftSecond = self.maxLeftSecond
        // 开启倒计时
        self.stopTimer()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(countdown), object: nil)
        let timer = XDPackageTimer.timerWithInterval(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        timer.fire()
        self.timer = timer
    }
    /// 停止计时器
    fileprivate func stopTimer() -> Void {
        self.timer?.invalidate()
        self.timer = nil
    }
    /// 计时器回调 - 倒计时
    @objc fileprivate func countdown() -> Void {
        if self.leftSecond - 1 > 0 {
            self.leftSecond -= 1
            self.countdownLabel.text = "\(self.leftSecond)" + "smscode.countdown.sufix".localized
        } else {
            self.stopTimer()
            self.sendSmsBtn.setTitle("smscode.resend".localized, for: .normal)
            self.countdownLabel.isHidden = true
            self.sendSmsBtn.isHidden = false
        }
    }
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension SmsCodeLoginInputView {

}
