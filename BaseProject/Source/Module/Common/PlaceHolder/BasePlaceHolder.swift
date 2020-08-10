//
//  BasePlaceHolder.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  占位图

import Foundation
import UIKit

typealias BasePlaceHolder = BasePlaceHolderView
class BasePlaceHolderView: UIView {

}


class PlaceHolderSampleView: UIView {
    //    var placeHolder: UIView
    //    var showPlaceHolder: Bool = false
}


//public protocol ViewPlaceHolder {
//    /// How the placeholder should be added to a given view.
//    func add(to view: UIView)
//    /// How the placeholder should be removed from a given view.
//    func remove(from view: UIView)
//}
//
//extension ViewPlaceHolder where Self: UIView {
//
//    /// How the placeholder should be added to a given image view.
//    public func add(to view: UIView) {
//        view.addSubview(self)
//        self.snp.makeConstraints { (make) in
//            make.edges.width.height.equalToSuperview()
//        }
//    }
//
//    /// How the placeholder should be removed from a given image view.
//    public func remove(from view: UIView) {
//        self.removeFromSuperview()
//    }
//}
//
//extension UIView: ViewPlaceHolder {}
