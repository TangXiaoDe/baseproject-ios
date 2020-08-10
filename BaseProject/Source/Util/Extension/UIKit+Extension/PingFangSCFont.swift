//
//  PingFangSCFont.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/9.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  PingFangSC的字体，依赖UIFont的扩展

import Foundation

/// PingFangSC的字体
open class PingFangSCFont {

    class func regular(size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .regular)
    }
    class func regular(_ size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .regular)
    }

    class func medium(size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .medium)
    }
    class func medium(_ size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .medium)
    }

    class func light(size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .light)
    }
    class func light(_ size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .light)
    }

    class func semibold(size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .semibold)
    }
    class func semibold(_ size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .semibold)
    }

    class func ultraLight(size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .ultraLight)
    }
    class func ultraLight(_ size: CGFloat) -> UIFont {
        return UIFont.pingFangSCFont(size: size, weight: .ultraLight)
    }

}
