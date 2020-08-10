//
//  BaseTableViewCell.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//

import UIKit

/// TableViewCell选中状态
enum TableViewCellSelectedType {
    /// 选中状态
    case selected
    /// 未选中状态
    case notselected
    /// 不可选中状态
    case disable    // unselected
}

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
