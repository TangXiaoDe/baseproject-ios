//
//  AdvertNetworkManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告网络请求

import Foundation
import Kingfisher

class AdvertNetworkManager {

}

extension AdvertNetworkManager {

    /// 所有广告位
    class func getAllAdSpaces(complete: @escaping((_ status: Bool, _ msg: String?, _ models: [AdvertSpaceModel]?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AdvertRequestInfo.spaces
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error", nil)
            case .failure(let failure):
                complete(false, failure.message, nil)
            case .success(let response):
                complete(true, response.message, response.models)
            }
        }
    }

    /// 指定广告位下的广告
    /// specialId 专题id，专题广告时需传入专题id
    class func getAdverts(space: AdvertSpaceModel, specialId: Int? = nil, complete: @escaping((_ status: Bool, _ msg: String?, _ models: [AdvertModel]?) -> Void)) -> Void {
        self.getAdverts(spaceId: space.id, spaceFlag: space.space, specialId: specialId, complete: complete)
    }
    class func getAdverts(spaceId: Int, spaceFlag: String, specialId: Int? = nil, complete: @escaping((_ status: Bool, _ msg: String?, _ models: [AdvertModel]?) -> Void)) -> Void {
        // 1.请求 url
        var requestInfo = AdvertRequestInfo.spaceAdverts
        requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
        // 2.配置参数
        let parameter: [String: Any] = ["pos_id": spaceId]
        requestInfo.parameter = parameter
        // 3.发起请求
        NetworkManager.share.request(requestInfo: requestInfo) { (networkResult) in
            switch networkResult {
            case .error(_):
                complete(false, "prompt.network.error", nil)
            case .failure(let failure):
                complete(false, failure.message, nil)
            case .success(let response):
                for model in response.models {
                    model.spaceId = spaceId
                    model.spaceFlag = spaceFlag
                }
                complete(true, response.message, response.models)
            }
        }
    }

}

// 网络请求封装
extension AdvertNetworkManager {
    /// 根据广告位列表获取所有广告
    class func getAllAdverts(spaces: [AdvertSpaceModel], complete: @escaping((_ status: Bool, _ msg: String?, _ models: [AdvertModel]?) -> Void)) -> Void {
        var adList: [AdvertModel] = []
        let group = DispatchGroup()
        for space in spaces {
            group.enter()
            self.getAdverts(space: space) { (status, msg, models) in
                guard status, let models = models else {
                    group.leave()
                    return
                }
                adList.append(contentsOf: models)
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()) {
            complete(true, nil, adList)
        }
    }
}

// MARK: - 广告图片下载
extension AdvertNetworkManager {
    // 下载启动页广告
    class func downloadLaunchAdImages() -> Void {

    }

    // 下载所有广告
    class func downloadAllAdImages() -> Void {

    }
}
