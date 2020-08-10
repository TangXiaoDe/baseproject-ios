//
//  CommonSmsCodeView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/8.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  验证码发送视图：发送按钮、倒计时视图

import UIKit
import ChainOneKit

protocol CommonSmsCodeViewProtocol: class {
    func codeView(_ codeView: CommonSmsCodeView, didClickedSend sendBtn: UIButton) -> Void
}

/// IMeet验证码控件 - 发送验证码、倒计时
typealias AppSmsCodeView = CommonSmsCodeView
/// 验证码发送控件
class CommonSmsCodeView: UIView {

    // MARK: - Internal Property

    static let viewW: CGFloat = 84
    static let viewH: CGFloat = 28

    /// 回调处理
    weak var delegate: CommonSmsCodeViewProtocol?
    var sendBtnClickAction: ((_ codeView: CommonSmsCodeView, _ sendBtn: UIButton) -> Void)?

    // MARK: - Private Property

    let mainView: UIView = UIView()
    /// 发送验证码按钮
    let sendBtn: UIButton = UIButton.init(type: .custom)
    /// 倒计时控件
    let countdownLabel: UILabel = UILabel()

    /// 定时器相关
    fileprivate let maxLeftSecond: Int = 60
    fileprivate var leftSecond: Int = 60
    fileprivate var timer: Timer? = nil

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        //fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.stopTimer()
    }

    /// 通用初始化：UI、配置、数据等
    fileprivate func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension CommonSmsCodeView {
    class func loadXib() -> CommonSmsCodeView? {
        return Bundle.main.loadNibNamed("CommonSmsCodeView", owner: nil, options: nil)?.first as? CommonSmsCodeView
    }

}
// MARK: - Timer
extension CommonSmsCodeView {
    /// 开启计时器
    func startTimer() -> Void {
        // 相关控件设置
        self.sendBtn.isHidden = true
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
    func stopTimer() -> Void {
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
            self.sendBtn.setTitle("smscode.resend".localized, for: .normal)
            self.countdownLabel.isHidden = true
            self.sendBtn.isHidden = false
        }
    }

}

// MARK: - LifeCircle Function
extension CommonSmsCodeView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension CommonSmsCodeView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. sendBtn
        mainView.addSubview(self.sendBtn)
        self.sendBtn.set(title: "smscode.send".localized, titleColor: AppColor.theme, for: .normal)
        self.sendBtn.set(font: UIFont.systemFont(ofSize: 12), cornerRadius: 5, borderWidth: 1, borderColor: AppColor.theme)
        self.sendBtn.addTarget(self, action: #selector(sendBtnClick(_:)), for: .touchUpInside)
        self.sendBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. countdownLabel
        mainView.addSubview(self.countdownLabel)
        self.countdownLabel.set(text: nil, font: UIFont.systemFont(ofSize: 12), textColor: UIColor(hex: 0x8C97AC), alignment: .center)
        self.countdownLabel.set(cornerRadius: 5, borderWidth: 1, borderColor: UIColor.init(hex: 0x8C97AC))
        self.countdownLabel.isHidden = true // 默认隐藏
        self.countdownLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension CommonSmsCodeView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension CommonSmsCodeView {

}

// MARK: - Event Function
extension CommonSmsCodeView {
    /// 发送验证码按钮点击响应
    @objc fileprivate func sendBtnClick(_ button: UIButton) -> Void {
        self.delegate?.codeView(self, didClickedSend: button)
        self.sendBtnClickAction?(self, button)
    }
}

// MARK: - Extension Function
extension CommonSmsCodeView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension CommonSmsCodeView {

}
