//
//  KKingfisher+Extension.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/10.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  Kingfisher的扩展

import Foundation
import Kingfisher

extension ImageCache {
    // 单例获取
    // ImageCache.default
    // KingfisherManager.shared.cache

    /// 从kf缓存中获取图片
    func cacheWith(url imageUrl: String, options: KingfisherOptionsInfo? = nil) -> UIImage? {
        // 方案1
        if let image = self.retrieveImageInMemoryCache(forKey: imageUrl, options: options) {
            return image
        } else if let image = self.retrieveImageInDiskCache(forKey: imageUrl, options: options) {
            return image
        }
        return nil

//        // 方案2 先判断是否存在
//        let cacheResult = self.imageCachedType(forKey: imageUrl)
//        var image: UIImage?
//        if cacheResult.cached {
//            switch cacheResult {
//            case .memory:
//                image = self.retrieveImageInMemoryCache(forKey: imageUrl, options: options)
//            case .disk:
//                image = self.retrieveImageInDiskCache(forKey: imageUrl, options: options)
//            default:
//                break
//            }
//        }
//        return image
    }

}
