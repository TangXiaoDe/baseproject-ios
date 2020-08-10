//
//  TestTextView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class TestTextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

//    var copyAction: ((_ text: String?) -> Void)?



}

// MARK: - MenuController
extension TestTextView {
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

//    // 实现可用的对应方法
//    /// copy
//    override func copy(_ sender: Any?) {
//
//    }
//    /// 选中
//    override func select(_ sender: Any?) {
//
//    }
//    /// 全选
//    override func selectAll(_ sender: Any?) {
//
//    }

}
