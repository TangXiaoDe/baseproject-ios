//
//  ThemeConfig.swift
//  BaseProject
//
//  Created by 小唐 on 2019/5/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  App主题配置
//  App的主题相关：背景、颜色、等
//  本App有多个主题，可切换
/**
 主题切换涉及到的部分：(待UI沟通与统计)
 
 经确认，通用页暂无主题切换功能，该页面保留，具体处可写死
 
 **/

import Foundation

/// App主题分类
enum AppThemeType {
    case `default`
    case light
    case dark
}

/// App主题配置
typealias AppThemeConfig = ThemeConfig
/// App主题配置
class ThemeConfig {

    static let `default`: ThemeConfig = ThemeConfig.init(type: .default)
    static let light: ThemeConfig = ThemeConfig.init(type: .light)
    static let dark: ThemeConfig = ThemeConfig.init(type: .dark)

    init(type: AppThemeType) {
        switch type {
        case .light:
            break
        case .dark:
            break
        case .default:
            break
        }
    }

    /// 主题色
    var themeColor: UIColor = UIColor.init(hex: 0x6EEEFC)
    /// 辅助色/次要色
    var minorColor: UIColor = UIColor.init(hex: 0x2D385C)
    /// 分割线颜色
    var dividingColor: UIColor = UIColor.init(hex: 0x35426A)

    /// 标题色(页面)
    var titleColor: UIColor = UIColor.white
    /// 正文颜色
    var mainTextColor: UIColor = UIColor.white
    /// 详情颜色
    var detailTextColor: UIColor = UIColor.white

    /// 页面背景色(占位色)
    var pageBgColor: UIColor = UIColor.init(hex: 0x202A46)
    /// 图片背景色(占位色)
    var imgBgColor: UIColor = UIColor.init(hex: 0x000000).withAlphaComponent(0.3)

    /// 不可用颜色
    var disableColor: UIColor = UIColor.init(hex: 0x35426A)
    /// 文字不可用颜色
    var disableTitleColor: UIColor = UIColor.init(hex: 0x8C97AC)

    /// 输入框背景色
    var inputBgColor: UIColor = UIColor.init(hex: 0x202A46)
    /// 输入框PlaceHolder文字颜色
    var inputPlaceColor: UIColor = UIColor.init(hex: 0x525C6E)

    /// 导航栏背景色
    var navBgColor: UIColor = UIColor.init(hex: 0x2D385C)
    /// 导航栏标题色
    var navTitleColor: UIColor = UIColor.init(hex: 0xFFFFFF)
    /// 导航栏item颜色
    var navItemColor: UIColor = UIColor.init(hex: 0xFFFFFF)

    /// 标签栏背景色
    var tabBgColor: UIColor = UIColor.init(hex: 0x2D385C)
    /// 标签栏未选中色
    var tabUnSelectedColor: UIColor = UIColor.init(hex: 0x8C97AC)
    /// 标签栏选中色
    var tabSelectedColor: UIColor = UIColor.init(hex: 0x6EEEFC)

}
