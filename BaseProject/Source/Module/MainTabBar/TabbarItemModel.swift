//
//  TabbarItemModel.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/29.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  TabbarItem模型

import Foundation
import UIKit

struct TabbarItemModel {
    var title: String = ""
    var childVC: UIViewController = UIViewController()
    var normalImage: UIImage? = nil
    var selectedImage: UIImage? = nil

    init(title: String, normalImage: UIImage?, selectedImage: UIImage?, childVC: UIViewController) {
        self.title = title
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        self.childVC = childVC
    }

    init(title: String, normalImageName: String, selectedImageName: String, childVC: UIViewController) {
        self.title = title
        self.normalImage = UIImage(named: normalImageName)
        self.selectedImage = UIImage(named: selectedImageName)
        self.childVC = childVC
    }

    // init(title: String, normalImageName: String, selectedImageName: String, childVCName: String)

}
