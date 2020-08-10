//
//  LabelTestView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class LabelTestView: UIView {

    // MARK: - Internal Property

    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }


    // MARK: - Private Property
    let textLabel: UILabel = UILabel()

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
extension LabelTestView {
    class func loadXib() -> LabelTestView? {
        return Bundle.main.loadNibNamed("LabelTestView", owner: nil, options: nil)?.first as? LabelTestView
    }
}

// MARK: - LifeCircle Function
extension LabelTestView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }

    /// 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
// MARK: - Private UI 手动布局
extension LabelTestView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.textLabel)
        self.textLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 15), textColor: UIColor.white)
        self.textLabel.numberOfLines = 0
        self.textLabel.isUserInteractionEnabled = true
        self.textLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
        }
        // longpressGR
        let longPressGR = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGRProcess(_:)))
        longPressGR.minimumPressDuration = 0.5
        self.textLabel.addGestureRecognizer(longPressGR)
    }

}
// MARK: - Private UI Xib加载后处理
extension LabelTestView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension LabelTestView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let model = model else {
            return
        }
        // 子控件数据加载
        self.textLabel.text = model
    }

}

// MARK: - Event Function
extension LabelTestView {
    @objc fileprivate func longPressGRProcess(_ longPressGR: UILongPressGestureRecognizer) -> Void {
        if longPressGR.state == .began {
            // 显示弹窗
            self.showLabelMenu()
        }
    }

}

// MARK: - MenuController
extension LabelTestView {
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //print(action)
        //        cut:
        //        copy:
        //        select:
        //        selectAll:
        //        paste:
        //        delete:
        //        _promptForReplace:
        //        _transliterateChinese:
        //        _insertDrawing:
        //        _showTextStyleOptions:
        //        _lookup:
        //        _addShortcut:
        //        _accessibilitySpeak:
        //        _accessibilitySpeakLanguageSelection:
        //        _accessibilityPauseSpeaking:
        //        _share:
        //        makeTextWritingDirectionRightToLeft:
        //        makeTextWritingDirectionLeftToRight:
        if action == Selector.init("copy:") || action == Selector.init("select:") || action == Selector.init("selectAll:") {
            return true
        }
        return false
    }

    // 实现可用的对应方法
    /// copy
    override func copy(_ sender: Any?) {

    }
    /// 选中
    override func select(_ sender: Any?) {

    }
    /// 全选
    override func selectAll(_ sender: Any?) {

    }

}


// MARK: - Extension Function
extension LabelTestView {
    fileprivate func showLabelMenu() -> Void {
        print("LabelTestView showLabelMenu")
        // 成为第一响应者
        self.becomeFirstResponder()
        // 设置菜单显示的位置 frame设置其文职 inView设置其所在的视图
        let menuFrame: CGRect = CGRect.init(x: 50, y: -40, width: 100, height: 35)
        UIMenuController.shared.setTargetRect(menuFrame, in: self)
        // 自定义menuItem
        //UIMenuController.shared.menuItems = []
        //// 关闭显示，为之后的显示作准备
        //UIMenuController.shared.isMenuVisible = false
        // 将菜单控件设置为可见
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension LabelTestView {

}
