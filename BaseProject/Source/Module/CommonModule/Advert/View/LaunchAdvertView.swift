//
//  LaunchAdvertView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/28.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  启动页广告视图
//  最多显示2个广告，其中第一个广告不可跳过、不显示倒计时;

import UIKit
import ChainOneKit

class LaunchAdvertView: UIView {

    // MARK: - Internal Property

    var models: [AdvertModel]? {
        didSet {
            self.setupModels(models)
        }
    }

    var currentIndex: Int = 0
    //var selectedIndex: Int = 0

    // MARK: - Private Property

    fileprivate let mainView: UIView = UIView()
    fileprivate let itemViews: [LaunchAdvertItemView] = [LaunchAdvertItemView(), LaunchAdvertItemView()]

    fileprivate var timer: Timer?

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
        //fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.stopTimer()
    }

}

// MARK: - Internal Function
extension LaunchAdvertView {
    class func loadXib() -> LaunchAdvertView? {
        return Bundle.main.loadNibNamed("LaunchAdvertView", owner: nil, options: nil)?.first as? LaunchAdvertView
    }

    func starAnimation() -> Void {
        if nil == self.timer {
            self.startTimer()
        }
    }
    func pauseAnimation() -> Void {
        self.timer?.fireDate = NSDate.distantFuture
    }
    func resumeAnimation() -> Void {
        self.timer?.fireDate = Date()
    }

    func dismiss() -> Void {
        self.stopTimer()
        self.removeFromSuperview()
    }

}

// MARK: - LifeCircle Function
extension LaunchAdvertView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension LaunchAdvertView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.backgroundColor = UIColor.red
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. itemViews
        for itemView in self.itemViews {
            mainView.addSubview(itemView)
            itemView.delegate = self
            itemView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension LaunchAdvertView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension LaunchAdvertView {
    fileprivate func setupModels(_ models: [AdvertModel]?) -> Void {
        self.stopTimer()
        guard let models = models else {
            return
        }
        if models.isEmpty {
            return
        }
        self.itemViews[0].model = models[0]
        self.itemViews[0].isHidden = false
        self.itemViews[0].isShowing = true
        self.itemViews[1].isHidden = true
        // 多个广告时，第一个广告不显示倒计时
        if models.count >= 2 {
            self.itemViews[0].model?.canSkip = false
        }
    }
}

// MARK: - Event Function
extension LaunchAdvertView {

}

// MARK: - Timer
extension LaunchAdvertView {
    /// 开启计时器
    fileprivate func startTimer() -> Void {
        // 开启倒计时
        self.stopTimer()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(countdown), object: nil)
        let timer = XDPackageTimer.timerWithInterval(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        timer.fire()
        self.timer = timer
    }
    /// 停止计时器
    fileprivate func stopTimer() -> Void {
        self.timer?.invalidate()
        self.timer = nil
    }
    /// 计时器回调 - 倒计时
    @objc fileprivate func countdown() -> Void {
        guard let models = self.models else {
            return
        }
        if self.currentIndex > models.count - 1 {
            self.dismiss()
            return
        }
        let itemView = self.itemViews[self.currentIndex]
        let model = models[self.currentIndex]
        // 判断当前显示广告是否已经到时
        if model.alreadyTime == model.duration {
            // 到时，判断是否可切换，可切则切换
            if self.currentIndex >= models.count - 1 || self.currentIndex >= 2 {
                self.dismiss()
                return
            }
            self.currentIndex += 1
            // 切换到下一章
            let nextItemView = self.itemViews[self.currentIndex]
            nextItemView.model = models[self.currentIndex]
            UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseInOut, animations: {
                itemView.isHidden = true
                nextItemView.isHidden = false
            }) { (_) in
                itemView.isShowing = false
                nextItemView.isShowing = true
            }
        } else {
            // 没到时，更换跳转按钮上的倒计时
            let leftNum = model.duration - model.alreadyTime
            itemView.updateSkipButton(countDown: leftNum)
            model.alreadyTime += 1
        }
    }

}

// MARK: - Extension Function
extension LaunchAdvertView {

}

// MARK: - Delegate Function

// MARK: - <LaunchAdvertItemViewProtocol>
extension LaunchAdvertView: LaunchAdvertItemViewProtocol {
    /// 点击了广告界面
    func didClickedAdert(in item: LaunchAdvertItemView) {
        guard let model = item.model else {
            self.dismiss()
            return
        }
        if model.linkType == .outside {
            var strUrl = model.link
            if !strUrl.hasPrefix("http://") && !strUrl.hasPrefix("https://") {
                strUrl = "http://" + model.link
            }
            let webVC = XDWKWebViewController.init(type: XDWebViwSourceType.strUrl(strUrl: strUrl))
            let webNC = BaseNavigationController.init(rootViewController: webVC)
            RootManager.share.rootVC.present(webNC, animated: false) {
                self.dismiss()
            }
        } else if model.linkType == .inside {
            switch model.inLinkType {
            case .none:
                break
            case .activity:
                // 屏蔽账号不进如邀请大赛
                if AppConfig.share.shield.currentNeedShield {
                    return
                }
//                // 进入邀请大赛需要登录
//                if let tabbarVC = RootManager.share.showRootVC as? UITabBarController, let selectedNC = tabbarVC.selectedViewController as? UINavigationController {
//                    let activityVC = InviteActivityHomeController.init(model: nil)
//                    selectedNC.pushViewController(activityVC, animated: true)
//                    self.dismiss()
//                }
            }
        }
    }
    /// 点击了跳转按钮
    func advertItem(_ item: LaunchAdvertItemView, didClickedSkip skipButton: UIButton) {
        guard let model = item.model else {
            self.dismiss()
            return
        }
        if model.canSkip {
            self.dismiss()
        }
    }
}
