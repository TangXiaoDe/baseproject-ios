//
//  TextViewTestController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  TextViewCopyTest

import UIKit
import YYKit

class TextViewTestController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property

    fileprivate let textField: UITextField = UITextField()
    fileprivate let textView: UITextView = UITextView()
    fileprivate let yyTextView: YYTextView = YYTextView.init()
    fileprivate let testTextView: TestTextView = TestTextView()


    let content: String = "开发者可以在这个方法中通过判断action来确定菜单控件中显示的按钮种类。系统默认为开发者提供了一系列的菜单按钮，例如要显示剪切和赋值操作的菜单按钮\n开发者可以在这个方法中通过判断action来确定菜单控件中显示的按钮种类。系统默认为开发者提供了一系列的菜单按钮，例如要显示剪"


    fileprivate let lrMargin: CGFloat = 15
    fileprivate let textFont: UIFont = UIFont.pingFangSCFont(size: 16, weight: .regular)
    //fileprivate let textFont: UIFont = UIFont.systemFont(ofSize: 16)

    /// 是否折叠
    fileprivate var isFold: Bool = true



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
extension TextViewTestController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

}

extension TextViewTestController {

}

// MARK: - UI
extension TextViewTestController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.white
        // navbar
        self.navigationItem.title = "TextViewCopy"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "伸展", style: .plain, target: self, action: #selector(rightItemClick))

        // textField
        self.view.addSubview(self.textField)
        self.textField.set(placeHolder: "请输入文字", font: UIFont.pingFangSCFont(size: 14), textColor: UIColor.init(hex: 0x333333))
        self.textField.set(cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
        self.textField.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }

        // textView
        self.view.addSubview(self.textView)
        self.textView.isScrollEnabled = false
        self.textView.text = content
        self.textView.font = self.textFont
        self.textView.textColor = UIColor.init(hex: 0x333333)
        self.textView.backgroundColor = UIColor.init(hex: 0xf0f0f0)
        self.textView.textContainerInset = UIEdgeInsets.zero
        //self.textView.isEditable = false
        self.textView.delegate = self
        self.textView.clipsToBounds = true
        self.textView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.top.equalTo(self.textField.snp.bottom).offset(10)
            make.height.equalTo(0)
        }

        // testTextView
        self.view.addSubview(self.testTextView)
        self.testTextView.isScrollEnabled = false
        self.testTextView.text = content
        self.testTextView.font = self.textFont
        self.testTextView.textColor = UIColor.init(hex: 0x333333)
        self.testTextView.backgroundColor = UIColor.init(hex: 0xf0f0f0)
        self.testTextView.textContainerInset = UIEdgeInsets.zero
        self.testTextView.isEditable = false
        //self.testTextView.delegate = self
        self.testTextView.clipsToBounds = true
        self.testTextView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.top.top.equalTo(self.textView.snp.bottom).offset(10)
            make.height.equalTo(0)
        }

        // yyTextView
        self.view.addSubview(self.yyTextView)
        self.yyTextView.isScrollEnabled = false
        self.yyTextView.text = content
        self.yyTextView.font = self.textFont
        self.yyTextView.textColor = UIColor.init(hex: 0x333333)
        self.yyTextView.backgroundColor = UIColor.init(hex: 0xf0f0f0)
        self.yyTextView.textContainerInset = UIEdgeInsets.zero
        self.yyTextView.isEditable = false
        //self.yyTextView.delegate = self
        self.yyTextView.clipsToBounds = true
        self.yyTextView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.top.top.equalTo(self.testTextView.snp.bottom).offset(10)
            make.height.equalTo(0)
        }
    }

}

// MARK: - Data(数据处理与加载)
extension TextViewTestController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        self.isFold = true
        self.setupIsFold(self.isFold)
    }

    fileprivate func setupIsFold(_ isFold: Bool) -> Void {
        let showAll: Bool = !self.isFold
        // fold
        var height1: CGFloat = self.getContentTextHeight1(self.content, showAll: showAll)
        var height2: CGFloat = self.getContentTextHeight2(self.content, showAll: showAll)
        print("height1: \(height1), height2: \(height2)")

        if showAll {
            height1 = self.getContentTextMaxHeight1(self.content)
            height2 = self.getContentTextMaxHeight5(self.content)
        }
        print("height1: \(height1), height2: \(height2)")

        self.textView.snp.updateConstraints { (make) in
            make.height.equalTo(height1)
        }
        self.testTextView.snp.updateConstraints { (make) in
            make.height.equalTo(height2)
        }
        self.yyTextView.snp.updateConstraints { (make) in
            make.height.equalTo(height2)
        }

        if showAll {
            let maxH1 = self.getContentTextMaxHeight1(self.content)
            let maxH2 = self.getContentTextMaxHeight2(self.content)
            let maxH3 = self.getContentTextMaxHeight3(self.content)
            let maxH4 = self.getContentTextMaxHeight4(self.content)
            let maxH5 = self.getContentTextMaxHeight5(self.content)
            print("maxH1: \(maxH1), maxH2: \(maxH2), maxH3: \(maxH3), maxH4: \(maxH4), maxH5: \(maxH5)")
        }

        self.view.layoutIfNeeded()
    }


}

extension TextViewTestController {
    fileprivate func getContentTextHeight1(_ content: String?, showAll: Bool) -> CGFloat {
        guard let content = content, !content.isEmpty else {
            return 0
        }
        let size = content.size(maxSize: CGSize.init(width: kScreenWidth - self.lrMargin * 2, height: CGFloat.max), font: self.textFont, lineMargin: 0)
        let height: CGFloat = CGFloat(ceil(Double(size.height)))
        if showAll {
            return height
        }
        return min(height, 100)
    }

    fileprivate func getContentTextHeight2(_ content: String?, showAll: Bool) -> CGFloat {
        guard let content = content, !content.isEmpty else {
            return 0
        }
        let size = CGSize(width: kScreenWidth - self.lrMargin * 2, height: CGFloat.max)
        let contentContainer: YYTextContainer = YYTextContainer(size: size, insets: UIEdgeInsets.zero)
        contentContainer.maximumNumberOfRows = showAll ? 0 : 4
        let contentLayout: YYTextLayout? = YYTextLayout(container: contentContainer, text: self.getContentTextAttribute(content: content))
        let height = contentLayout?.textBoundingSize.height ?? 0
        return height
    }
    fileprivate func getContentTextAttribute(content: String) -> NSMutableAttributedString {
        let result = content
        let att = NSMutableAttributedString(string:result)
        let allRange = NSRange(location: 0, length: att.length)
        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0xffffff), range: allRange)
        att.addAttributes([NSAttributedString.Key.font: self.textFont], range: allRange)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 0  // 行间距
        att.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: allRange)
        att.addAttributes([NSAttributedString.Key.kern: 1.5], range: allRange)
        return att
    }

}

extension TextViewTestController {
    fileprivate func getContentTextMaxHeight1(_ content: String) -> CGFloat {
        var height: CGFloat = content.size(maxSize: CGSize.init(width: kScreenWidth - self.lrMargin * 2.0, height: CGFloat.max), font: self.textFont, lineMargin: 0).height
        height = CGFloat(ceil(Double(height)))
        return height
    }
    fileprivate func getContentTextMaxHeight2(_ content: String) -> CGFloat {
        var height: CGFloat = self.getContentTextHeight2(content, showAll: true)
        height = CGFloat(ceil(Double(height)))
        return height
    }

    fileprivate func getContentTextMaxHeight3(_ content: String) -> CGFloat {
        var height: CGFloat = self.textView.sizeThatFits(CGSize.init(width: kScreenWidth - self.lrMargin * 2.0, height: CGFloat.max)).height
        height = CGFloat(ceil(Double(height)))
        return height
    }
    fileprivate func getContentTextMaxHeight4(_ content: String) -> CGFloat {
        var height: CGFloat = self.testTextView.sizeThatFits(CGSize.init(width: kScreenWidth - self.lrMargin * 2.0, height: CGFloat.max)).height
        height = CGFloat(ceil(Double(height)))
        return height
    }
    fileprivate func getContentTextMaxHeight5(_ content: String) -> CGFloat {
        var height: CGFloat = self.yyTextView.sizeThatFits(CGSize.init(width: kScreenWidth - self.lrMargin * 2.0, height: CGFloat.max)).height
        height = CGFloat(ceil(Double(height)))
        return height
    }

}

// MARK: - Event(事件响应)
extension TextViewTestController {
    @objc fileprivate func longPressGRProcess(_ longPressGR: UILongPressGestureRecognizer) -> Void {
        if longPressGR.state == .began {
            // 显示弹窗
            self.showLabelMenu()

        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc fileprivate func rightItemClick() -> Void {
        self.isFold = !self.isFold
        self.setupIsFold(self.isFold)
    }

}

// MARK: - Enter Page
extension TextViewTestController {
    fileprivate func showLabelMenu() -> Void {
        print("TextViewTestController showLabelMenu")
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
extension TextViewTestController {

}

// MARK: - Extension Function
extension TextViewTestController {

}

// MARK: - Delegate Function

// MARK: - <>
extension TextViewTestController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false
    }


}
