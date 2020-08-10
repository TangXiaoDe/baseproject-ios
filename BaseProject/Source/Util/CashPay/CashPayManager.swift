//
//  CashPayManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  现金支付管理

import Foundation

/// 现金支付管理
class CashPayManager {
    static let share = CashPayManager()
    private init() {

    }

    var currentWxpayModel: CashPayInfoModel?
    var currentAlipayModel: CashPayInfoModel?

    /// 微信支付成功处理
    func wxpaySuccessProcess() -> Void {
        guard let wxpayModel = self.currentWxpayModel else {
            return
        }
        switch wxpayModel.sourceType {
        case .groupUpgrade:
            guard let groupId = wxpayModel.groupId else {
                return
            }
            self.groupUpgradeCashPayStatusCheck(groupId: groupId, orderno: wxpayModel.orderno)
        case .miningRecharge:
            Toast.showToast(title: "支付成功")
        }
        self.currentWxpayModel = nil
    }

    /// 支付宝支付成功处理
    func alipaySuccessProcess() -> Void {
        guard let alipayModel = self.currentAlipayModel else {
            return
        }
        switch alipayModel.sourceType {
        case .groupUpgrade:
            break
        case .miningRecharge:
            break
        }
    }

}
extension CashPayManager {
    /// 社群升级现金支付状态检查
    fileprivate func groupUpgradeCashPayStatusCheck(groupId: Int, orderno: String) -> Void {
//        GroupNetworkManager.checkGroupUpgradeRmbPay(groupId: groupId, orderNo: orderno) { (status, msg, model) in
//            guard status, let model = model else {
//                Toast.showToast(title: msg)
//                return
//            }
//            let popView: GroupUpgradePaySuccessPopView = GroupUpgradePaySuccessPopView.init()
//            popView.model = model
//            DispatchQueue.main.async {
//                PopViewUtil.showPopView(popView)
//            }
//        }
    }

}
