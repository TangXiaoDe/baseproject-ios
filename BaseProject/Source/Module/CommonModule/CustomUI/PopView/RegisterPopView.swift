//
//  RegisterPopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  注册完善资料提示弹窗

import UIKit

protocol RegisterPopViewProtocol: BasePopViewProtocol {
    /// 注册弹窗 下一步按钮 点击回调
    func registerPopView(_ popView: RegisterPopView, didClickedDone doneView: UIButton) -> Void
}


typealias RegisterCompleteInfoPopView = RegisterPopView
/// 注册完善资料提示弹窗
class RegisterPopView: BasePopView {

    // MARK: - Internal Property

    weak var myDelegate: RegisterPopViewProtocol?
    override weak var delegate: BasePopViewProtocol? {
        get {
            return self.myDelegate
        } set {
            self.myDelegate = delegate as? RegisterPopViewProtocol
        }
    }

    var doneBtnClickAction: ((_ popView: RegisterPopView, _ doneBtn: UIButton) -> Void)?

    var isSync: Bool = true {
        didSet {
            self.setupIsSync(isSync)
        }
    }

    // MARK: - Private Property

    // superProperty
    //    let coverBtn: UIButton = UIButton.init(type: .custom)
    //    let mainView: UIView = UIView()
    //    let iconView: UIImageView = UIImageView()
    //    let titleLabel: UILabel = UILabel()
    //    let doneBtn: UIButton = UIButton.init(type: .custom)
    //    var mainLrMargin: CGFloat = 45

    let registerPromptLabel: UILabel = UILabel()
    let syncPromptLabel: UILabel = UILabel()
    let completePromptLabel: UILabel = UILabel()

    let iconSize: CGSize = CGSize.init(width: 107, height: 64)
    let iconTopMargin: CGFloat = 25
    let registerTopMargin: CGFloat = 20
    let syncTopMargin: CGFloat = 22
    let completeTopMargin: CGFloat = 15
    let doneBtnW: CGFloat = 150
    let doneBtnH: CGFloat = 32
    let doneBtnTopMargin: CGFloat = 32
    let doneBtnBottomMargin: CGFloat = 24

    // MARK: - Initialize Function

    /// 通用初始化：UI、配置、数据等
    override func commonInit() -> Void {
        self.mainLrMargin = 47
        self.initialUI()
    }

}

// MARK: - Internal Function
extension RegisterPopView {

}

// MARK: - LifeCircle Function
extension RegisterPopView {

}
// MARK: - Private UI 手动布局
extension RegisterPopView {

    /// 界面布局 - 子类重写
    override func initialUI() -> Void {
        super.initialUI()
    }
    /// mainView布局 - 子类重写
    override func initialMainView(_ mainView: UIView) -> Void {
        mainView.set(cornerRadius: 10)
        mainView.backgroundColor = UIColor.white
        // 1. iconView
        mainView.addSubview(self.iconView)
        self.iconView.image = UIImage.init(named: "IMG_login_completeinfo")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(iconSize)
            make.top.equalToSuperview().offset(iconTopMargin)
        }
        // 2. registerPromptLabel
        mainView.addSubview(registerPromptLabel)
        registerPromptLabel.set(text: "恭喜您，注册成功～", font: UIFont.pingFangSCFont(size: 18), textColor: UIColor.init(hex: 0x8C97AC), alignment: .center)
        registerPromptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(registerTopMargin)
        }
        // 3. syncPromptLabel
        mainView.addSubview(syncPromptLabel)
        syncPromptLabel.set(text: "已为您同步社区链APP资产", font: UIFont.pingFangSCFont(size: 18), textColor: UIColor.init(hex: 0x202A46), alignment: .center)
        syncPromptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(registerPromptLabel.snp.bottom).offset(syncTopMargin)
        }
        // 4. completeInfoLabel
        mainView.addSubview(completePromptLabel)
        completePromptLabel.set(text: "快去完善资料吧！", font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.init(hex: 0x202A46), alignment: .center)
        completePromptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(syncPromptLabel.snp.bottom).offset(completeTopMargin)
        }
        // 5. doneBtn
        mainView.addSubview(self.doneBtn)
        self.doneBtn.addTarget(self, action: #selector(doneBtnClick(_:)), for: .touchUpInside)
        self.doneBtn.gradientLayer.frame = CGRect.init(x: 0, y: 0, width: doneBtnW, height: doneBtnH)
        self.doneBtn.set(title: "下一步", titleColor: UIColor.white, for: .normal)
        self.doneBtn.set(font: UIFont.pingFangSCFont(size: 16), cornerRadius: 5, borderWidth: 0, borderColor: UIColor.clear)
        self.doneBtn.snp.makeConstraints { (make) in
            make.width.equalTo(doneBtnW)
            make.height.equalTo(doneBtnH)
            make.centerX.equalToSuperview()
            make.top.equalTo(completePromptLabel.snp.bottom).offset(doneBtnTopMargin)
            make.bottom.equalToSuperview().offset(-doneBtnBottomMargin)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension RegisterPopView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension RegisterPopView {
    /// 是否同步设置
    fileprivate func setupIsSync(_ isSync: Bool) -> Void {
        // 默认按照同步展示，非同步时取消同步提示
        if !isSync {
            self.syncPromptLabel.text = nil
            self.syncPromptLabel.snp.updateConstraints { (make) in
                make.top.equalTo(self.registerPromptLabel.snp.bottom).offset(0)
            }
            self.completePromptLabel.snp.updateConstraints { (make) in
                make.top.equalTo(self.syncPromptLabel.snp.bottom).offset(24)
            }
        }
        self.mainView.layoutIfNeeded()
    }

}

// MARK: - Event Function
extension RegisterPopView {

    /// 确定按钮点击
    @objc fileprivate func doneBtnClick(_ button: UIButton) -> Void {
        self.myDelegate?.registerPopView(self, didClickedDone: button)
        self.doneBtnClickAction?(self, button)
    }

}

// MARK: - Extension Function
extension RegisterPopView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension RegisterPopView {

}
