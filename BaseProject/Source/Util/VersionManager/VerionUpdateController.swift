//
//  VerionUpdateController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/20.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  版本更新界面

import UIKit
import MarkdownView

class VerionUpdateController: UIViewController {
    // MARK: - Internal Property

    var model: ServerVesionModel?

    // MARK: - Internal Function
    // MARK: - Private Property

    /// 背景
    fileprivate let coverBtn: UIButton = UIButton(type: .custom)
    /// 更新视图: topImage + (title + contnet)|(content) + updateBtn
    fileprivate let updateView: UIView = UIView()
    fileprivate let updateBgView: UIImageView = UIImageView()
    fileprivate let bottomBgView: UIImageView = UIImageView()

    fileprivate let titleLabel: UILabel = UILabel()
    fileprivate let versionLabel: UILabel = UILabel()

    fileprivate let updateInfoView: UIView = UIView()
    fileprivate let infoScrollView: UIScrollView = UIScrollView()
    fileprivate let infoLabel: UILabel = UILabel()

    fileprivate let updateBtn: UIButton = UIButton(type: .custom)
    fileprivate let cancelBtn: UIButton = UIButton(type: .custom)

    /// titleLabel的font
    fileprivate let titleFont: UIFont = UIFont.systemFont(ofSize: UIDevice.current.isiPhone5series() ? 15 : 16)
    /// contentLabel的font
    fileprivate let contentFont: UIFont = UIFont.systemFont(ofSize: UIDevice.current.isiPhone5series() ? 13 : 14)
    /// contentLabel的段落间距
    fileprivate let paragraphSpace: CGFloat = UIDevice.current.isiPhone5series() ? 6 : 8

    fileprivate let updateInfoLrMargin: CGFloat = 17

    fileprivate let bgSize: CGSize = CGSize.init(width: 275, height: 373)
    fileprivate let bottomBgSize: CGSize = CGSize.init(width: 275, height: 110)
    fileprivate let cancelSize: CGSize = CGSize.init(width: 40, height: 70)
    fileprivate let updateBtnSize: CGSize = CGSize.init(width: 220, height: 40)

    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
        // present后的透明展示
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // present后的透明展示
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }

    // MARK: - LifeCircle

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

extension VerionUpdateController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.clear
        // 1. coverBtn - 便于扩展
        self.view.addSubview(self.coverBtn)
        self.coverBtn.setBackgroundImage(UIImage.imageWithColor(UIColor.black.withAlphaComponent(0.5)), for: .normal)
        self.coverBtn.setBackgroundImage(UIImage.imageWithColor(UIColor.black.withAlphaComponent(0.5)), for: .highlighted)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        // 2. updateView
        self.view.addSubview(self.updateView)
        self.initialUpdateView(self.updateView)
        self.updateView.snp.makeConstraints { (make) in
            make.size.equalTo(self.bgSize)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-self.cancelSize.height * 0.5)
        }
        // 3. cancelView - 整体独立，便于强制更新与否的处理
        self.view.addSubview(self.cancelBtn)
        self.cancelBtn.setImage(UIImage.init(named: "IMG_updrade_close"), for: .normal)
        self.cancelBtn.addTarget(self, action: #selector(cancelBtnClick(_:)), for: .touchUpInside)
        self.cancelBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.updateView)
            make.top.equalTo(self.updateView.snp.bottom)
            make.size.equalTo(self.cancelSize)
        }
    }

    /// 更新视图布局
    fileprivate func initialUpdateView(_ updateView: UIView) -> Void {
        let titleTopMargin: CGFloat = 55
        let leftMargin: CGFloat = 17
        let infoTopMargin: CGFloat = 150
        let infoBottomMargin: CGFloat = 84
        let bottomMargin: CGFloat = 22
        // 1. bgView
        updateView.addSubview(self.updateBgView)
        self.updateBgView.image = UIImage.init(named: "IMG_bg_upgrade")
        self.updateBgView.set(cornerRadius: 0)
        self.updateBgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. titleView
        // 2.1 titleLabel
        updateView.addSubview(self.titleLabel)
        self.titleLabel.set(text: "发现新版本", font: UIFont.pingFangSCFont(size: 18, weight: .medium), textColor: UIColor.white)
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(leftMargin)
            make.top.equalToSuperview().offset(titleTopMargin)
            make.height.equalTo(18)
        }
        // 1.2 versionLabel
        updateView.addSubview(self.versionLabel)
        self.versionLabel.set(text: "v", font: UIFont.systemFont(ofSize: 13), textColor: UIColor.white)
        self.versionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(9)
        }
        // 2. infoView
        updateView.addSubview(self.updateInfoView)
        self.initialUpdateInfoView(self.updateInfoView)
        self.updateInfoView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(infoTopMargin)
            make.bottom.equalToSuperview().offset(-infoBottomMargin)
        }
        // 3. bottomView
        // 3.1 bottomBgView
        updateView.addSubview(self.bottomBgView)
        self.bottomBgView.set(cornerRadius: 0)
        self.bottomBgView.image = UIImage.init(named: "IMG_bg_upgrade_mask")
        self.bottomBgView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.bottomBgSize.height)
        }
        // 3.2 updateBtn
        updateView.addSubview(self.updateBtn)
        self.updateBtn.set(title: "立即升级", titleColor: UIColor.white, for: .normal)
        self.updateBtn.set(font: UIFont.pingFangSCFont(size: 15, weight: .medium), cornerRadius: self.updateBtnSize.height * 0.5)
        let gradientLayer: CAGradientLayer = AppUtil.commonGradientLayer()
        gradientLayer.frame = CGRect.init(origin: CGPoint.zero, size: self.updateBtnSize)
        self.updateBtn.layer.insertSublayer(gradientLayer, below: nil)
        self.updateBtn.addTarget(self, action: #selector(updateBtnClick(_:)), for: .touchUpInside)
        self.updateBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(self.updateBtnSize)
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
    }

    /// updateInfo
    fileprivate func initialUpdateInfoView(_ updateInfoView: UIView) -> Void {
        // 2. scrollContainer
        updateInfoView.addSubview(self.infoScrollView)
        self.infoScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 3. infoLabel
        self.infoScrollView.addSubview(self.infoLabel)
        self.infoLabel.set(text: nil, font: UIFont.systemFont(ofSize: 13), textColor: UIColor.init(hex: 0x666666))
        self.infoLabel.numberOfLines = 0
        self.infoLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(updateInfoLrMargin)
            make.trailing.equalToSuperview().offset(-updateInfoLrMargin)
            make.width.equalToSuperview().offset(-updateInfoLrMargin * 2.0)
            make.top.bottom.equalToSuperview()
        }
    }

}

// MARK: - 数据处理与加载

extension VerionUpdateController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        self.setupModel(self.model)
    }
    fileprivate func setupModel(_ model: ServerVesionModel?) -> Void {
        guard let model = model else {
            return
        }
        self.cancelBtn.isHidden = model.isForced
        self.versionLabel.text = "V" + model.version
        self.loadReleaseInfoWithContent(model.desc)
    }

    /// 更新内容使用文本方式加载
    fileprivate func loadReleaseInfoWithContent(_ content: String) -> Void {
        // update-Att
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 0
        style.headIndent = 0
        style.lineSpacing = 2
        style.paragraphSpacing = 10
        let att: [NSAttributedString.Key : Any] = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x666666)]
        let attText = NSAttributedString(string: content, attributes: att)
        self.infoLabel.attributedText = attText
        self.view.layoutIfNeeded()
    }

    /// 更新内容使用网页方式加载
    fileprivate func loadReleaseInfoWithMarkdown(_ markdown: String) -> Void {

    }

}

// MARK: - 事件响应

extension VerionUpdateController {
    // 1. 更新按钮点击响应
    @objc fileprivate func updateBtnClick(_ button: UIButton) -> Void {
        VersionManager.share.updateInSafari()
    }
    // 2. 取消按钮点击响应
    @objc fileprivate func cancelBtnClick(_ button: UIButton) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Notification

extension VerionUpdateController {

}

// MARK: - Delegate Function

extension VerionUpdateController {

}

// MARK: - Extension Function

extension VerionUpdateController {

}
