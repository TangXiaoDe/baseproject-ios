//
//  PageDefaultTobeOpenedView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/7/6.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  该功能暂未上线默认图

import UIKit

class PageDefaultTobeOpenedView: UIView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    
    // MARK: - Private Property
    
    let mainView: UIView = UIView()
    let bgLayer: CAGradientLayer = AppUtil.commonGradientLayer()
    let iconView: UIImageView = UIImageView.init()
    let titleLabel: UILabel = UILabel.init()
    
    // MARK: - Initialize Function
    init() {
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
    }
    
}

// MARK: - Internal Function
extension PageDefaultTobeOpenedView {
    class func loadXib() -> PageDefaultTobeOpenedView? {
        return Bundle.main.loadNibNamed("PageDefaultTobeOpenedView", owner: nil, options: nil)?.first as? PageDefaultTobeOpenedView
    }
}

// MARK: - LifeCircle Function
extension PageDefaultTobeOpenedView {
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
extension PageDefaultTobeOpenedView {
    
    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.backgroundColor = AppColor.pageBg
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. bg
        // 2.
    
    }
    
}
// MARK: - Private UI Xib加载后处理
extension PageDefaultTobeOpenedView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultTobeOpenedView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultTobeOpenedView {
    
}

// MARK: - Extension Function
extension PageDefaultTobeOpenedView {
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PageDefaultTobeOpenedView {
    
}


