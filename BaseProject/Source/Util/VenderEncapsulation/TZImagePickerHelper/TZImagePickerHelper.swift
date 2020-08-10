//
//  TZImagePickerHelper.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/1.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  TZImagePickerController助手

import Foundation
import TZImagePickerController

/// TZImagePickerHelper
class TZImagePickerHelper {
    /// 获取头像的选择器，会自动裁剪
    class func getAvatarPicker(delegate: TZImagePickerControllerDelegate) -> TZImagePickerController? {
        guard let imagePickerVC = TZImagePickerController(maxImagesCount: 1, columnNumber: 4, delegate: delegate)
            else {
                return nil
        }
        //设置默认为中文，不跟随系统
        imagePickerVC.preferredLanguage = "zh-Hans"
        imagePickerVC.maxImagesCount = 1
        imagePickerVC.isSelectOriginalPhoto = true
        imagePickerVC.allowTakePicture = true
        imagePickerVC.allowCameraLocation = false   // 取消定位(避免首次尴尬的弹窗)
        imagePickerVC.allowPickingVideo = false
        imagePickerVC.allowPickingImage = true
        imagePickerVC.allowPickingGif = true
        imagePickerVC.allowPickingMultipleVideo = false
        imagePickerVC.allowPickingOriginalPhoto = true
        imagePickerVC.sortAscendingByModificationDate = false
        // 导航栏样式
        imagePickerVC.statusBarStyle = .lightContent
        imagePickerVC.naviTitleColor = UIColor.white
        imagePickerVC.barItemTextColor = UIColor.white
        imagePickerVC.setNavBarTheme(titleFont: UIFont.pingFangSCFont(size: 18, weight: .medium), titleColor: UIColor.white, tintColor: UIColor.white, barTintColor: UIColor.init(hex: 0x2D385C), isTranslucent: false, bgImage: UIImage(), shadowColor: UIColor.init(hex: 0x202A46))
        // 裁剪 单选模式, maxImagesCount为1时才生效
        imagePickerVC.showSelectBtn = false
        imagePickerVC.allowCrop = true  // 允许裁剪,默认为YES，showSelectBtn为NO才生效
        imagePickerVC.scaleAspectFillCrop = true // 照片尺寸小于裁剪框时会自动放大撑满
        let cropWH: CGFloat = 300
        imagePickerVC.cropRect = CGRect.init(x: (kScreenWidth - cropWH) * 0.5, y: (kScreenHeight - cropWH) * 0.5, width: cropWH, height: cropWH)
        imagePickerVC.notScaleImage = true
        return imagePickerVC
    }

    /// 图片选择器
    class func getImagePicker(count: Int, delegate: TZImagePickerControllerDelegate) -> TZImagePickerController? {
        guard let imagePickerVC = TZImagePickerController.init(maxImagesCount: count, columnNumber: 4, delegate: delegate) else {
            return nil
        }
        //设置默认为中文，不跟随系统
        imagePickerVC.preferredLanguage = "zh-Hans"
        imagePickerVC.maxImagesCount = count
        imagePickerVC.isSelectOriginalPhoto = false
        imagePickerVC.allowTakePicture = true
        imagePickerVC.allowCameraLocation = false   // 取消定位(避免首次尴尬的弹窗)
        imagePickerVC.allowPickingVideo = false
        imagePickerVC.allowPickingImage = true
        imagePickerVC.allowPickingGif = true
        imagePickerVC.allowPickingMultipleVideo = false
        imagePickerVC.allowPickingOriginalPhoto = false
        imagePickerVC.sortAscendingByModificationDate = false
        // 导航栏样式
        imagePickerVC.statusBarStyle = .lightContent
        imagePickerVC.naviTitleColor = UIColor.white
        imagePickerVC.barItemTextColor = UIColor.white
        imagePickerVC.setNavBarTheme(titleFont: UIFont.pingFangSCFont(size: 18, weight: .medium), titleColor: UIColor.white, tintColor: UIColor.white, barTintColor: UIColor.init(hex: 0x2D385C), isTranslucent: false, bgImage: UIImage(), shadowColor: UIColor.init(hex: 0x202A46))
        return imagePickerVC
    }
    /// 图片选择器 会裁剪
    //class func getImagePickerWithCrop(size: CGSize) -> TZImagePickerController {}

    /// 视频选择
    class func getVideoPicker(delegate: TZImagePickerControllerDelegate) -> TZImagePickerController? {
        guard let imagePickerVC = TZImagePickerController(maxImagesCount: 1, columnNumber: 4, delegate: delegate, pushPhotoPickerVc: true) else {
            return nil
        }
        imagePickerVC.isSelectOriginalPhoto = false
        imagePickerVC.allowTakePicture = true
        imagePickerVC.allowCameraLocation = false   // 取消定位(避免首次尴尬的弹窗)
        imagePickerVC.allowPickingVideo = true
        imagePickerVC.allowPickingImage = false
        imagePickerVC.allowPickingGif = false
        imagePickerVC.allowPickingMultipleVideo = false
        imagePickerVC.sortAscendingByModificationDate = false
        imagePickerVC.videoMaximumDuration = 30     // 视频拍摄最大时长(秒为单位)
        // 导航栏样式
        imagePickerVC.statusBarStyle = .lightContent
        imagePickerVC.naviTitleColor = UIColor.white
        imagePickerVC.barItemTextColor = UIColor.white
        imagePickerVC.setNavBarTheme(titleFont: UIFont.pingFangSCFont(size: 18, weight: .medium), titleColor: UIColor.white, tintColor: UIColor.white, barTintColor: UIColor.init(hex: 0x2D385C), isTranslucent: false, bgImage: UIImage(), shadowColor: UIColor.init(hex: 0x202A46))
        return imagePickerVC
    }

    /// present显示
    class func present(_ imagePicker: TZImagePickerController, animated: Bool, completion: (() -> Void)?) -> Void {
        DispatchQueue.main.async {
            // leftmenuVC及子控制器下直接present出的选择器在返回上级界面后导航栏异常(没有取消和标题)，
            // 注1：leftmenu下仅CurrentUserInfoController和RealNameCertController有该异常，
            // 注2：leftmenu的任务中心进入的子控制器present有该异常；
            // 注3：leftmenu下的其他可能导致进入的界面中present是否有该问题未知；
            // 但tabbar下的子控制器直接present又正常，rootVC类present又显示正常；
            // 为解决present异常问题，故leftmenu下统一使用root来present解决；
//            RootManager.share.rootVC.present(imagePicker, animated: true, completion: nil)

            // leftmenu改版后的弹窗
            RootManager.share.topRootVC.present(imagePicker, animated: true, completion: nil)
        }
    }

}
