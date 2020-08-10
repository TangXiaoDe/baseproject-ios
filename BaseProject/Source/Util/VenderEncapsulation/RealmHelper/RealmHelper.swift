//
//  RealmHelper.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/10.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Realm助手

import Foundation
import RealmSwift

class RealmHelper {
    /// 移除所有文件及辅助文件
    class func removeAllFiles() -> Void {
        // 直接删除所有文件
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                // 错误处理
            }
        }
    }

    /// 数据库的具体迁移
    class func dataMigration(_ migration: Migration, _ oldSchemaVersion: UInt64) -> Void {
        // 属性 新增、删除、重命名
        // 类型 增加、删除

    }




}
