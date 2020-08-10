//
//  UIView+Corner.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    /**
     按钮的圆角设置
     @param corners UIRectCorner 要切除的圆角
     @param selfSize CGSize 当前视图的尺寸     // 对于自动布局的视图，需考虑布局完成、数据加载时才确认尺寸
     @param cornerRadius CGFloat 圆角半径
     @param borderWidth CGFloat 边框宽度
     @param borderColor UICOlor 边框颜色
     */
    func setupCorners(_ corners: UIRectCorner, selfSize: CGSize, cornerRadius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> Void {
        let rect: CGRect = CGRect.init(origin: CGPoint.zero, size: selfSize)
        let maskLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
        maskLayer.path = path.cgPath
        maskLayer.frame = rect

        let borderLayer: CAShapeLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = rect
        self.layer.mask = maskLayer
        self.layer.addSublayer(borderLayer)
    }

}
