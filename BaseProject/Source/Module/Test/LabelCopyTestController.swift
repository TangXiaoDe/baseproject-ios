//
//  LabelCopyTestController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  UILabel的拷贝测试界面

import UIKit

/// UILabel的拷贝测试控制器
class LabelCopyTestController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property

    fileprivate let textField: UITextField = UITextField()
    fileprivate let textLabel: UILabel = UILabel()
    fileprivate let labelView: LabelTestView = LabelTestView()


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

// MARK: - LifeCircle & Override Function
extension LabelCopyTestController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

}

extension LabelCopyTestController {
    // MARK: - MenuController

    /// 是否可以成为第一响应者
    override var canBecomeFirstResponder: Bool {
        return true
    }
    /// 是否可以接收某些菜单的某些交互操作
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

// MARK: - UI
extension LabelCopyTestController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.white
        // navbar
        self.navigationItem.title = "LabelCopyTest"
        // textField
        self.view.addSubview(self.textField)
        self.textField.set(placeHolder: "请输入文字", font: UIFont.pingFangSCFont(size: 14), textColor: UIColor.init(hex: 0x333333))
        self.textField.set(cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
        self.textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(35)
        }

        // textLabel
        let labelText: String = "开发者可以在这个方法中通过判断action来确定菜单控件中显示的按钮种类。系统默认为开发者提供了一系列的菜单按钮，例如要显示剪切和赋值操作的菜单按钮"
        self.view.addSubview(self.textLabel)
        self.textLabel.set(text: labelText, font: UIFont.pingFangSCFont(size: 15), textColor: UIColor.init(hex: 0x333333))
        self.textLabel.numberOfLines = 0
        self.textLabel.isUserInteractionEnabled = true
        self.textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.textField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        // longpressGR
        let longPressGR = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGRProcess(_:)))
        longPressGR.minimumPressDuration = 0.5
        self.textLabel.addGestureRecognizer(longPressGR)

        // labelView
        self.view.addSubview(self.labelView)
        self.labelView.backgroundColor = UIColor.init(hex: 0xe2e2e2)
        self.labelView.model = labelText
        self.labelView.snp.makeConstraints { (make) in
            make.top.equalTo(self.textLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }

    }
}

// MARK: - Data(数据处理与加载)
extension LabelCopyTestController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension LabelCopyTestController {
    @objc fileprivate func longPressGRProcess(_ longPressGR: UILongPressGestureRecognizer) -> Void {
        if longPressGR.state == .began {
            // 显示弹窗
            self.showLabelMenu()

        }
    }

}

// MARK: - Enter Page
extension LabelCopyTestController {
    fileprivate func showLabelMenu() -> Void {
        print("LabelCopyTestController showLabelMenu")
        // 成为第一响应者
        self.becomeFirstResponder()
        // 设置菜单显示的位置 frame设置其文职 inView设置其所在的视图
        let menuFrame: CGRect = CGRect.init(x: 25, y: 75, width: 100, height: 35)
        UIMenuController.shared.setTargetRect(menuFrame, in: self.view)
        // 自定义menuItem
        //UIMenuController.shared.menuItems = []
        // 将菜单控件设置为可见
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
}

// MARK: - Notification
extension LabelCopyTestController {

}

// MARK: - Extension Function
extension LabelCopyTestController {

}

// MARK: - Delegate Function

// MARK: - <>
extension LabelCopyTestController {


}
