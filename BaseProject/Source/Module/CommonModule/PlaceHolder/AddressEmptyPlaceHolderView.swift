//
//  AddressEmptyPlaceHolderView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/18.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  地址列表为空时的视图

import UIKit

typealias AddressListEmptyViewProtocol = AddressEmptyPlaceHolderViewProtocol
typealias AddressPlaceHolderViewProtocol = AddressEmptyPlaceHolderViewProtocol
protocol AddressEmptyPlaceHolderViewProtocol: class {
    /// 点击添加按钮回调
    func emptyView(_ emptyView: AddressEmptyPlaceHolderView, didClickedAdd addBtn: UIButton) -> Void
}

typealias AddressListEmptyView = AddressEmptyPlaceHolderView
typealias AddressPlaceHolderView = AddressEmptyPlaceHolderView
class AddressEmptyPlaceHolderView: UIView {

    // MARK: - Internal Property

    weak var delegate: AddressEmptyPlaceHolderViewProtocol?
    var addClickAction:((_ emptyView: AddressEmptyPlaceHolderView, _ addBtn: UIButton) -> Void)?

    var prompt: String? {
        didSet {
            self.promptLabel.text = prompt
        }
    }

    // MARK: - Private Property

    let mainView: UIView = UIView()
    let iconView: UIImageView = UIImageView()
    let promptLabel: UILabel = UILabel()
    let addBtn: UIButton = UIButton(type: .custom)

    fileprivate let addBtnW: CGFloat = 200
    fileprivate let addBtnH: CGFloat = 40
    fileprivate let iconTopMargin: CGFloat = 75
    fileprivate let promptTopMargin: CGFloat = 20
    fileprivate let addBtnTopMargin: CGFloat = 60

     // MARK: - emptyContent

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension AddressEmptyPlaceHolderView {
    class func loadXib() -> AddressEmptyPlaceHolderView? {
        return Bundle.main.loadNibNamed("AddressEmptyPlaceHolderView", owner: nil, options: nil)?.first as? AddressEmptyPlaceHolderView
    }
}

// MARK: - LifeCircle Function
extension AddressEmptyPlaceHolderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension AddressEmptyPlaceHolderView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.backgroundColor = UIColor.white
        // 1. iconView
        mainView.addSubview(self.iconView)
        self.iconView.image = UIImage(named: "IMG_bg_placeholder_empty_address")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            //make.top.equalToSuperview().offset(iconTopMargin)
            make.bottom.equalTo(mainView.snp.centerY).offset(-50)
        }
        // 2. promptLabel
        mainView.addSubview(self.promptLabel)
        self.promptLabel.set(text: "您还没有收货地址哦！", font: UIFont.systemFont(ofSize: 15), textColor: UIColor(hex: 0x333333), alignment: .center)
        self.promptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(promptTopMargin)
        }
        // 3. addBtn
        mainView.addSubview(self.addBtn)
        let gradientLayer = AppUtil.commonGradientLayer()
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.addBtnW, height: self.addBtnH)
        gradientLayer.cornerRadius = self.addBtnH * 0.5
        self.addBtn.layer.addSublayer(gradientLayer)
        self.addBtn.addTarget(self, action: #selector(addBtnClick(_:)), for: .touchUpInside)
        self.addBtn.set(title: "新建地址", titleColor: UIColor.white, for: .normal)
        self.addBtn.set(font: UIFont.systemFont(ofSize: 18), cornerRadius: self.addBtnH * 0.5, borderWidth: 0, borderColor: UIColor.clear)
        self.addBtn.snp.makeConstraints { (make) in
            make.width.equalTo(self.addBtnW)
            make.height.equalTo(self.addBtnH)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.promptLabel.snp.bottom).offset(addBtnTopMargin)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension AddressEmptyPlaceHolderView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function

// MARK: - Event Function
extension AddressEmptyPlaceHolderView {
    /// 添加按钮点击
    @objc fileprivate func addBtnClick(_ button: UIButton) -> Void {
        self.delegate?.emptyView(self, didClickedAdd: button)
        self.addClickAction?(self, button)
    }
}

// MARK: - data
extension AddressEmptyPlaceHolderView {
    /// 空值数据修改
    fileprivate func setupWithEmptyContent(_ emptyContent: String?) -> Void {
        guard let emptyContent = emptyContent else {
            return
        }
        self.promptLabel.text = emptyContent
    }
}
