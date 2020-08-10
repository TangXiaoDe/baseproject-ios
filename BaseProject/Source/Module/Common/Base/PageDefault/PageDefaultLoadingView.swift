//
//  PageDefaultLoadingView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/6/30.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  页面默认加载中的视图

import UIKit

class PageDefaultLoadingView: UIView
{
    
    // MARK: - Internal Property
    
    // MARK: - Private Property
    
    let mainView: UIView = UIView()
    
    let loadingContaienr: UIView = UIView.init()
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init()
    let loadingTitleLabel: UILabel = UILabel.init()
    
    /// 加载中动画容器
    let loadingAnimaContainer: UIView = UIView.init()
    
    fileprivate let loadingContainerWidth: CGFloat = 85
    fileprivate let loadingContainerHeight: CGFloat = 80
    fileprivate let loadingIndicatorWH: CGFloat = 25
    
    
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
extension PageDefaultLoadingView {
    class func loadXib() -> PageDefaultLoadingView? {
        return Bundle.main.loadNibNamed("PageDefaultLoadingView", owner: nil, options: nil)?.first as? PageDefaultLoadingView
    }


    
}

// MARK: - LifeCircle Function
extension PageDefaultLoadingView {
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
extension PageDefaultLoadingView {
    
    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.backgroundColor = UIColor.init(hex: 0xf1f2f5)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // loadingContainer
        mainView.addSubview(self.loadingContaienr)
        self.initialLoadingContainer(self.loadingContaienr)
        self.loadingContaienr.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(self.loadingContainerWidth)
            make.height.equalTo(self.loadingContainerHeight)
        }
        // loadingAnimaContainer
        
        
        
    }
    fileprivate func initialLoadingContainer(_ loadingContainer: UIView) -> Void {
        loadingContainer.backgroundColor = UIColor.white
        loadingContaienr.set(cornerRadius: 10)
        // loadingIndicator
        loadingContainer.addSubview(self.loadingIndicator)
        self.loadingIndicator.color = UIColor.darkGray
        self.loadingIndicator.snp.makeConstraints { (make) in
            //make.width.height.equalTo(self.loadingIndicatorWH)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        // loadingTitleLabel
        loadingContainer.addSubview(self.loadingTitleLabel)
        self.loadingTitleLabel.set(text: "加载中...", font: UIFont.pingFangSCFont(size: 14), textColor: UIColor.init(hex: 0x333333), alignment: .center)
        self.loadingTitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.loadingIndicator.snp.bottom).offset(10)
        }
    }
    
}
// MARK: - Private UI Xib加载后处理
extension PageDefaultLoadingView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultLoadingView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultLoadingView {
    
}

// MARK: - Extension Function
extension PageDefaultLoadingView {
    
}

// MARK: - Delegate Function

// MARK: - <PageLoadingViewProtocol>
extension PageDefaultLoadingView: PageLoadingView {
    func startLoading() -> Void {
        self.loadingIndicator.startAnimating()
    }
    func stopLoading() -> Void {
        self.loadingIndicator.stopAnimating()
    }

}



