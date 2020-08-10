//
//  MomentLongPressPopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/28.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  动态长按弹窗 - 显示复制

import UIKit

protocol MomentLongPressPopViewProtocol: BasePopViewProtocol {
    /// 复制点击
    func popView(_ popView: MomentLongPressPopView, didClickedCopy copyBtn: UIButton) -> Void
}

/// 动态长按弹窗
class MomentLongPressPopView: BasePopView {

    // MARK: - Internal Property

    weak var myDelegate: MomentLongPressPopViewProtocol?
    override weak var delegate: BasePopViewProtocol? {
        get {
            return self.myDelegate
        } set {
            self.myDelegate = delegate as? MomentLongPressPopViewProtocol
        }
    }
    var copyBtnClickAction: ((_ popView: MomentLongPressPopView, _ copyBtn: UIButton) -> Void)?

    // MARK: - Private Property
    let copyBtn: UIButton = UIButton.init(type: .custom)
    let location: CGPoint

    fileprivate let lrMinMargin: CGFloat = 12.0 * 2.0
    fileprivate let copyBtnSize: CGSize = CGSize.init(width: 64, height: 43)

    // MARK: - Initialize Function
    init(location: CGPoint) {
        self.location = location
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        //self.commonInit()
        fatalError("init(coder:) has not been implemented")
    }

    /// 通用初始化：UI、配置、数据等
    override func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension MomentLongPressPopView {

}

// MARK: - LifeCircle Function
extension MomentLongPressPopView {

}
// MARK: - Private UI 手动布局
extension MomentLongPressPopView {

    /// 界面布局 - 子类重写
    override func initialUI() -> Void {
        // 1. coverBtn
        self.addSubview(self.coverBtn)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. copyBtn
        self.addSubview(self.copyBtn)
        self.copyBtn.setBackgroundImage(UIImage.init(named: "IMG_icon_moment_copy"), for: .normal)
        self.copyBtn.addTarget(self, action: #selector(copyBtnClick(_:)), for: .touchUpInside)
        self.copyBtn.snp.makeConstraints { (make) in
            make.size.equalTo(self.copyBtnSize)
            make.bottom.equalTo(self.snp.top).offset(self.location.y)
            if self.location.x < self.lrMinMargin + self.copyBtnSize.width * 0.5 {
                make.leading.equalToSuperview().offset(self.lrMinMargin)
            } else if self.location.x > kScreenWidth - self.lrMinMargin - self.copyBtnSize.width * 0.5 {
                make.trailing.equalToSuperview().offset(-self.lrMinMargin)
            } else {
                make.centerX.equalTo(self.snp.leading).offset(self.location.x)
            }
        }
    }
    /// mainView布局 - 子类重写
    override func initialMainView(_ mainView: UIView) -> Void {

    }

}
// MARK: - Private UI Xib加载后处理
extension MomentLongPressPopView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension MomentLongPressPopView {

}

// MARK: - Event Function
extension MomentLongPressPopView {
    /// 遮罩点击
    override func coverBtnClick(_ button: UIButton) -> Void {
        self.delegate?.popView(self, didClickedCover: button)
        self.coverBtnClickAction?(self, button)
    }
    /// 复制按钮点击
    @objc fileprivate func copyBtnClick(_ button: UIButton) -> Void {
        self.myDelegate?.popView(self, didClickedCopy: button)
        self.copyBtnClickAction?(self, button)
    }

}

// MARK: - Extension Function
extension MomentLongPressPopView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension MomentLongPressPopView {

}
