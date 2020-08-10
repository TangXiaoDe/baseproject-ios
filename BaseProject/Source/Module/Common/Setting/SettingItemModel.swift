//
//  SettingItemModel.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  设置item数据模型

import Foundation

/// SettingItem样式
enum SettingItemType {
    case leftTitle     // 默认样式，所有选项都有一个Title，除centerTitle和rightTitle之外，其余的默认为leftTitle
    case centerTitle
    case rightTitle
    // 此处的right表示右侧的布局，不表示右侧的控件靠右，当然默认靠右，靠左则标记
    case rightSwitch        // leftTitleRightSwitch
    case rightAccessory     // leftTitleRightAccessory
    case rightIcon              // leftTitleRightIconRight(IconRiht)
    case rightIconLeft              // leftTitleRightIconLeft(IconLeft)  
    case rightDetail            // leftTitleRightDetailRight(DetailRight)
    case rightDetailLeft        // leftTitleRightDetailLeft(DetailLeft)
    case rightDetailAccessory   // leftTitleRightDetailAccessory(DetailRight)
    case rightDetailLeftAccessory   // leftTitleRightDetailLeftAccessory(DetailLeft)
    case custom     // 自定义样式，需自定义Cell
}

/// 设置item数据模型
class SettingItemModel {

    var type: SettingItemType = SettingItemType.leftTitle
    var title: String
    var detail: String?
    var rightIcon: UIImage?
    var accessory: UIImage? = UIImage.init(named: "IMG_common_detail")
    var isSwitchOn: Bool = false

    /// 选中状态记录
    var isSelected: Bool = false

    init(type: SettingItemType, title: String, detail: String? = nil, rightIcon: UIImage? = nil, accessory: UIImage? = UIImage.init(named: "IMG_common_detail"), isSwitchOn: Bool = false) {
        self.type = type
        self.title = title
        self.detail = detail
        self.rightIcon = rightIcon
        self.accessory = accessory
        self.isSwitchOn = isSwitchOn
    }

}
