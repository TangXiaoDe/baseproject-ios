//
//  UploadManager.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import Qiniu
import Photos

class UploadManager {
    static let share = UploadManager()
    init() {

    }
    func uploadImages(_ images: [UIImage], ModuleName: String, complete: @escaping((_ status: Bool, _ msg: String?, _ results: [PublishImageModel]?) -> Void)) {

        UploadNetworkManager.getUploadToken { (status, msg, uploadTokenModel) in
            guard let uploadToken = uploadTokenModel?.uploadToken else {
                complete(false, msg, nil)
                return
            }
            var objectKeyArray: [String] = []
            let QNManager = QNUploadManager()
            var currentIndex = 0
            var results: [PublishImageModel] = []
            for image in images {
//                let objectName = "\(ModuleName)/images/\(Date().timeIntervalSince1970).png"
                let objectName = String(format: "%@.png", Date().string(format: "yyyyMMddHHmmssSSS", timeZone: nil))
                objectKeyArray.append(objectName)
                let data = image.jpegData(compressionQuality: 0.7)
                //option 设置 可为nil
                let uploadOption = QNUploadOption.init(mime: "image/png", progressHandler: { (str, present) in
                }, params: ["width": image.size.width, "height": image.size.height], checkCrc: false, cancellationSignal: { () -> Bool in
                    return false
                })
                let publishImageModel = PublishImageModel()
                publishImageModel.filename = objectName
                publishImageModel.width = image.size.width
                publishImageModel.height = image.size.height
                results.append(publishImageModel)
                // 七牛
                QNManager?.put(data, key: objectName, token: uploadToken, complete: { (info, key, AnyHashable) in
                    if info?.isOK == true {
                        currentIndex += 1
                        //这里是代表全部上传完了 不用else
                        if (currentIndex == images.count) {
                            complete(true, "上传成功", results)
                        }
                    } else {
                        complete(false, info?.error.localizedDescription, nil)
                    }
                }, option: uploadOption)
            }
        }
    }

    @available(iOS 9.1, *)
    func uploadVideo(asset: PHAsset, ModuleName: String, complete: @escaping((_ status: Bool, _ msg: String?, _ results: PublishVideoModel?) -> Void)) {
        UploadNetworkManager.getUploadToken { (status, msg, uploadTokenModel) in
            guard let uploadToken = uploadTokenModel?.uploadToken else {
                complete(false, msg, nil)
                return
            }
            let QNManager = QNUploadManager()
            let objectName = String(format: "%@.mp4", Date().string(format: "yyyyMMddHHmmssSSS", timeZone: nil))
            //option 设置 可为nil
            let uploadOption = QNUploadOption.init(mime: "video/mp4", progressHandler: { (str, present) in
            }, params: nil, checkCrc: false, cancellationSignal: { () -> Bool in
                return false
            })
            let publishVideoModel = PublishVideoModel()
            publishVideoModel.filename = objectName
            // 七牛
            QNManager?.put(asset, key: objectName, token: uploadToken, complete: { (info, key, AnyHashable) in
                if info?.isOK == true {
                    complete(true, "上传成功", publishVideoModel)
                } else {
                    complete(false, info?.error.localizedDescription, nil)
                }
            }, option: uploadOption)

        }
    }

    func uploadVideo(filePath: String, ModuleName: String, width: CGFloat, height: CGFloat, complete: @escaping((_ status: Bool, _ msg: String?, _ results: PublishVideoModel?) -> Void)) {
        UploadNetworkManager.getUploadToken { (status, msg, uploadTokenModel) in
            guard let uploadToken = uploadTokenModel?.uploadToken else {
                complete(false, msg, nil)
                return
            }
            let QNManager = QNUploadManager()
            let objectName = String(format: "%@.mp4", Date().string(format: "yyyyMMddHHmmssSSS", timeZone: nil))
            //option 设置 可为nil
            let uploadOption = QNUploadOption.init(mime: "video/mp4", progressHandler: { (str, present) in
            }, params: nil, checkCrc: false, cancellationSignal: { () -> Bool in
                return false
            })
            let publishVideoModel = PublishVideoModel()
            publishVideoModel.filename = objectName
            // 七牛
            QNManager?.putFile(filePath, key: objectName, token: uploadToken, complete: { (info, key, AnyHashable) in
                if info?.isOK == true {
                    complete(true, "上传成功", publishVideoModel)
                } else {
                    complete(false, info?.error.localizedDescription, nil)
                }
            }, option: uploadOption)

        }
    }
}
