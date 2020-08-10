//
//  XDTransformType.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/10.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  ObjectMapper的扩展库

import Foundation
import ObjectMapper

/// 时间转换(Date String)
class DateStringTransform: TransformType {
    typealias Object = Date
    typealias JSON = String

    let timeZone: TimeZone?
    let dateFormat: String

    static let `default`: DateStringTransform = DateStringTransform(timeZone: TimeZone(identifier: "GMT"), dateFormat: "yyyy-MM-dd HH:mm:ss")
    static let current: DateStringTransform = DateStringTransform(timeZone: TimeZone.current, dateFormat: "yyyy-MM-dd HH:mm:ss")
    init(timeZone: TimeZone?, dateFormat: String) {
        self.timeZone = timeZone
        self.dateFormat = dateFormat
    }

    func transformFromJSON(_ value: Any?) -> Date? {
        guard let dateString = value as? String else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale.init(identifier: "zh_CN")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: dateString)
    }

    func transformToJSON(_ value: Object?) -> JSON? {
        guard let date = value else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.timeZone = self.timeZone
        formatter.dateFormat = self.dateFormat
        return formatter.string(from: date)
    }

}

/// CGSize转换(CGSize String)
/// - Note: "100x100" 和 CGSize(100, 100) 的相互转换
/// - Warning: 只能处理正整数
class CGSizeStringTransform: TransformType {
    public typealias Object = CGSize
    public typealias JSON = String

    let seperator: String

    static let `default`: CGSizeStringTransform = CGSizeStringTransform(seperator: "x")
    public init(seperator: String = "x") {
        self.seperator = seperator
    }

    open func transformFromJSON(_ value: Any?) -> CGSize? {
        guard let sizeString = value as? String else {
            return nil
        }
        let sizeArray = sizeString.components(separatedBy: self.seperator).map { Int($0) ?? NSNotFound }
        for value in sizeArray {
            assert(value > 0, "出现了无法解析的数据")
            assert(value != NSNotFound, "出现了无法解析的数据")
        }
        assert(sizeArray.count == 2, "出现了无法解析的数据")
        return CGSize(width: sizeArray[0], height: sizeArray[1])
    }

    open func transformToJSON(_ value: Object?) -> String? {
        guard let size = value else {
            return nil
        }
        return String(format: "%d%@%d", size.width, self.seperator, size.height)
    }
}

/// 浮点数转换(CGSize String)  "123.00000000" 和 123.0
class DoubleStringTransform: TransformType {
    static let `default`: DoubleStringTransform = DoubleStringTransform()

    public typealias Object = Double
    public typealias JSON = String

    func transformFromJSON(_ value: Any?) -> Double? {
        if let value = value as? String {
            return Double(value)
        }
        return nil
    }

    func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return String(format: "%lf", value)
        }
        return nil
    }

}

/// Integer转换(CGSize String)
class IntegerStringTransform: TransformType {
    static let `default`: IntegerStringTransform = IntegerStringTransform()

    public typealias Object = Int
    public typealias JSON = String

    public init() {}
    func transformFromJSON(_ value: Any?) -> Int? {
        guard let value = value as? String else {
            return nil
        }
        return Int(value)
    }

    func transformToJSON(_ value: Int?) -> String? {
        guard let value = value else {
            return nil
        }
        return "\(value)"
    }
}

class Int32StringTransform: TransformType {
    static let `default`: Int32StringTransform = Int32StringTransform()

    public typealias Object = Int32
    public typealias JSON = String

    public init() {}
    func transformFromJSON(_ value: Any?) -> Int32? {
        guard let value = value as? String else {
            return nil
        }
        return Int32(value)
    }

    func transformToJSON(_ value: Int32?) -> String? {
        guard let value = value else {
            return nil
        }
        return "\(value)"
    }
}
