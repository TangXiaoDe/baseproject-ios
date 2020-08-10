//
//  CommunityJoinPopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  社群加入社区提示弹窗
//  注：此时已加入

import UIKit

protocol CommunityJoinPopViewProtocol: BasePopViewProtocol {
    /// 社区加入弹窗 确定按钮 点击回调
    func communityJoinPopView(_ popView: CommunityJoinPopView, didClickedDone doneView: UIButton) -> Void
}

/// 社群加入社区提示弹窗
typealias GroupJoinCommunityPopView = CommunityJoinPopView
/// 社群加入社区提示弹窗
class CommunityJoinPopView: BasePopView {

    // MARK: - Internal Property

    weak var myDelegate: CommunityJoinPopViewProtocol?
    override weak var delegate: BasePopViewProtocol? {
        get {
            return self.myDelegate
        } set {
            self.myDelegate = delegate as? CommunityJoinPopViewProtocol
        }
    }

    var doneBtnClickAction: ((_ popView: CommunityJoinPopView, _ doneBtn: UIButton) -> Void)?

    /// 退出需要多少天
    var quitDay: Int = 0 {
        didSet {
            self.setupQuitDay(quitDay)
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

    let topView: UIView = UIView()
    let promptLabel: UILabel = UILabel()

    let iconSize: CGSize = CGSize.init(width: 32, height: 32)
    let iconTopMargin: CGFloat = 17
    let promptTopMargin: CGFloat = 20
    let promptBottomMargin: CGFloat = 25
    let doneBtnH: CGFloat = 44

    // MARK: - Initialize Function

    /// 通用初始化：UI、配置、数据等
    override func commonInit() -> Void {
        self.mainLrMargin = 47
        self.initialUI()
    }

}

// MARK: - Internal Function
extension CommunityJoinPopView {

}

// MARK: - LifeCircle Function
extension CommunityJoinPopView {

}
// MARK: - Private UI 手动布局
extension CommunityJoinPopView {

    /// 界面布局 - 子类重写
    override func initialUI() -> Void {
        super.initialUI()
    }
    /// mainView布局 - 子类重写
    override func initialMainView(_ mainView: UIView) -> Void {
        mainView.set(cornerRadius: 10)
        mainView.backgroundColor = UIColor.white
        // 1. topView
        mainView.addSubview(self.topView)
        self.initialTopView(self.topView)
        self.topView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
        }
        self.topView.addLineWithSide(.inBottom, color: UIColor.init(hex: 0xE2E2E2), thickness: 1, margin1: 0, margin2: 0)
        // 3. doneBtn
        mainView.addSubview(self.doneBtn)
        self.doneBtn.addTarget(self, action: #selector(doneBtnClick(_:)), for: .touchUpInside)
        self.doneBtn.set(title: "确定", titleColor: UIColor.init(hex: 0x29313D), for: .normal)
        self.doneBtn.set(font: UIFont.pingFangSCFont(size: 16))
        self.doneBtn.snp.makeConstraints { (make) in
            make.height.equalTo(doneBtnH)
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.topView.snp.bottom)
        }
    }
    fileprivate func initialTopView(_ topView: UIView) -> Void {
        // 1. iconView
        topView.addSubview(self.iconView)
        self.iconView.image = UIImage.init(named: "IMG_group_quit_alert")
        self.iconView.set(cornerRadius: 0)
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(iconSize)
            make.top.equalToSuperview().offset(self.iconTopMargin)
        }
        // 2. promptLabebl
        topView.addSubview(self.promptLabel)
        self.promptLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 14), textColor: UIColor.init(hex: 0x29313D), alignment: .center)
        self.promptLabel.numberOfLines = 0
        self.promptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(self.promptTopMargin)
            make.bottom.equalToSuperview().offset(-self.promptBottomMargin)
        }
        self.quitDay = 0
    }

}
// MARK: - Private UI Xib加载后处理
extension CommunityJoinPopView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension CommunityJoinPopView {
    /// 退出需要多少天
    fileprivate func setupQuitDay(_ quitDay: Int) -> Void {
        let headAtt = NSAttributedString.init(string: "社群加入社区\n", attributes: [NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 14), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x29313D)])
        let tailAtt = NSAttributedString.init(string: "\n才可退出！", attributes: [NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 14), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x29313D)])
        let dayAtt = NSAttributedString.init(string: "\(quitDay)天之后", attributes: [NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 14), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xF15C8B)])
        let textAtt = NSMutableAttributedString.init()
        textAtt.append(headAtt)
        textAtt.append(dayAtt)
        textAtt.append(tailAtt)
        self.promptLabel.attributedText = textAtt
        self.mainView.layoutIfNeeded()
    }

}

// MARK: - Event Function
extension CommunityJoinPopView {

    /// 确定按钮点击
    @objc fileprivate func doneBtnClick(_ button: UIButton) -> Void {
        self.myDelegate?.communityJoinPopView(self, didClickedDone: button)
        self.doneBtnClickAction?(self, button)
    }

}

// MARK: - Extension Function
extension CommunityJoinPopView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension CommunityJoinPopView {

}
