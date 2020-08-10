//
//  AreaManager.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/15.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  地区管理
//  

import Foundation

class AreaManager {
    static let share = AreaManager()
    init() {
        self.loadDataWithLocalFile()
    }

    // 省级列表
    private(set) var provinceList: [AreaItemModel] = []

}

// 构造AreaData
extension AreaManager {

    /// 根据id构造AreaData
    func areaData(withAreaId areaId: String) -> SelectedAreaModel? {
        if self.provinceList.isEmpty {
            return nil
        }
        let areaData = SelectedAreaModel(areaId: areaId)

        // 根据areaId进行省市区遍历
        // 省级遍历
        for (provinceIndex, provinceModel) in self.provinceList.enumerated() {
            // 是省级
            if areaId == provinceModel.id {
                areaData.setProvince(title: provinceModel.title, row: provinceIndex)
                break
            }

            // 市级遍历
            var findFlag = false
            for (cityIndex, cityModel) in provinceModel.childs.enumerated() {
                // 是市级
                if areaId == cityModel.id {
                    areaData.setProvince(title: provinceModel.title, row: provinceIndex)
                    areaData.setCity(title: cityModel.title, row: cityIndex)
                    findFlag = true         // 标记修正
                    break
                }

                // 区级遍历
                for (zoneIndex, zoneModel) in cityModel.childs.enumerated() {
                    // 是区级
                    if areaId == zoneModel.id {
                        areaData.setAddressInfo(provinceTilte: provinceModel.title, provinceRow: provinceIndex, cityTitle: cityModel.title, cityRow: cityIndex, zoneTitle: zoneModel.title, zoneRow: zoneIndex)
                        findFlag = true         // 标记修正
                        break
                    }
                }

                // 找到的是区级的
                if findFlag {
                    break
                }
            }

            // 找到了，可能是区级，也可能是市级
            if findFlag {
                break
            }
        }
        return areaData
    }

    /// 根据地址字符串和分隔符构造AreaData
    func areaData(withAddress address: String, separator: String = ",") -> SelectedAreaModel? {
        if self.provinceList.isEmpty {
            return nil
        }

        let addressTitleList = address.components(separatedBy: separator)
        if addressTitleList.count != 3 {
            return nil
        }
        let provinceTitle = addressTitleList[0]
        let cityTitle = addressTitleList[1]
        let zoneTitle = addressTitleList[2]

        // 根据title进行省市区遍历
        var areaData: SelectedAreaModel? = nil
        var findFlag = false
        // 省级遍历
        for (provinceIndex, provinceModel) in self.provinceList.enumerated() {
            if provinceModel.title == provinceTitle {

                // 市级遍历
                for (cityIndex, cityModel) in provinceModel.childs.enumerated() {
                    if cityModel.title == cityTitle {

                        // 区级遍历
                        for (zoneIndex, zoneModel) in cityModel.childs.enumerated() {
                            if zoneModel.title == zoneTitle {
                                areaData = SelectedAreaModel(areaId: zoneModel.id)
                                areaData?.setAddressInfo(provinceTilte: provinceModel.title, provinceRow: provinceIndex, cityTitle: cityModel.title, cityRow: cityIndex, zoneTitle: zoneModel.title, zoneRow: zoneIndex)
                                findFlag = true         // 标记修正
                            }
                            // 区级遍历跳出
                            if findFlag {
                                break
                            }
                        }

                    }
                    // 市级遍历跳出
                    if findFlag {
                        break
                    }
                }

            }
            // 省级遍历跳出
            if findFlag {
                break
            }

        }

        return areaData
    }
}

// 数据加载
extension AreaManager {
    /// 从本地文件加载
    func loadDataWithLocalFile() -> Void {
        // 1. 获取文件路径
        guard let filePath = Bundle.main.path(forResource: "Address", ofType: "json") else {
            return
        }
        // 2. 通过文件路径创建Data
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            // 3.序列化 data -> dicInfo
            if let dicInfo = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                self.loadData(with: dicInfo)
            }
        } catch(let error) {
            // 异常处理
            print(error)
        }

    }
    func loadDataWithNetwork() -> Void {

    }

    /// 数据加载
    fileprivate func loadData(with dicInfo: [String: Any]) -> Void {
        var provinceList: [AreaItemModel] = []
        // 省级遍历
        for (provinceKey, provinceDic) in dicInfo {
            if let provinceDic = provinceDic as? [String: Any], let provinceTitle = provinceDic["name"] as? String, let provinceChilds = provinceDic["child"] as? [String: Any] {
                let provinceModel = AreaItemModel(id: provinceKey, parentId: "", title: provinceTitle)

                var cityList: [AreaItemModel] = []
                // 市级遍历
                for (cityKey, cityDic) in provinceChilds {
                    if let cityDic = cityDic as? [String: Any], let cityTitle = cityDic["name"] as? String, let cityChilds = cityDic["child"] as? [String: String] {
                        let cityModel = AreaItemModel(id: cityKey, parentId: provinceModel.id, title: cityTitle)

                        var zoneList: [AreaItemModel] = []
                        // 区级遍历
                        for (zoneKey, zoneTitle) in cityChilds {
                            let zoneModel = AreaItemModel(id: zoneKey, parentId: cityModel.id, title: zoneTitle)
                            zoneList.append(zoneModel)
                        }
                        /// 区级排序
                        zoneList.sort { (item1, item2) -> Bool in
                            guard let item1Id = Int(item1.id), let item2Id = Int(item2.id) else {
                                return true
                            }
                            return item1Id < item2Id
                        }
                        cityModel.childs = zoneList
                        cityList.append(cityModel)
                    }
                }
                /// 市级排序
                cityList.sort { (item1, item2) -> Bool in
                    guard let item1Id = Int(item1.id), let item2Id = Int(item2.id) else {
                        return true
                    }
                    return item1Id < item2Id
                }
                provinceModel.childs = cityList
                provinceList.append(provinceModel)
            }
        }
        /// 省级排序
        provinceList.sort { (item1, item2) -> Bool in
            guard let item1Id = Int(item1.id), let item2Id = Int(item2.id) else {
                return true
            }
            return item1Id < item2Id
        }
        self.provinceList = provinceList
    }

}

// 数据保存
extension AreaManager {
    func storeData() -> Void {

    }
}
