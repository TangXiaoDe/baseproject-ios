//
//  MiningEnterGuideController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  挖矿入口迁移引导界面

import UIKit
import ChainOneKit

protocol MiningEntranceGuideControllerProtocol: class {
    /// 遮罩点击回调
    func guideVC(_ guideVC: MiningEntranceGuideController, didClickedCover coverBtn: UIButton) -> Void
    /// 确定点击回调
    func guideVC(_ guideVC: MiningEntranceGuideController, didClickedDone doneBtn: UIButton) -> Void
}
extension MiningEntranceGuideControllerProtocol {
    func guideVC(_ guideVC: MiningEntranceGuideController, didClickedCover coverBtn: UIButton) -> Void {}
    func guideVC(_ guideVC: MiningEntranceGuideController, didClickedDone doneBtn: UIButton) -> Void {}
}

typealias MiningEntranceUpdateGuideController = MiningEntranceGuideController
/// 挖矿入口迁移引导界面
class MiningEntranceGuideController: BaseViewController {
    // MARK: - Internal Property

    weak var delegate: MiningEntranceGuideControllerProtocol?

    // MARK: - Private Property

    fileprivate let coverBtn: UIButton = UIButton.init(type: .custom)
    fileprivate let tipsView: UIImageView = UIImageView()
    fileprivate let knowBtn: UIButton = UIButton.init(type: .custom)    // 知道了
    fileprivate let wkIconView: UIImageView = UIImageView()

    fileprivate let tipsSize: CGSize = CGSize.init(width: 317, height: 135).scaleAspectForWidth(kScreenWidth - (kiPhone6ScreenWidth - 317))
    fileprivate let knowBtnSize: CGSize = CGSize.init(width: 94, height: 36)
    fileprivate let wkIconSize: CGSize = CGSize.init(width: 32, height: 32)

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
extension MiningEntranceGuideController {
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
extension MiningEntranceGuideController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
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
        self.tipsView.image = UIImage.init(named: "IMG_noviceguide_tips_wkentrance")
        self.tipsView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(kNavigationStatusBarHeight)
            make.size.equalTo(self.tipsSize)
        }
        // 2. knowBtn
        self.view.addSubview(self.knowBtn)
        self.knowBtn.addTarget(self, action: #selector(knowBtnClick(_:)), for: .touchUpInside)
        self.knowBtn.setBackgroundImage(UIImage.init(named: "IMG_noviceguide_knowbtn"), for: .normal)
        self.knowBtn.snp.makeConstraints { (make) in
            make.size.equalTo(self.knowBtnSize)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.tipsView.snp.bottom).offset(60)
        }
        // 3. wkIcon
        self.view.addSubview(self.wkIconView)
        self.wkIconView.set(cornerRadius: self.wkIconSize.width * 0.5)
        self.wkIconView.image = UIImage.init(named: "IMG_navbar_wk")
        self.wkIconView.backgroundColor = UIColor.init(hex: 0x2a385f)
        self.wkIconView.snp.makeConstraints { (make) in
            make.size.equalTo(self.wkIconSize)
            make.centerY.equalTo(self.view.snp.top).offset(kStatusBarHeight + kNavigationBarHeight * 0.5)
            // 这个距离需要适配
            make.trailing.equalToSuperview().offset(-15)
        }
    }

}

// MARK: - Data(数据处理与加载)
extension MiningEntranceGuideController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension MiningEntranceGuideController {
    /// 遮罩点击响应
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: false, completion: nil)
        self.delegate?.guideVC(self, didClickedCover: button)
        NoviceGuideManager.share.setGuideCompleteState(true, for: .miningEntranceUpdate)
    }
    /// 知道了按钮点击
    @objc fileprivate func knowBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: false, completion: nil)
        self.delegate?.guideVC(self, didClickedDone: button)
        NoviceGuideManager.share.setGuideCompleteState(true, for: .miningEntranceUpdate)
    }

}

// MARK: - Notification
extension MiningEntranceGuideController {

}

// MARK: - Extension Function
extension MiningEntranceGuideController {

}

// MARK: - Delegate Function

// MARK: - <>
extension MiningEntranceGuideController {

}
