//
//  VersionManager.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  版本管理

import Foundation
import UIKit

private let kSavedAppVersionKey: String = "SavedAppVersionKey"
private let kSavedAppBuildKey: String = "SavedAppBuildKey"

class VersionManager {
    static let share = VersionManager()
    init() {
        self.currentVersion = self.getCurrentVersion()
        self.savedVersion = self.getSavedVersion()
        self.currentBuild = self.getCurrentBuild()
        self.savedBuild = self.getSavedBuild()
    }

    /// 当前版本号 - 本地版本
    private(set) var currentVersion: String = ""
    /// 当前build号 - 暂不使用
    private(set) var currentBuild: String = ""

    /// 本地保存的版本号
    private(set) var savedVersion: String?
    /// 本地保存的Build号 - 暂不使用
    private(set) var savedBuild: String?

    /// 服务器上的版本信息
    fileprivate var serverVersonInfo: ServerVesionModel? = nil
    /// AppStore上的应用信息 - 暂不使用
    fileprivate var appStoreInfo: String? = nil

}

// Mark: - Update
extension VersionManager {

    /// 更新处理
    func updateProcess() -> Void {
        // 1. 判断是否需要请求应用信息
        guard let serverVersonInfo = serverVersonInfo else {
            self.networkVersionProcess()
            return
        }
        // 2. 根据版本判断是否需要更新
        self.localVersionProcess(with: serverVersonInfo.version, newstBuild: String(serverVersonInfo.versionCode))
    }

    /// 显示更新弹窗
    func showUpdateView() -> Void {
        // 使用服务器上的版本描述信息
        guard let versionInfo = self.serverVersonInfo else {
            return
        }
        let updateVC: VerionUpdateController = VerionUpdateController()
        updateVC.model = versionInfo
        DispatchQueue.main.async {
            RootManager.share.rootVC.present(updateVC, animated: false, completion: nil)
        }
    }

    /// 跳转到指定url更新 - 使用safri打开指定链接
    func updateInSafari() -> Void {
        guard let strUrl = self.serverVersonInfo?.link, let url = URL.init(string: strUrl) else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    /// 跳转AppStore更新
    func updateInAppStore() -> Void {
        // 方案1：使用appInfo
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
        // 方案2：使用appId进行拼接
        // https://itunes.apple.com/cn/app/tokenbook/id1370346568?mt=8
        // https -> itms: | itms-apps:
        // let strUrl: String = String(format: "itms://itunes.apple.com/cn/app/tokenbook/id%@?mt=8", self.appId)
        // if let url = URL(string: strUrl) {
        //    UIApplication.shared.openURL(url)
        // }
    }
}

extension VersionManager {
    /// 从网络上获取最新版本信息，再处理
    fileprivate func networkVersionProcess() -> Void {
//        /// 最新版本信息从服务器上获取
//        SystemNetworkManager.getLatestVersion { (status, msg, model) in
//            guard status, let model = model else {
//                return
//            }
//            self.serverVersonInfo = model
//            if self.versionCompareForNeedUpdate(local: self.currentVersion, newest: model.version) {
//                self.showUpdateView()
//            } else if (self.currentVersion == model.version && self.buildCompareForNeedUpdate(local: self.currentBuild, newest: String(model.versionCode))) {
//                self.showUpdateView()
//            }
//        }
    }
    /// 已知最新的版本，直接进行本地处理
    func localVersionProcess(with newestVersion: String, newstBuild: String) -> Void {
        if self.versionCompareForNeedUpdate(local: self.currentVersion, newest: newestVersion) {
            self.showUpdateView()
        } else if (self.currentVersion == newestVersion && self.buildCompareForNeedUpdate(local: self.currentBuild, newest: newstBuild)) {
            self.showUpdateView()
        }
    }
}

// MARK: - Version SaveGet
extension VersionManager {
    /// 获取保存的上一个版本
    func getSavedVersion() -> String? {
        guard let appVersion = UserDefaults.standard.string(forKey: kSavedAppVersionKey) else {
            return nil
        }
        return appVersion
    }
    /// 更新保存的上一个版本
    func updateSavedVersion(_ version: String) -> Void {
        UserDefaults.standard.set(version, forKey: kSavedAppVersionKey)
    }
    func updateSavedVersion() -> Void {
        UserDefaults.standard.set(self.currentVersion, forKey: kSavedAppVersionKey)
    }
}

// MARK: - Build SaveGet
extension VersionManager {
    /// 获取保存的上一个Build
    func getSavedBuild() -> String? {
        guard let appBuild = UserDefaults.standard.string(forKey: kSavedAppBuildKey) else {
            return nil
        }
        return appBuild
    }
    /// 更新保存的上一个Build
    func updateSavedBuild(_ build: String) -> Void {
        UserDefaults.standard.set(build, forKey: kSavedAppBuildKey)
    }
    func updateSavedBuild() -> Void {
        UserDefaults.standard.set(self.currentBuild, forKey: kSavedAppBuildKey)
    }
}

extension VersionManager {
    /// 获取当前版本
    fileprivate func getCurrentVersion() -> String {
        var localVersion: String = ""
        let localVersionKey: String = "CFBundleShortVersionString"
        guard let currentVersion = Bundle.main.infoDictionary?[localVersionKey] as? String else {
            return localVersion
        }
        localVersion = currentVersion
        return localVersion
    }
    /// 获取当前Build
    fileprivate func getCurrentBuild() -> String {
        var localBuild: String = ""
        let localBuildKey: String = "CFBundleVersion"
        guard let currentBuild = Bundle.main.infoDictionary?[localBuildKey] as? String else {
            return localBuild
        }
        localBuild = currentBuild
        return localBuild
    }

}

// MARK: - Version Compare
extension VersionManager {
    /// 版本比较，确定是否更新
    fileprivate func versionCompareForNeedUpdate(local: String, newest: String) -> Bool {
        // 版本更新判断：服务器版本比本地版本高才可，如果本地版本更高或更长时不更新
        var updateFlag: Bool = false
        guard !local.isEmpty, !newest.isEmpty else {
            return updateFlag
        }
        updateFlag = (local != newest)
        // 特殊处理：比Server上的版本还要高时不提示更新
        let localNums = local.split(separator: ".").map({ Int($0) })
        let newestNums = newest.split(separator: ".").map({ Int($0) })
        let compareNums = (localNums.count <= newestNums.count) ? localNums : newestNums
        for (index, _) in compareNums.enumerated() {
            if let localNum = localNums[index], let newestNum = newestNums[index] {
                if localNum == newestNum {
                    continue
                } else if localNum > newestNum {
                    updateFlag = false
                    break
                } else {
                    updateFlag = true
                    break
                }
            } else {
                break
            }
        }
        return updateFlag
    }

    /// build号比较，确定是否更新
    fileprivate func buildCompareForNeedUpdate(local: String, newest: String) -> Bool {
        var updateFlag: Bool = false
        guard !local.isEmpty, !newest.isEmpty, let localCode = Int(local), let newestCode = Int(newest) else {
            return updateFlag
        }
        updateFlag = newestCode > localCode
        return updateFlag
    }

}
