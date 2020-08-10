//
//  MomentGuideController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  动态引导页

//IMG_noviceguide_tips_usercenter

import UIKit
import ChainOneKit


protocol MomentGuideControllerProtocol: class {
    /// 遮罩点击回调
    func guideVC(_ guideVC: MomentGuideController, didClickedCover coverBtn: UIButton) -> Void
    /// 确定点击回调
    func guideVC(_ guideVC: MomentGuideController, didClickedDone doneBtn: UIButton) -> Void
    /// 头像点击回调
    func guideVC(_ guideVC: MomentGuideController, didClickedAvatar avatarBtn: UIButton) -> Void
}
extension MomentGuideControllerProtocol {
    func guideVC(_ guideVC: MomentGuideController, didClickedCover coverBtn: UIButton) -> Void {}
    func guideVC(_ guideVC: MomentGuideController, didClickedDone doneBtn: UIButton) -> Void {}
    func guideVC(_ guideVC: MomentGuideController, didClickedAvatar avatarBtn: UIButton) -> Void {}
}

/// 个人中心引导页
typealias UserCenterGuideController = MomentGuideController
/// 动态引导页
class MomentGuideController: BaseViewController {
    // MARK: - Internal Property

    weak var delegate: MomentGuideControllerProtocol?

    // MARK: - Private Property

    fileprivate let coverBtn: UIButton = UIButton.init(type: .custom)
    fileprivate let tipsView: UIImageView = UIImageView()
    fileprivate let knowBtn: UIButton = UIButton.init(type: .custom)    // 知道了
    fileprivate let avatarBtn: UIButton = UIButton.init(type: .custom)

    fileprivate let tipsSize: CGSize = CGSize.init(width: 281, height: 151).scaleAspectForWidth(kScreenWidth - (kiPhone6ScreenWidth - 281.0))
    fileprivate let knowBtnSize: CGSize = CGSize.init(width: 94, height: 36)
    fileprivate let avatarWH: CGFloat = 32

    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
        // present后的透明展示
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }

}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension MomentGuideController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - UI
extension MomentGuideController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        // iPhone5系列、iPhone6系列宽的屏幕为16；iPhone6P宽的屏幕为20
        var avatarLeftMargin: CGFloat = 16
        if kScreenWidth >= kiPhone6PlusScreenWidth {
            avatarLeftMargin = 20
        }
        self.view.backgroundColor = UIColor.clear
        // 0. coverView
        self.view.addSubview(self.coverBtn)
        self.coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 1. tipsView
        self.view.addSubview(self.tipsView)
        self.tipsView.image = UIImage.init(named: "IMG_noviceguide_tips_usercenter")
        self.tipsView.isUserInteractionEnabled = true
        self.tipsView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(kNavigationStatusBarHeight)
            make.size.equalTo(self.tipsSize)
        }
        // knowBtn
        self.view.addSubview(self.knowBtn)
        self.knowBtn.addTarget(self, action: #selector(knowBtnClick(_:)), for: .touchUpInside)
        self.knowBtn.setBackgroundImage(UIImage.init(named: "IMG_noviceguide_knowbtn"), for: .normal)
        self.knowBtn.snp.makeConstraints { (make) in
            make.size.equalTo(self.knowBtnSize)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.tipsView.snp.bottom).offset(60)
        }
        // avatarBtn
        self.view.addSubview(self.avatarBtn)
        self.avatarBtn.addTarget(self, action: #selector(avatarBtnClick(_:)), for: .touchUpInside)
        self.avatarBtn.set(font: nil, cornerRadius: self.avatarWH * 0.5)
        self.avatarBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.avatarWH)
            make.centerY.equalTo(self.view.snp.top).offset(kStatusBarHeight + kNavigationBarHeight * 0.5)
            make.leading.equalToSuperview().offset(avatarLeftMargin)
        }
        let user = AccountManager.share.currentAccountInfo?.userInfo
        self.avatarBtn.kf.setBackgroundImage(with: user?.avatarUrl, for: .normal, placeholder: AppImage.placeHolder(for: user?.sex))
    }

}

// MARK: - Data(数据处理与加载)
extension MomentGuideController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension MomentGuideController {
    /// 遮罩点击响应
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {
        // 遮罩点击不予响应，必须点击我知道了
        //self.dismiss(animated: false, completion: nil)
        //self.delegate?.guideVC(self, didClickedCover: button)
        //NoviceGuideManager.share.setGuideCompleteState(true, for: .userCenter)
    }
    /// 知道了按钮点击
    @objc fileprivate func knowBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: false, completion: nil)
        self.delegate?.guideVC(self, didClickedCover: self.coverBtn)
        NoviceGuideManager.share.setGuideCompleteState(true, for: .userCenter)
    }
    /// 头像点击
    @objc fileprivate func avatarBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: false, completion: nil)
        self.delegate?.guideVC(self, didClickedCover: self.coverBtn)
        NoviceGuideManager.share.setGuideCompleteState(true, for: .userCenter)
        NotificationCenter.default.post(name: Notification.Name.App.showLeftMenu, object: nil, userInfo: nil)
    }

}

// MARK: - Notification
extension MomentGuideController {

}

// MARK: - Extension Function
extension MomentGuideController {

}

// MARK: - Delegate Function

// MARK: - <>
extension MomentGuideController {

}
