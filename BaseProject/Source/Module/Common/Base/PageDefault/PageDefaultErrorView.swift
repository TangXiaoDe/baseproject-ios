//
//  PageDefaultErrorView.swift
//  XiaoDeSample
//
//  Created by 小唐 on 2020/7/6.
//  Copyright © 2020 XiaoDeStudio. All rights reserved.
//
//  页面默认错误视图

import UIKit

protocol PageDefaultErrorViewProtocol: class {
    /// 默认网络错误视图中重新加载控件点击回调
    func defaultErrorView(_ errorView: PageDefaultErrorView, didClickedReload reloadView: UIView) -> Void
}

class PageDefaultErrorView: UIView, PageErrorView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    weak var delegate: PageDefaultErrorViewProtocol?
    
    // MARK: - Private Property
    
    let mainView: UIView = UIView()
    let errorContaienr: UIView = UIView.init()
    let iconView: UIImageView = UIImageView.init()
    let titleLabel: UILabel = UILabel.init()
    
    let reloadBtn: UIButton = UIButton.init(type: .custom)
    
    fileprivate let reloadBtnSize: CGSize = CGSize.init(width: 200, height: 40)

    
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
extension PageDefaultErrorView {
    class func loadXib() -> PageDefaultErrorView? {
        return Bundle.main.loadNibNamed("PageDefaultErrorView", owner: nil, options: nil)?.first as? PageDefaultErrorView
    }
}

// MARK: - LifeCircle Function
extension PageDefaultErrorView {
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
extension PageDefaultErrorView {
    
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
        // 1. iconView
        // 2. titleLabel
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: "加载错误，请重新加载", font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.init(hex: 0x525C6E), alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        // 3. reloadBtn
        mainView.addSubview(self.reloadBtn)
        self.reloadBtn.set(title: "重新加载", titleColor: AppColor.theme, for: .normal)
        self.reloadBtn.set(title: "重新加载", titleColor: AppColor.theme, for: .highlighted)
        self.reloadBtn.set(font: UIFont.pingFangSCFont(size: 18), cornerRadius: self.reloadBtnSize.height * 0.5, borderWidth: 1, borderColor: AppColor.theme)
        self.reloadBtn.addTarget(self, action: #selector(reloadBtnClick(_:)), for: .touchUpInside)
        self.reloadBtn.snp.makeConstraints { (make) in
            make.size.equalTo(self.reloadBtnSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(25)
        }
    }
    
}
// MARK: - Private UI Xib加载后处理
extension PageDefaultErrorView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension PageDefaultErrorView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension PageDefaultErrorView {
    @objc fileprivate func reloadBtnClick(_ button: UIButton) -> Void {
        self.delegate?.defaultErrorView(self, didClickedReload: button)
    }

}

// MARK: - Extension Function
extension PageDefaultErrorView {
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PageDefaultErrorView {
    
}


