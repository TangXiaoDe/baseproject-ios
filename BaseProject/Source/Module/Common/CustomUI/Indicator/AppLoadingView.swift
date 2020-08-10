//
//  AppLoadingView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/16.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  加载中视图

import UIKit
import NVActivityIndicatorView

/// 加载中视图
class AppLoadingView: UIView {

    // MARK: - Internal Property

    var title: String? = nil {
        didSet {
            self.setupWithTitle(title)
        }
    }


    // MARK: - Private Property

    fileprivate let coverBtn: UIButton = UIButton.init(type: .custom)
    fileprivate let mainView: UIView = UIView()
    fileprivate let indicatorView: NVActivityIndicatorView = NVActivityIndicatorView.init(frame: CGRect.zero)
    fileprivate let titleLabel: UILabel = UILabel()

    fileprivate let mainWH: CGFloat = 140
    fileprivate let indicatorWH: CGFloat = 44


    // MARK: - Initialize Function
    init(title: String? = "请求中") {
        self.title = title
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        //fatalError("init(coder:) has not been implemented")
    }

    /// 通用初始化：UI、配置、数据等
    func commonInit() -> Void {
        self.initialUI()
        self.setupWithTitle(self.title)
    }

}

// MARK: - Internal Function
extension AppLoadingView {
    class func loadXib() -> AppLoadingView? {
        return Bundle.main.loadNibNamed("AppLoadingView", owner: nil, options: nil)?.first as? AppLoadingView
    }

    func show(on view: UIView? = nil, timeInterval: TimeInterval? = nil) -> Void {
        //var superView: UIView = RootManager.share.rootVC.view   // UIApplication.share.keyWindow
        var superView: UIView = RootManager.share.topRootVC.view   // UIApplication.share.keyWindow
        if let view = view {
            superView = view
        }
        superView.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.indicatorView.startAnimating()
        if let timeInterval = timeInterval {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) {
                self.indicatorView.stopAnimating()
                self.removeFromSuperview()
            }
        }
    }

    func dismiss() -> Void {
        self.indicatorView.stopAnimating()
        self.removeFromSuperview()
    }


}

// MARK: - LifeCircle Function
extension AppLoadingView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }

    /// 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
// MARK: - Private UI 手动布局
extension AppLoadingView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 1. coverBtn
        self.addSubview(self.coverBtn)
        self.coverBtn.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        self.coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. mainView
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(self.mainWH)
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.set(cornerRadius: 10)
        mainView.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        // 1. indicator
        mainView.addSubview(self.indicatorView)
        self.indicatorView.type = NVActivityIndicatorType.ballClipRotatePulse
        self.indicatorView.color = UIColor.init(hex: 0x00bdb2)
        self.indicatorView.padding = 0
        self.indicatorView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.indicatorWH)
            make.centerX.equalToSuperview()
            // 34 + 22 = 56
            // 140 * 2 = 70
            make.centerY.equalToSuperview().offset(-15)
        }
        // 2. titleLabel
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 15), textColor: UIColor.init(hex: 0x00bdb2), alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(mainView.snp.top).offset(self.mainWH * 0.75)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension AppLoadingView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension AppLoadingView {
    /// 数据加载
    fileprivate func setupWithTitle(_ title: String?) -> Void {
        self.titleLabel.text = title
        if let title = title, !title.isEmpty {
            self.indicatorView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(-15)
            }
        } else {
            self.indicatorView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(0)
            }
        }
    }

}

// MARK: - Event Function
extension AppLoadingView {
    /// 遮罩按钮点击
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {

    }

}

// MARK: - Extension Function
extension AppLoadingView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension AppLoadingView {

}
