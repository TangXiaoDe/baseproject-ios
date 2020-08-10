//
//  JPushHelper.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/10.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  JPush 工具助手，用于JPush对别名、标签的封装处理
//  1. typedef void (^JPUSHAliasOperationCompletion)(NSInteger iResCode, NSString *iAlias, NSInteger seq);
//  2. 需要进一步完善：前后台切换对未完成的设置的影响；

import Foundation

class JPushHelper {

    static let instance = JPushHelper()
    fileprivate init() {
    }

    fileprivate let seq: Int = 0
    fileprivate let timeInterval: TimeInterval = 30

    /// 获取当前设备别名
    func getAlias(completion: @escaping JPUSHAliasOperationCompletion) -> Void {
        JPUSHService.getAlias(completion, seq: self.seq)
    }

    /// 是否强制更新别名
    func setAlias(_ alias: String, force: Bool) -> Void {
        if force {
            self.setAlias(alias)
        } else {
            // 获取已设置的别名，若一致则无需设置
            self.getAlias { (iResCode, iAlias, seq) in
                if 0 == iResCode, let iAlias = iAlias, iAlias == alias {
                    return
                } else {
                    self.setAlias(alias)
                }
            }
        }
    }
    /// 设置当前设备别名
    func setAlias(_ alias: String) -> Void {
        JPUSHService.setAlias(alias, completion: { (iResCode, iAlias, seq) in
            // 设置失败，则过段时间重新设置
            if 0 != iResCode {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.timeInterval, execute: {
                    self.setAlias(alias)
                })
            }
        }, seq: self.seq)
    }

    /// 删除当前设备别名
    func deleteAlias() -> Void {
        JPUSHService.deleteAlias({ (iResCode, iAlias, seq) in

        }, seq: self.seq)
    }

}

// MARK: - timer
extension JPushHelper {

}
