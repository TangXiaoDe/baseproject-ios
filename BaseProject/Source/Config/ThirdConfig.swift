//
//  ThirdConfig.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/29.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  三方配置
//  三方配置应可通过json加载、文件加载；

import Foundation
import ObjectMapper

/// 三方配置加载器
class ThirdConfigLoader {
    /// 从文件加载
    class func loadFromFile(file: String) -> ThirdConfig? {
        if let bundlePath = Bundle.main.path(forAuxiliaryExecutable: file), let dicData = NSDictionary(contentsOfFile: bundlePath) as? Dictionary<String, Any>, let model = Mapper<ThirdConfig>().map(JSON: dicData) {
            return model
        } else {
            return nil
        }
    }
}

/// 三方配置
struct ThirdConfig: Mappable {

    static let develop: ThirdConfig = ThirdConfig(file: "ThirdConfig_develop.plist")!
    static let release: ThirdConfig = ThirdConfigLoader.loadFromFile(file: "ThirdConfig_release.plist")!

    // 分享
    var qq: ThirdCommonConfigModel = ThirdCommonConfigModel()
    var wechat: WechatConfigModel = WechatConfigModel()
    var weibo: SinaWeiboConfigModel = SinaWeiboConfigModel()

    // AppId
    // AppKey
    var amap: ThirdAppKeyConfigModel = ThirdAppKeyConfigModel()
    var jpush: ThirdAppKeyConfigModel = ThirdAppKeyConfigModel()
    var umeng: ThirdAppKeyConfigModel = ThirdAppKeyConfigModel()
    // AppId + AppKey
    var bugly: ThirdCommonConfigModel = ThirdCommonConfigModel()

    // 自定义类别
    var tcCaptcha: TCCaptchaConfigModel = TCCaptchaConfigModel()
    var youzan: YouZanConfigModel = YouZanConfigModel()
    var easemob: EaseMobConfigModel = EaseMobConfigModel()

    init() {

    }
    /// 通过文件加载
    init?(file: String) {
        if let bundlePath = Bundle.main.path(forAuxiliaryExecutable: file), let dicData = NSDictionary(contentsOfFile: bundlePath) as? Dictionary<String, Any> {
            self.loadData(json: dicData)
        } else {
            fatalError("默认环境配置文件格式错误,查看文档 ./ProjectTemplate-Swift/Resource/Document/应用配置说明.md")
        }
    }
    /// 通过json加载
    init(json: [String: Any]) {
        self.loadData(json: json)
    }
    /// 从json中加载数据
    fileprivate mutating func loadData(json: [String: Any]) -> Void {
        self.qq = Mapper<ThirdCommonConfigModel>().map(JSONObject: json["qq"]) ?? self.qq
        self.wechat = Mapper<WechatConfigModel>().map(JSONObject: json["wechat"]) ?? self.wechat
        self.weibo = Mapper<SinaWeiboConfigModel>().map(JSONObject: json["sinaweibo"]) ?? self.weibo
        self.amap = Mapper<ThirdAppKeyConfigModel>().map(JSONObject: json["amap"]) ?? self.amap
        self.jpush = Mapper<ThirdAppKeyConfigModel>().map(JSONObject: json["jpush"]) ?? self.jpush
        self.umeng = Mapper<ThirdAppKeyConfigModel>().map(JSONObject: json["uMeng"]) ?? self.umeng
        self.bugly = Mapper<ThirdCommonConfigModel>().map(JSONObject: json["bugly"]) ?? self.bugly
        self.tcCaptcha = Mapper<TCCaptchaConfigModel>().map(JSONObject: json["tccaptcha"]) ?? self.tcCaptcha
        self.youzan = Mapper<YouZanConfigModel>().map(JSONObject: json["youzan"]) ?? self.youzan
        self.easemob = Mapper<EaseMobConfigModel>().map(JSONObject: json["easemob"]) ?? self.easemob
    }

    /// 通过ObjectMapper加载
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        qq <- map["qq"]
        wechat <- map["wechat"]
        weibo <- map["sinaweibo"]
        amap <- map["amap"]
        jpush <- map["jpush"]
        umeng <- map["umeng"]
        bugly <- map["bugly"]
        tcCaptcha <- map["tccaptcha"]
        youzan <- map["youzan"]
        easemob <- map["easemob"]
    }

}
