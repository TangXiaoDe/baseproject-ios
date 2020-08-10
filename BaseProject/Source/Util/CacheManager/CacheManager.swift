//
//  CacheManager.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/10.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  缓存管理

import Foundation
import Kingfisher

class CacheManager {
    /// 单例
    static let instance = CacheManager()
    private init() {

    }

    // MARK: - Internal Property

    // MARK: - Private Property

}

// MARK: - Internal Function
extension CacheManager {
    /// 获取缓存大小，返回byte为单位的
    func getCacheSize(_ complete: ((_ cacheSize: UInt) -> Void)? = nil) -> Void {
        let group = DispatchGroup()
        // 三方图片缓存
        var kfImgSize: UInt = 0
        group.enter()
        ImageCache.default.calculateDiskCacheSize { (size) in
            kfImgSize = size
            group.leave()
        }
        // 数据库缓存
        let dbSize: UInt = 0
        // 自定义缓存
        let customSize: UInt = 0

        group.notify(queue: DispatchQueue.main) {
            let cacheSize: UInt = kfImgSize + dbSize + customSize
            complete?(cacheSize)
        }
    }

    /// 清理缓存
    func clearCache() -> Void {
        // 三方图片缓存
        ImageCache.default.clearDiskCache()
        // 数据库缓存
        // 自定义缓存
        // Web缓存
        self.clearWebCookieAndCache()
    }

}

extension CacheManager {

    func clearWebCookieAndCache() -> Void {
        self.clearWebCache()
        self.clearWebCookie()
    }

    /// 清除WebCookie
    func clearWebCookie() -> Void {
        let storage = HTTPCookieStorage.shared
        guard let cookies = storage.cookies else {
            return
        }
        for cookie in cookies {
            storage.deleteCookie(cookie)
        }
    }

    /// 清除WebCache
    func clearWebCache() -> Void {
        let cache = URLCache.shared
        cache.removeAllCachedResponses()
        //cache.diskCapacity = 0
        //cache.memoryCapacity = 0
    }

}

// MARK: - FilePrivate Function
extension CacheManager {

}
