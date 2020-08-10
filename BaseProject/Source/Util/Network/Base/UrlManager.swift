//
//  UrlManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/21.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  URL管理

import Foundation

open class UrlManager: NSObject {

    /// 代签版本更新链接
    static let signatureUpdateUrl: String = AppConfig.share.serverAddr.address + URLPathManager.signatureUpdate


    /// 通过文件名构造文件路径
    static func strFileUrl(name fileName: String?) -> String? {
        guard let domatin = AppConfig.share.server?.cdnDomain, !domatin.isEmpty, let fileName = fileName, !fileName.isEmpty else {
            return nil
        }
        let strUrl: String
        if domatin.hasSuffix("/") {
            strUrl = String(format: "%@%@", domatin, fileName)
        } else {
            strUrl = String(format: "%@/%@", domatin, fileName)
        }
        return strUrl
    }
    @objc public static func strImageUrl(name fileName: String?) -> String? {
        return self.strFileUrl(name: fileName)
    }
    static func strVideoUrl(name fileName: String?) -> String? {
        return self.strFileUrl(name: fileName)
    }

    /// 通过文件名构造文件URL
    @objc static func fileUrl(name fileName: String?) -> URL? {
        guard let strUrl = self.strFileUrl(name: fileName), let url = URL.init(string: strUrl) else {
            return nil
        }
        return url
    }
    static func imageUrl(name fileName: String?) -> URL? {
        return self.fileUrl(name: fileName)
    }
    static func videoUrl(name fileName: String?) -> URL? {
        return self.fileUrl(name: fileName)
    }

    /// 资源根地址：
    static let resourceAddress: String = "http://resource.immeet.com/"
    /// 用户协议链接
    static let strAgreementUrl: String = UrlManager.resourceAddress + "imeet/agreement.html"
    /// 邀请规则链接
    static let strInviteRuleUrl: String = UrlManager.resourceAddress + "imeet/invite-rule.html"
    /// 等级规则链接
    static let strLevelRuleUrl: String = UrlManager.resourceAddress + "imeet/level-rule.html"
    /// h5注册链接
    static let strRegisterUrl: String = UrlManager.resourceAddress + "imeet/register.html"
    /// h5下载页链接
    static let strDownloadUrl: String = UrlManager.resourceAddress + "imeet/download.html"


}

class URLPathManager {
    struct Version {
        static let v0: String = "api/"
        static let v1: String = "api/v1/"
    }

    static let fileUpload: String = "upload"
    static let avatarUpload: String = "user/avatar"

    static let invite: String = "invite/"

    /// 分享注册路由
    static let shareRegister: String = "share/quick/register/"

    /// 代签版本更新路由
    static let signatureUpdate: String = "share/ios/install"

}
