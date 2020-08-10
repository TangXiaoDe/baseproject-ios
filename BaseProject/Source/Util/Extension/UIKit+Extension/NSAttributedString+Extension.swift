//
//  NSAttributedString+Extension.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/14.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import UIKit


extension NSAttributedString {

    /// 快捷属性
    class func attribute(str: String, font: UIFont, color: UIColor) -> NSAttributedString {
        let attText: NSAttributedString = NSAttributedString.init(string: str, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        return attText
    }
    class func attribute(_ atts: [(str: String, font: UIFont, color: UIColor)]) -> NSAttributedString {
        let mutableAtt: NSMutableAttributedString = NSMutableAttributedString.mutableAttribute(atts)
        let attText: NSAttributedString = NSAttributedString.init(attributedString: mutableAtt)
        return attText
    }


}

extension NSMutableAttributedString {

    /// 快捷属性
    class func mutableAttribute(str: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attText: NSMutableAttributedString = NSMutableAttributedString.init(string: str, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        return attText
    }
    class func mutableAttribute(_ atts: [(str: String, font: UIFont, color: UIColor)]) -> NSMutableAttributedString {
        let attText: NSMutableAttributedString = NSMutableAttributedString.init()
        for att in atts {
            let itemAtt = NSAttributedString.init(string: att.str, attributes: [NSAttributedString.Key.font: att.font, NSAttributedString.Key.foregroundColor: att.color])
            attText.append(itemAtt)
        }
        return attText
    }

}
