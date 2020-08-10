//
//  MeetGuideController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/27.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  遇见页的好友分组引导

import UIKit

protocol MeetGuideControllerProtocol: class {
    /// 遮罩点击回调
    func guideVC(_ guideVC: MeetGuideController, didClickedCover coverBtn: UIButton) -> Void
    /// 提示长按回调
    func guideVC(_ guideVC: MeetGuideController, didLongPressedTips tipsView: UIImageView) -> Void
}
extension MeetGuideControllerProtocol {
    func guideVC(_ guideVC: MeetGuideController, didClickedCover coverBtn: UIButton) -> Void {}
}


/// 好友分组引导页
typealias FriendGroupGuideController = MeetGuideController
/// 遇见页的好友分组引导界面
class MeetGuideController: BaseViewController {
    // MARK: - Internal Property

    weak var delegate: MeetGuideControllerProtocol?

    // MARK: - Private Property

    fileprivate let coverBtn: UIButton = UIButton.init(type: .custom)
    fileprivate let tipsView: UIImageView = UIImageView()
    fileprivate let knowBtn: UIButton = UIButton.init(type: .custom)    // 知道了

    fileprivate let tipsSize: CGSize = CGSize.init(width: 238, height: 65)
    //fileprivate let knowBtnFrame: CGRect = CGRect.init(x: 55, y: 85, width: 105, height: 40)
    fileprivate let knowBtnSize: CGSize = CGSize.init(width: 94, height: 36)

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
extension MeetGuideController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - UI
extension MeetGuideController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.clear
        // 0. coverView
        self.view.addSubview(self.coverBtn)
        self.coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 1. tipsView
        self.view.addSubview(self.tipsView)
        self.tipsView.image = UIImage.init(named: "IMG_noviceguide_tips_friendgroup")
        self.tipsView.isUserInteractionEnabled = true
        self.tipsView.snp.makeConstraints { (make) in
            let topMargin: CGFloat = kNavigationStatusBarHeight
//            let topMargin: CGFloat = kNavigationStatusBarHeight + MeetHomeTopView.viewHeight + MeetHomeTitleSectionView.viewHeight + 12 + FriendListCell.cellHeight * 0.5
            make.top.equalToSuperview().offset(topMargin)
            make.centerX.equalToSuperview()
            make.size.equalTo(self.tipsSize)
        }
        // knowBtn
        self.view.addSubview(self.knowBtn)
        self.knowBtn.addTarget(self, action: #selector(knowBtnClick(_:)), for: .touchUpInside)
        self.knowBtn.setBackgroundImage(UIImage.init(named: "IMG_noviceguide_knowbtn"), for: .normal)
        self.knowBtn.snp.makeConstraints { (make) in
            make.size.equalTo(self.knowBtnSize)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            //make.centerY.equalTo(self.tipsView.snp.bottom).offset(60)
        }
        // tipsView 添加 长按手势
        let longGR = UILongPressGestureRecognizer.init(target: self, action: #selector(longpressGRProcess(_:)))
        longGR.minimumPressDuration = 0.8  // 长按最短时间
        self.tipsView.addGestureRecognizer(longGR)

        // 位置测试
        //self.tipsView.backgroundColor = UIColor.red
        //self.knowBtn.backgroundColor = UIColor.yellow
    }
}

// MARK: - Data(数据处理与加载)
extension MeetGuideController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension MeetGuideController {
    /// 遮罩点击响应
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {
        // 遮罩点击不予响应，必须点击我知道了或者长按视图
        //self.dismiss(animated: false, completion: nil)
        //self.delegate?.guideVC(self, didClickedCover: button)
        //NoviceGuideManager.share.setGuideCompleteState(true, for: .friendGuide)
    }
    /// 一键挖矿按钮长按响应
    @objc fileprivate func longpressGRProcess(_ longpressGR: UILongPressGestureRecognizer) -> Void {
        if longpressGR.state == .began {
            self.dismiss(animated: false, completion: nil)
            self.delegate?.guideVC(self, didLongPressedTips: self.tipsView)
            NoviceGuideManager.share.setGuideCompleteState(true, for: .friendGuide)
        }
    }
    /// 知道了按钮点击
    @objc fileprivate func knowBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: false, completion: nil)
        self.delegate?.guideVC(self, didClickedCover: self.coverBtn)
        NoviceGuideManager.share.setGuideCompleteState(true, for: .friendGuide)
    }
}

// MARK: - Notification
extension MeetGuideController {

}

// MARK: - Extension Function
extension MeetGuideController {

}

// MARK: - Delegate Function

// MARK: - <>
extension MeetGuideController {

}
