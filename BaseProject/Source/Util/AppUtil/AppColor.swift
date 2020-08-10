//
//  BaseProjectColor.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  项目颜色集合
//  项目颜色来自App主题，即AppConfig.share.theme

import Foundation
import UIKit

/// 项目颜色集合
class AppColor {

    /// 主题色
    static let theme: UIColor = AppConfig.share.theme.themeColor
    /// 辅助色/次要色
    static let minor: UIColor = AppConfig.share.theme.minorColor
    /// 分割线颜色
    static let dividing: UIColor = AppConfig.share.theme.dividingColor

    /// 标题色(页面)
    static let title: UIColor = AppConfig.share.theme.titleColor
    /// 正文颜色
    static let mainText: UIColor = AppConfig.share.theme.mainTextColor
    /// 详情颜色
    static let detailText: UIColor = AppConfig.share.theme.detailTextColor

    /// 页面背景色(占位色)
    static let pageBg: UIColor = AppConfig.share.theme.pageBgColor
    /// 图片背景色(占位色)
    static let imgBg: UIColor = AppConfig.share.theme.imgBgColor

    /// 不可用颜色
    static let disable: UIColor = AppConfig.share.theme.disableColor

    /// 输入框背景色
    static let inputBg: UIColor = AppConfig.share.theme.inputBgColor
    /// 输入框PlaceHolder文字颜色
    static let inputPlace: UIColor = AppConfig.share.theme.inputPlaceColor

    /// 导航栏背景色
    static let navBg: UIColor = AppConfig.share.theme.navBgColor
    /// 导航栏标题色
    static let navTitle: UIColor = AppConfig.share.theme.navTitleColor
    /// 导航栏item颜色
    static let navItem: UIColor = AppConfig.share.theme.navItemColor

    /// 标签栏背景色
    static let tabBg: UIColor = AppConfig.share.theme.tabBgColor
    /// 标签栏未选中色
    static let tabUnSelected: UIColor = AppConfig.share.theme.tabUnSelectedColor
    /// 标签栏选中色
    static let tabSelected: UIColor = AppConfig.share.theme.tabSelectedColor

}
