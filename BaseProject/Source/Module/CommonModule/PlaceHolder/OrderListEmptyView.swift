//
//  OrderListEmptyView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  订单列表空视图

import UIKit

protocol OrderListEmptyViewProtocol: class {
    /// 点击添加按钮回调
    func emptyView(_ emptyView: OrderListEmptyView, didClickedAdd addBtn: UIButton) -> Void
}

class OrderListEmptyView: UIView {

    // MARK: - Internal Property

    weak var delegate: OrderListEmptyViewProtocol?
    var addClickAction:((_ emptyView: OrderListEmptyView, _ addBtn: UIButton) -> Void)?

    // MARK: - Private Property

    fileprivate let mainView: UIView = UIView()

    fileprivate let iconView: UIImageView = UIImageView()
    fileprivate let promptLabel: UILabel = UILabel()
    /// 添加按钮 - 添加订单/随便逛逛
    fileprivate let addBtn: UIButton = UIButton(type: .custom)

    fileprivate let addBtnH: CGFloat = 40

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
extension OrderListEmptyView {
    class func loadXib() -> OrderListEmptyView? {
        return Bundle.main.loadNibNamed("OrderListEmptyView", owner: nil, options: nil)?.first as? OrderListEmptyView
    }
}

// MARK: - LifeCircle Function
extension OrderListEmptyView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension OrderListEmptyView {

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
        // 2. promptLabel
        mainView.addSubview(self.promptLabel)
        self.promptLabel.set(text: "您暂时没有订单记录", font: UIFont.systemFont(ofSize: 15), textColor: UIColor(hex: 0x333333), alignment: .center)
        self.promptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview().offset(5)
        }
        // 1. iconView
        mainView.addSubview(self.iconView)
        self.iconView.contentMode = .bottom
        self.iconView.image = UIImage(named: "IMG_icon_closeeye")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.promptLabel.snp.top).offset(-20)
        }
        // 3. addBtn
        mainView.addSubview(self.addBtn)
        self.addBtn.addTarget(self, action: #selector(addBtnClick(_:)), for: .touchUpInside)
        self.addBtn.set(title: "随便逛逛", titleColor: UIColor(hex: 0x333333), for: .normal)
        self.addBtn.setBackgroundImage(UIImage.imageWithColor(UIColor(hex: 0xfecc47)), for: .normal)
        self.addBtn.set(font: UIFont.systemFont(ofSize: 15), cornerRadius: 5, borderWidth: 0, borderColor: UIColor.clear)
        self.addBtn.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(self.addBtnH)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.promptLabel.snp.bottom).offset(50)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension OrderListEmptyView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function

// MARK: - Event Function
extension OrderListEmptyView {
    /// 添加按钮点击
    @objc fileprivate func addBtnClick(_ button: UIButton) -> Void {
        self.delegate?.emptyView(self, didClickedAdd: button)
        self.addClickAction?(self, button)
    }
}

// MARK: - Extension Function
