//
//  PageDefaultServerErrorView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/6/30.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  页面默认服务器异常视图

import UIKit

protocol PageDefaultServerErrorViewProtocol: class {
    /// 默认网络错误视图中重新加载控件点击回调
    func defaultServerErrorView(_ errorView: PageDefaultServerErrorView, didClickedReload reloadView: UIView) -> Void
}

class PageDefaultServerErrorView: UIView, PageErrorView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    weak var delegate: PageDefaultServerErrorViewProtocol?
    
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
extension PageDefaultServerErrorView {
    class func loadXib() -> PageDefaultServerErrorView? {
        return Bundle.main.loadNibNamed("PageDefaultServerErrorView", owner: nil, options: nil)?.first as? PageDefaultServerErrorView
    }
}

// MARK: - LifeCircle Function
extension PageDefaultServerErrorView {
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
extension PageDefaultServerErrorView {
    
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
extension PageDefaultServerErrorView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultServerErrorView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultServerErrorView {
    
}

// MARK: - Extension Function
extension PageDefaultServerErrorView {
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PageDefaultServerErrorView {
    
}


