//
//  NoviceGuideManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/17.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  新手引导管理
//  将该模块独立出来，便于后续的扩展

import Foundation

class NoviceGuideManager {

    static let share = NoviceGuideManager()
    private init() {
    }

    /// 判断指定引导项目是否完成
    func isGuideComplete(for type: NoviceGuideType) -> Bool {
        var strId: String = ""
        if let id = AccountManager.share.currentAccountInfo?.userInfo?.id {
            strId = "\(id)"
        }
        let key = type.identifier + strId
        guard let state = UserDefaults.standard.value(forKey: key) as? Bool else {
            return false
        }
        return state
    }

    /// 设置指定引导项目完成状态
    func setGuideCompleteState(_ state: Bool, for type: NoviceGuideType) -> Void {
        var strId: String = ""
        if let id = AccountManager.share.currentAccountInfo?.userInfo?.id {
            strId = "\(id)"
        }
        let key = type.identifier + strId
        UserDefaults.standard.set(state, forKey: key)
        UserDefaults.standard.synchronize()
    }

}
