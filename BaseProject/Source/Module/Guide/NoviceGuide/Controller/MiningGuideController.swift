//
//  MiningGuideController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/4.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  一键挖矿引导界面 - 点击引导 + 长按引导

import UIKit

enum GuideType {
    /// 点击一键收取
    case ClickDigAll
    /// 长按重置
    case LongpressRecharge
}

protocol MiningDigAllGuideControllerProtocol: class {
    /// 按钮点击响应
    func guideVC(_ guideVC: MiningDigAllGuideController, didClickDigAll digallBtn: UIButton) -> Void
    /// 按钮长按响应
    func guideVC(_ guideVC: MiningDigAllGuideController, didLongpressDigAll digallBtn: UIButton) -> Void
}

/// 一键挖矿使用引导界面
class MiningDigAllGuideController: BaseViewController {
    // MARK: - Internal Property

    let type: GuideType

    /// 回调处理
    weak var delegate: MiningDigAllGuideControllerProtocol?

    // MARK: - Private Property

    fileprivate let coverBtn: UIButton = UIButton.init(type: .custom)
    fileprivate let digAllBtn: UIButton = UIButton.init(type: .custom)
    fileprivate let promptImgView: UIImageView = UIImageView()

    fileprivate let digAllIconWH: CGFloat = 48
    fileprivate let digAllRightMargin: CGFloat = 13

    fileprivate let digAllTopMargin: CGFloat


    // MARK: - Initialize Function

    init(type: GuideType, iconTopMargin: CGFloat) {
        self.type = type
        self.digAllTopMargin = iconTopMargin
        super.init(nibName: nil, bundle: nil)
        // present后的透明展示
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension MiningDigAllGuideController {
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
extension MiningDigAllGuideController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.clear
        // 0. coverView
        self.view.addSubview(self.coverBtn)
        self.coverBtn.isUserInteractionEnabled = false
        self.coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 1. digAllBtn
        self.view.addSubview(self.digAllBtn)
        self.digAllBtn.setBackgroundImage(UIImage.init(named: "IMG_mining_menu_yijian"), for: .normal)
        self.digAllBtn.set(cornerRadius: 0)
        self.digAllBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.digAllIconWH)
            make.trailing.equalToSuperview().offset(-self.digAllRightMargin)
            make.top.equalToSuperview().offset(self.digAllTopMargin)
        }
        // 2. promptImgView
        self.view.addSubview(self.promptImgView)
        self.promptImgView.contentMode = .center
        self.promptImgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.digAllBtn)
        }

        switch self.type {
        case .ClickDigAll:
            self.promptImgView.image = UIImage.init(named: "IMG_mining_bg_chongzhi_tips_click")
            self.digAllBtn.addTarget(self, action: #selector(digAllBtnClick(_:)), for: .touchUpInside)
        case .LongpressRecharge:
            self.coverBtn.isUserInteractionEnabled = true
            self.promptImgView.image = UIImage.init(named: "IMG_mining_bg_chongzhi_tips_longpress")
            // 长按手势添加
            let longGR = UILongPressGestureRecognizer.init(target: self, action: #selector(longpressGRProcess(_:)))
            longGR.minimumPressDuration = 0.8  // 长按最短时间
            self.digAllBtn.addGestureRecognizer(longGR)
        }

    }
}

// MARK: - Data(数据处理与加载)
extension MiningDigAllGuideController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension MiningDigAllGuideController {
    /// 遮罩点击响应
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: false, completion: nil)
        switch self.type {
        case .ClickDigAll:
            break
        case .LongpressRecharge:
            NoviceGuideManager.share.setGuideCompleteState(true, for: .digOreAllRecharge)
        }
    }
    /// 一键挖矿按钮点击响应
    @objc fileprivate func digAllBtnClick(_ button: UIButton) -> Void {
        self.delegate?.guideVC(self, didClickDigAll: button)
        self.dismiss(animated: false, completion: nil)
    }
    /// 一键挖矿按钮长按响应
    @objc fileprivate func longpressGRProcess(_ longpressGR: UILongPressGestureRecognizer) -> Void {
        if longpressGR.state == .began {
            self.delegate?.guideVC(self, didLongpressDigAll: self.digAllBtn)
            self.dismiss(animated: false, completion: nil)
        }
    }

}

// MARK: - Notification
extension MiningDigAllGuideController {

}

// MARK: - Extension Function
extension MiningDigAllGuideController {

}

// MARK: - Delegate Function

// MARK: - <>
extension MiningDigAllGuideController {

}
