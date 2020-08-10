//
//  UIImage+Extension.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  UIImage的扩展

import Foundation
import UIKit


extension UIImage {
    // 根据图片的中心点去拉伸图片并返回
    func resizableImage(with point: CGPoint) -> UIImage {
        let top = point.y                           // 顶端盖高度
        let bottom = self.size.height - top - 1.0   // 底端
        let left = point.x                          // 左
        let right = self.size.width - left - 1.0    // 右
        let insets = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        let image = self.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)

        return image
    }

    /// 将 view 的显示效果转成一张 image
    class func getImageFromView(_ view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

}
