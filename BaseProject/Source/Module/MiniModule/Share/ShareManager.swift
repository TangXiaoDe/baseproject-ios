//
//  ShareManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/26.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  分享内部实现

import UIKit
import MonkeyKing

// MARK: - ShareManager 分享账号管理
class ShareManager: NSObject {

    enum ThirdType {
        case qq
        case wechat
        case weibo
    }

    /// 获取封装号的三方账号信息
    ///
    /// - Parameter type: 三方账号类型，目前有 qq、wechat、weibo 三种类型
    /// - Returns: 封装成 MonkeyKing.Account 类型的三方账号信息
    class func thirdAccout(type: ThirdType) -> MonkeyKing.Account {
        let qq = AppConfig.share.third.qq
        let weibo = AppConfig.share.third.weibo
        let wechat = AppConfig.share.third.wechat
        // 返回对应的账号信息
        var accountMessage: MonkeyKing.Account
        switch type {
        case .qq:
            accountMessage = MonkeyKing.Account.qq(appID: qq.appId)
        case .wechat:
            accountMessage = MonkeyKing.Account.weChat(appID: wechat.appId, appKey: wechat.appKey, miniAppID: nil)
        case .weibo:
            accountMessage = MonkeyKing.Account.weibo(appID: weibo.appId, appKey: weibo.appKey, redirectURL: weibo.redirectURL)
        }
        return accountMessage
    }
}

// MARK: - Share Protocol 分享协议
var accessTokenForWeibo: String? // aceesToken 是和网页登录相关的东西
protocol Sharable {

}

extension Sharable where Self: UIView {
    /**
     匹配字符串中所有的URL
     */
    private func getUrls(str: String) -> [String] {
        var urls = [String]()
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: str.count))
            // 取出结果
            for checkingRes in res {
                urls.append(str.subString(with: checkingRes.range))
            }
        } catch {
            print(error)
        }
        return urls
    }
    func shareURLToWeiboWith(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        if !ShareManager.thirdAccout(type: .weibo).isAppInstalled {
            MonkeyKing.oauth(for: .weibo) { (info, _, error) in
                if let accessToken = info?["access_token"] as? String {
                    accessTokenForWeibo = accessToken
                    self.shareToWechat(URLString: urls.first, image: image, description: description, title: title, complete: complete)
                } else {
                    complete(false)
                }
                print("MonkeyKing.oauth info: \(info), error: \(error)")
            }
        } else {
            shareToWechat(URLString: urls.first, image: image, description: description, title: title, complete: complete)
        }
    }

    func shareURLToQQ(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        if !ShareManager.thirdAccout(type: .qq).isAppInstalled {
            MonkeyKing.oauth(for: .qq) { (info, _, error) in
                if let accessToken = info?["access_token"] as? String {
                    accessTokenForWeibo = accessToken
                    self.shareToQQ(URLString: urls.first, image: image, description: description, title: title, complete: complete)
                } else {
                    complete(false)
                }
                print("MonkeyKing.oauth info: \(info), error: \(error)")
            }
        } else {
            shareToQQ(URLString: urls.first, image: image, description: description, title: title, complete: complete)
        }
    }

    func shareURLToQQZone(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        let info = MonkeyKing.Info(
            title: title,
            description: description,
            thumbnail: image,
            media: .url(URL(string: urls.first!)!)
        )
        MonkeyKing.deliver(MonkeyKing.Message.qq(.zone(info: info))) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("zone result: \(result)")
        }
    }

    func shareURLToWeChatWith(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        let info = MonkeyKing.Info(
            title: title,
            description: description,
            thumbnail: image,
            media: .url(URL(string: urls.first!)!)
        )
        MonkeyKing.deliver(MonkeyKing.Message.weChat(.session(info: info))) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("wechat result: \(result)")
        }
    }

    func shareURLToWeChatMomentsWith(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        let info = MonkeyKing.Info(
            title: title,
            description: description,
            thumbnail: image,
            media: .url(URL(string: urls.first!)!)
        )
        MonkeyKing.deliver(MonkeyKing.Message.weChat(.timeline(info: info))) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("moment result: \(result)")
        }
    }

    // MARL: - Private
    private func shareToQQ(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        let info = MonkeyKing.Info(
            title: title,
            description: description,
            thumbnail: image,
            media: .url(URL(string: urls.first!)!)
        )
        MonkeyKing.deliver(MonkeyKing.Message.qq(.friends(info: info))) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("qq result: \(result)")
        }
    }

    private func shareToWechat(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        let urls = self.getUrls(str: URLString!)
        let message = MonkeyKing.Message.weibo(.default(info: (title: title, description: description, thumbnail: image, media: .url(URL(string: urls.first!)!)), accessToken: nil))
        MonkeyKing.deliver(message) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("weibo result: \(result)")
        }
    }
}
