//
//  AutoSignInPopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/25.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  自动签到(成功)弹窗

import UIKit

/// 自动签到成功弹窗
typealias AutoSignInSuccessPopView = AutoSignInPopView
/// 自动签到弹窗
class AutoSignInPopView: BasePopView {

    // MARK: - Internal Property

    /// 奖励
    var rewardPower: Int = 0 {
        didSet {
            self.setupRewardPower(rewardPower)
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


    let mainBgView: UIImageView = UIImageView()
    let promptControl: DoubleTitleControl = DoubleTitleControl()

    let mainSize: CGSize = CGSize.init(width: 200, height: 210)
    let bottomViewHeight: CGFloat = 100
    let promptControlHeight: CGFloat = 60

    // MARK: - Initialize Function

    /// 通用初始化：UI、配置、数据等
    override func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension AutoSignInPopView {

}

// MARK: - LifeCircle Function
extension AutoSignInPopView {

}
// MARK: - Private UI 手动布局
extension AutoSignInPopView {

    /// 界面布局 - 子类重写
    override func initialUI() -> Void {
        super.initialUI()
        self.mainView.snp.remakeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(self.mainSize)
        }
    }
    /// mainView布局 - 子类重写
    override func initialMainView(_ mainView: UIView) -> Void {
        // 1. bgView
        mainView.addSubview(self.mainBgView)
        self.mainBgView.image = UIImage.init(named: "IMG_bg_popup_sign")
        self.mainBgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. promptControl
        mainView.addSubview(self.promptControl)
        self.promptControl.snp.makeConstraints { (make) in
            make.leading.trailing.centerX.equalToSuperview()
            make.centerY.equalTo(mainView.snp.bottom).offset(-self.bottomViewHeight * 0.5)
            make.height.equalTo(promptControlHeight)
        }
        self.promptControl.firstLabel.set(text: "恭喜你", font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.init(hex: 0x202A46), alignment: .center)
        self.promptControl.firstLabel.snp.remakeConstraints { (make) in
            make.leading.trailing.centerX.top.equalToSuperview()
        }
        self.promptControl.secondLabel.set(text: "获取 +2 矿力", font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.init(hex: 0x202A46), alignment: .center)
        self.promptControl.secondLabel.snp.remakeConstraints { (make) in
            make.leading.trailing.centerX.bottom.equalToSuperview()
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension AutoSignInPopView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension AutoSignInPopView {
    /// 是否同步设置
    fileprivate func setupRewardPower(_ power: Int) -> Void {
        let headAtt: NSAttributedString = NSAttributedString.init(string: "获得", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x202A46), NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 16)])
        let tailAtt: NSAttributedString = NSAttributedString.init(string: "矿力", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x202A46), NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 16)])
        let powerAtt: NSAttributedString = NSAttributedString.init(string: " +\(power) ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x00BDD2), NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 24, weight: .medium)])
        let textAtt: NSMutableAttributedString = NSMutableAttributedString()
        textAtt.append(headAtt)
        textAtt.append(powerAtt)
        textAtt.append(tailAtt)
        self.promptControl.secondLabel.attributedText = textAtt
    }

}

// MARK: - Event Function
extension AutoSignInPopView {

}

// MARK: - Extension Function
extension AutoSignInPopView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension AutoSignInPopView {

}
