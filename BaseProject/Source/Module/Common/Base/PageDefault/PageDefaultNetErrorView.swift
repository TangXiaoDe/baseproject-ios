//
//  PageDefaultNetErrorView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/6/30.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  页面默认网络错误视图

import UIKit

protocol PageDefaultNetErrorViewProtocol: class {
    /// 默认网络错误视图中重新加载控件点击回调
    func defaultNetErrorView(_ errorView: PageDefaultNetErrorView, didClickedReload reloadView: UIView) -> Void
}

class PageDefaultNetErrorView: UIView, PageErrorView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    weak var delgate: PageDefaultNetErrorViewProtocol?
    
    // MARK: - Private Property
    
    let mainView: UIView = UIView()
    let errorContaienr: UIView = UIView.init()
    let iconView: UIImageView = UIImageView.init()
    let titleLabel: UILabel = UILabel.init()
    
    let reloadBtn: UIButton = UIButton.init(type: .custom)
    
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
extension PageDefaultNetErrorView {
    class func loadXib() -> PageDefaultNetErrorView? {
        return Bundle.main.loadNibNamed("PageDefaultNetErrorView", owner: nil, options: nil)?.first as? PageDefaultNetErrorView
    }
}

// MARK: - LifeCircle Function
extension PageDefaultNetErrorView {
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
extension PageDefaultNetErrorView {
    
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
extension PageDefaultNetErrorView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultNetErrorView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultNetErrorView {
    
}

// MARK: - Extension Function
extension PageDefaultNetErrorView {
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PageDefaultNetErrorView {
    
}


