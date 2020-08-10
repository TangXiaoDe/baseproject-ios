//
//  AdvertManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告管理

import Foundation

class AdvertManager {

    static let share = AdvertManager()
    private init() {

    }

    /// 广告下载完成标记

    /// 启动页广告下载完成标记

}

extension AdvertManager {
    // 网络请求更新广告
    func downloadAllAds() -> Void {
        // 1. 广告位
        AdvertNetworkManager.getAllAdSpaces { (status, msg, models) in
            guard status, let spaces = models else {
                return
            }
            // 2. 所有广告位下的广告
            AdvertNetworkManager.getAllAdverts(spaces: spaces) { (status, msg, models) in
                guard status, let models = models else {
                    return
                }
                // 数据库保存
                DataBaseManager().advert.saveAdSpaces(spaces)
                DataBaseManager().advert.saveAdverts(models)
                print("广告下载完成")
                // 下载启动页广告
                self.downloadLaunchAdImages()
            }
        }
    }

}

extension AdvertManager {
    // 下载启动页广告
    func downloadLaunchAdImages() -> Void {

    }

    // 下载所有广告
    func downloadAllAdImages() -> Void {

    }
}
