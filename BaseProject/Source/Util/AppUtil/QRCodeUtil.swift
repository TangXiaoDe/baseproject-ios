//
//  QRCodeUtil.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation


/// 二维码工具
class QRCodeUtil {

    /// 判断是否有二维码
    class func haveQRCode(in image: UIImage?) -> Bool {
        var haveFlag: Bool = false
        guard let image = image, let ciImage: CIImage = CIImage(image: image) else {
            return haveFlag
        }
        //二维码读取
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        guard let features = detector?.features(in: ciImage) else {
            return haveFlag
        }
        haveFlag = !features.isEmpty
        return haveFlag
    }

    /// 读取二维码
    class func scanQRCode(image: UIImage) -> String? {
        var result: String? = nil
        //二维码读取
        guard let ciImage = CIImage(image: image) else {
            return result
        }
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        guard let features = detector?.features(in: ciImage) else {
            return result
        }
        // 获取第一个二维码并返回
        if let firstFeature = features.first as? CIQRCodeFeature {
            result = firstFeature.messageString
        }
        return result
    }

    /// 二维码结果跳转
    class func getQRCcodeResultPage(with result: String) -> UIViewController? {
//        var resultVC: UIViewController?
//        let decodeStr = AppUtil.base64Decoding(encodedStr: result)
//        let model = QRModel.init(JSONString: decodeStr)
//        guard let qrModel = model else {
//            if result.isMatchURL() {
//                // 网页跳转
//                resultVC = XDWKWebViewController.init(type: XDWebViwSourceType.strUrl(strUrl: result))
//            } else {
//                // 其他处理
//                resultVC = ScanResultController.init(result: result)
//            }
//            return resultVC
//        }
//        switch qrModel.type {
//        case .user:
//            let infoVC = UserInfoController.init(userId: qrModel.id)
//            infoVC.source = "通过扫码添加"
//            resultVC = infoVC
//        case .group:
//            if let groupId = Int(qrModel.groupId) {
//                resultVC = GroupMomentController.init(id: groupId)
//            }
//        case .community:
//            if let groupId = Int(qrModel.groupId) {
//                resultVC = CommunityHomeController.init(id: groupId)
//            }
//        case .transfer:
//            resultVC = TransferQRResultController.init(model: qrModel)
//        }
//        return resultVC
        return nil
    }

}
