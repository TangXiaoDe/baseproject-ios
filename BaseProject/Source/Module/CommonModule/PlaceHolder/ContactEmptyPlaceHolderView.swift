//
//  ContactEmptyPlaceHolderView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  通讯录列表为空时的占位图

import UIKit

protocol ContactEmptyPlaceHolderViewProtocol: class {
    /// 确定按钮点击
    func contactHolder(_ placeHolder: ContactEmptyPlaceHolderView, didClickedDone doneBtn: UIButton) -> Void
}

/// 通讯录列表为空时的占位图
class ContactEmptyPlaceHolderView: UIView {

    // MARK: - Internal Property

    let mainView: UIView = UIView()
    let iconView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let doneBtn: GradientBackgroundButton = GradientBackgroundButton()

    /// 回调
    weak var delegate: ContactEmptyPlaceHolderViewProtocol?
    var doneClickAction: ((_ placeHolder: ContactEmptyPlaceHolderView, _ doneBtn: UIButton) -> Void)?

    // MARK: - Private Property

    fileprivate let iconTopMargin: CGFloat = 55
    fileprivate let iconSize: CGSize = CGSize.init(width: 169, height: 142)
    fileprivate let doneBtnH: CGFloat = 44
    fileprivate let doneBtnW: CGFloat = 240

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
extension ContactEmptyPlaceHolderView {
    class func loadXib() -> ContactEmptyPlaceHolderView? {
        return Bundle.main.loadNibNamed("ContactEmptyPlaceHolderView", owner: nil, options: nil)?.first as? ContactEmptyPlaceHolderView
    }
}

// MARK: - LifeCircle Function
extension ContactEmptyPlaceHolderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension ContactEmptyPlaceHolderView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. iconView
        mainView.addSubview(self.iconView)
        self.set(cornerRadius: 0)
        self.iconView.image = UIImage.init(named: "IMG_bg_placeholder_empty_data")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(self.iconSize)
            make.top.equalToSuperview().offset(self.iconTopMargin)
        }
        // 2. titleLabel
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: "暂无内容~", font: UIFont.systemFont(ofSize: 15), textColor: UIColor(hex: 0x8C97AC), alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        // 3. doneBtn
        mainView.addSubview(self.doneBtn)
        self.doneBtn.gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.doneBtnW, height: self.doneBtnH)
        self.doneBtn.set(title: "去添加好友", titleColor: UIColor.white, for: .normal)
        self.doneBtn.set(font: UIFont.pingFangSCFont(size: 18), cornerRadius: 5)
        self.doneBtn.addTarget(self, action: #selector(doneBtnClick(_:)), for: .touchUpInside)
        self.doneBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(self.doneBtnW)
            make.height.equalTo(self.doneBtnH)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(82)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension ContactEmptyPlaceHolderView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension ContactEmptyPlaceHolderView {

}

// MARK: - Event Function
extension ContactEmptyPlaceHolderView {
    @objc fileprivate func doneBtnClick(_ button: UIButton) -> Void {
        self.delegate?.contactHolder(self, didClickedDone: button)
        self.doneClickAction?(self, button)
    }
}

// MARK: - Extension Function
extension ContactEmptyPlaceHolderView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension ContactEmptyPlaceHolderView {

}
