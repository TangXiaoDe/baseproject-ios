//
//  PageDefaultNothingView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/6/30.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  页面默认图 - 什么都不显示或仅显示背景色

import UIKit

typealias PageDefaultView = PageDefaultNothingView
class PageDefaultNothingView: UIView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    
    // MARK: - Private Property
    
    let mainView: UIView = UIView()
    
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
extension PageDefaultNothingView {
    class func loadXib() -> PageDefaultNothingView? {
        return Bundle.main.loadNibNamed("PageDefaultNothingView", owner: nil, options: nil)?.first as? PageDefaultNothingView
    }
}

// MARK: - LifeCircle Function
extension PageDefaultNothingView {
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
extension PageDefaultNothingView {
    
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
        
    }
    
}
// MARK: - Private UI Xib加载后处理
extension PageDefaultNothingView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultNothingView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultNothingView {
    
}

// MARK: - Extension Function
extension PageDefaultNothingView {
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PageDefaultNothingView {
    
}


