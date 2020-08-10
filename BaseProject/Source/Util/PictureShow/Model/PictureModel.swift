//
//  PictureModel.swift
//  ThinkSNSPlus
//
//  Created by 小唐 on 28/06/2018.
//  Copyright © 2018 ZhiYiCX. All rights reserved.
//
//  图片的数据模型

import Foundation

class PictureModel {

    /// 图片id
    var pictureId: Int = 0
    /// 图片名称
    var pictureName: String = ""
    /// 图片原始的大小
    var originalSize: CGSize = CGSize.zero
    /// 图片类型
    var mimeType: String = ""

    /// 图片网络连接
    var strUrl: String?
    /// 图片缓存地址
    var cache: String?
    /// 加载图片时是否要清空旧的图片缓存
    var clearCacheFlag: Bool = false
    /// 是否需要显示图片标识
    var showIconIdentify: Bool = true
    /// 没有被显示的图片的数量，小于 0 则不显示数量蒙层
    var unshowCount: Int = 0

//    /// 动态图片节点构造
//    init(imageNode: MomentImageModel) {
//        self.pictureName = imageNode.filename
//        self.originalSize = imageNode.size
//        self.mimeType = imageNode.mime
//        self.strUrl = imageNode.strUrl
//    }
//    init(filename: String, size: CGSize, mime: String, strUrl: String?) {
//        self.pictureName = filename
//        self.originalSize = size
//        self.mimeType = mime
//        self.strUrl = strUrl
//    }
//    init(imageModel: PublishImageModel) {
//        self.pictureName = imageModel.filename
//        self.originalSize = CGSize.init(width: imageModel.width, height: imageModel.height)
//        self.mimeType = imageModel.mime
//        self.strUrl = UrlManager.strFileUrl(name: imageModel.filename)
//    }

}
