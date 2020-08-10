//
//  PageDefaultEmptyView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/6/30.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  页面默认为空的视图

import UIKit

class PageDefaultEmptyView: UIView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    
    // MARK: - Private Property
    
    let mainView: UIView = UIView()
    let emptyContaienr: UIView = UIView.init()
    let iconView: UIImageView = UIImageView.init()
    let titleLabel: UILabel = UILabel.init()
    
//    fileprivate let iconSize: CGSize = CGSize.init(width: 0, height: 0 )
    
    
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
extension PageDefaultEmptyView {
    class func loadXib() -> PageDefaultEmptyView? {
        return Bundle.main.loadNibNamed("PageDefaultEmptyView", owner: nil, options: nil)?.first as? PageDefaultEmptyView
    }
}

// MARK: - LifeCircle Function
extension PageDefaultEmptyView {
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
extension PageDefaultEmptyView {
    
    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.backgroundColor = UIColor.init(hex: 0xf1f2f5)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. emptyContainer
        mainView.addSubview(self.emptyContaienr)
        self.emptyContaienr.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        // 1.1 iconView
        self.emptyContaienr.addSubview(self.iconView)
        self.iconView.image = UIImage.init(named: "IMG_bg_placeholder_empty_address")
        self.iconView.set(cornerRadius: 0)
        self.iconView.snp.makeConstraints { (make) in
            
            
        }
        // 1.2 titleLabel
        self.emptyContaienr.addSubview(self.titleLabel)
        self.titleLabel.set(text: "暂无内容~", font: UIFont.pingFangSCFont(size: 14, weight: .medium), textColor: UIColor.init(hex: 0x333333), alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
// MARK: - Private UI Xib加载后处理
extension PageDefaultEmptyView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultEmptyView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultEmptyView {
    
}

// MARK: - Extension Function
extension PageDefaultEmptyView {
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PageDefaultEmptyView {
    
}


