//
//  SelectedAreaModel.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/15.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  地区模型

import Foundation

/// 地区模型(具体的省 市 区)
class SelectedAreaModel {
    // 标题 没有则为nil
    var provinceTitle: String?
    var cityTitle: String?
    var zoneTitle: String?

    // 区域选择时所在的行
    var provinceRow: Int?
    var cityRow: Int?
    var zoneRow: Int?

    // 地区Id(省级Id、市级Id、区级Id)
    var areaId: String
    init(areaId: String) {
        self.areaId = areaId
    }

    func setProvince(title: String, row: Int) -> Void {
        self.provinceTitle = title
        self.provinceRow = row
    }
    func setCity(title: String, row: Int) -> Void {
        self.cityTitle = title
        self.cityRow = row
    }
    func setZone(title: String, row: Int) -> Void {
        self.zoneTitle = title
        self.zoneRow = row
    }
    func setAddressInfo(provinceTilte: String? = nil, provinceRow: Int? = nil, cityTitle: String? = nil, cityRow: Int? = nil, zoneTitle: String? = nil, zoneRow: Int? = nil) -> Void {
        self.provinceTitle = provinceTilte
        self.provinceRow = provinceRow
        self.cityTitle = cityTitle
        self.cityRow = cityRow
        self.zoneTitle = zoneTitle
        self.zoneRow = zoneRow
    }

    // 省市区地址
    func addressWithSeperator(_ seperator: String) -> String {
        var areaString: String = ""
        if let provinceTitle = self.provinceTitle {
            areaString = provinceTitle

            if let cityTitle = self.cityTitle {
                areaString += String(format: "%@%@", seperator, cityTitle)

                if let zoneTitle = self.zoneTitle {
                    areaString += String(format: "%@%@", seperator, zoneTitle)
                }
            }
        }
        return areaString
    }
}
