//
//  BasePopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  弹窗基类

import UIKit

@objc protocol BasePopViewProtocol: class {
    func popView(_ popView: BasePopView, didClickedCover cover: UIButton) -> Void
}
extension BasePopViewProtocol {
    func popView(_ popView: BasePopView, didClickedCover cover: UIButton) -> Void {}
}

class BasePopView: UIView {

    // MARK: - Internal Property

    weak var delegate: BasePopViewProtocol?
    var coverBtnClickAction: ((_ popView: BasePopView, _ cover: UIButton) -> Void)?

    // MARK: - Private Property

    let coverBtn: UIButton = UIButton.init(type: .custom)
    let mainView: UIView = UIView()
    let iconView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let doneBtn: GradientBackgroundButton = GradientBackgroundButton.init(type: .custom)

    var mainLrMargin: CGFloat = 45

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

    /// 通用初始化：UI、配置、数据等
    func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension BasePopView {

}

// MARK: - LifeCircle Function
extension BasePopView {

}
// MARK: - Private UI 手动布局
extension BasePopView {

    /// 界面布局 - 子类可重写
    @objc func initialUI() -> Void {
        // 1. coverBtn
        self.addSubview(self.coverBtn)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. mainView
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.mainLrMargin)
            make.trailing.equalToSuperview().offset(-self.mainLrMargin)
            make.center.equalToSuperview()
        }
    }
    /// mainView布局 - 子类可重写
    @objc func initialMainView(_ mainView: UIView) -> Void {

    }

}
// MARK: - Private UI Xib加载后处理
extension BasePopView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension BasePopView {

}

// MARK: - Event Function
extension BasePopView {
    /// 遮罩点击
    @objc func coverBtnClick(_ button: UIButton) -> Void {
        self.delegate?.popView(self, didClickedCover: button)
        self.coverBtnClickAction?(self, button)
    }

}

// MARK: - Extension Function
extension BasePopView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension BasePopView {

}
