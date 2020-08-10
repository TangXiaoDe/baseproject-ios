//
//  AdvertDBManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告的数据库管理

import Foundation
import RealmSwift

class AdvertDBManager {

    fileprivate let realm: Realm!

    // MARK: - Lifecycle
    init() {
        let realm = try! Realm()
        self.realm = realm
    }

    /// 删除整个表
    func deleteAll() {
        self.deleteAllAdSpaces()
        self.deleteAllAdverts()
    }

}

// MARK: - 增删改查

extension AdvertDBManager {
    /// 获取指定广告位的所有广告
    func getAdverts(for space: AdvertSpaceType) -> [AdvertModel] {
        var models: [AdvertModel] = []
        let predicate: NSPredicate = NSPredicate(format: "spaceFlag == '\(space.rawValue)'")
        let objects = realm.objects(AdvertObject.self).filter(predicate)
        for object in objects {
            let model = AdvertModel.init(object: object)
            models.append(model)
        }
        return models
    }

    /// 通过类型查询 id
    func getSpaceId(for space: AdvertSpaceType) -> Int? {
        let predicate: NSPredicate = NSPredicate(format: "space == '\(space.rawValue)'")
        let objects = realm.objects(AdvertSpaceObject.self).filter(predicate)
        return objects.first?.id
    }

}

extension AdvertDBManager {
    /// 存储更新所有广告位
    func saveAdSpaces(_ spaces: [AdvertSpaceModel], update: Bool = true) -> Void {
        var objects: [AdvertSpaceObject] = []
        for model in spaces {
            objects.append(model.object())
        }
        try! realm.write {
            // 移除旧的
            if update {
                let oldObjects = realm.objects(AdvertSpaceObject.self)
                realm.delete(oldObjects)
            }
            // 添加新的
            realm.add(objects, update: true)
        }

//        // 该方案也可行
//        // 移除旧的
//        self.deleteAllAdSpaces()
//        // 添加新的
//        var objects: [AdvertSpaceObject] = []
//        for spaceModel in spaces {
//            objects.append(spaceModel.object())
//        }
//        realm.beginWrite()
//        realm.add(objects, update: true)
//        try! realm.commitWrite()
    }
    /// 存储更新指定广告位下所有广告
    func saveAdverts(_ adverts: [AdvertModel], for space: AdvertSpaceType, update: Bool = true) -> Void {
        var objects: [AdvertObject] = []
        for model in adverts {
            objects.append(model.object())
        }
        try! realm.write {
            // 移除旧的
            if update {
                let predicate: NSPredicate = NSPredicate(format: "spaceFlag == '\(space.rawValue)'")
                let oldObjects = realm.objects(AdvertObject.self).filter(predicate)
                realm.delete(oldObjects)
            }
            // 添加新的
            //realm.add(objects, update: true)
            realm.add(objects, update: false)
        }

//        // 该方案也可行
//        // 移除旧的
//        self.deleteAllAdverts(for: space)
//        // 添加新的
//        var objects: [AdvertObject] = []
//        for adModel in adverts {
//            objects.append(adModel.object())
//        }
//        realm.beginWrite()
//        //realm.add(objects, update: true)
//        realm.add(objects, update: false)
//        try! realm.commitWrite()
    }
    /// 存储更新所有广告
    func saveAdverts(_ adverts: [AdvertModel], update: Bool = true) -> Void {
        var objects: [AdvertObject] = []
        for model in adverts {
            objects.append(model.object())
        }
        try! realm.write {
            // 移除旧的
            if update {
                let oldObjects = realm.objects(AdvertObject.self)
                realm.delete(oldObjects)
            }
            // 添加新的
            //realm.add(objects, update: true)
            realm.add(objects, update: false)
        }

//        // 该方案也可行
//        // 移除旧的
//        self.deleteAllAdverts()
//        // 添加新的
//        var objects: [AdvertObject] = []
//        for adModel in adverts {
//            objects.append(adModel.object())
//        }
//        realm.beginWrite()
//        //realm.add(objects, update: true)
//        realm.add(objects, update: false)
//        try! realm.commitWrite()
    }
}

extension AdvertDBManager {
    /// 更新指定广告位下所有广告
    func updateAdverts(_ adverts: [AdvertModel], for space: AdvertSpaceType) -> Void {
        var objects: [AdvertObject] = []
        for adModel in adverts {
            objects.append(adModel.object())
        }
        realm.beginWrite()
        realm.add(objects, update: false) // 无主键，update为false
        try! realm.commitWrite()
    }
}

extension AdvertDBManager {
    /// 删除所有广告位
    fileprivate func deleteAllAdSpaces() -> Void {
        let objects = realm.objects(AdvertSpaceObject.self)
        try! realm.write {
            realm.delete(objects)
        }
    }

    /// 删除所有指定广告位下的广告
    fileprivate func deleteAllAdverts(for space: AdvertSpaceType) -> Void {
        let predicate: NSPredicate = NSPredicate(format: "spaceFlag == '\(space.rawValue)'")
        let objects = realm.objects(AdvertObject.self).filter(predicate)
        try! realm.write {
            realm.delete(objects)
        }
    }
    /// 删除所有广告
    fileprivate func deleteAllAdverts() -> Void {
        let objects = realm.objects(AdvertObject.self)
        try! realm.write {
            realm.delete(objects)
        }
    }
}
