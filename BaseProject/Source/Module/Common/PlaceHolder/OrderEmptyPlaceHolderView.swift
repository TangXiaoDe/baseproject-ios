//
//  OrderPlaceHolderView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  订单列表为空时的占位图

import UIKit

typealias OrderEmptyDefaultViewProtocol = OrderEmptyPlaceHolderViewProtocol
typealias OrderPlaceHolderViewProtocol = OrderEmptyPlaceHolderViewProtocol
protocol OrderEmptyPlaceHolderViewProtocol: class {
    /// 点击随便逛逛按钮回调
    func orderPlaceHolderView(_ placeHolderView: OrderEmptyPlaceHolderView, didClickedDone doneBtn: UIButton) -> Void
}

typealias OrderEmptyDefaultView = OrderEmptyPlaceHolderView
typealias OrderPlaceHolderView = OrderEmptyPlaceHolderView
class OrderEmptyPlaceHolderView: UIView {

    // MARK: - Internal Property

    weak var delegate: OrderEmptyPlaceHolderViewProtocol?
    var doneClickAction:((_ emptyView: OrderEmptyPlaceHolderView, _ doneBtn: UIButton) -> Void)?

    var prompt: String? {
        didSet {
            self.promptLabel.text = prompt
        }
    }

    // MARK: - Private Property

    let mainView: UIView = UIView()
    let iconView: UIImageView = UIImageView()
    let promptLabel: UILabel = UILabel()
    let doneBtn: UIButton = UIButton(type: .custom)

    fileprivate let doneBtnW: CGFloat = 200
    fileprivate let doneBtnH: CGFloat = 40
    fileprivate let iconTopMargin: CGFloat = 75
    fileprivate let promptTopMargin: CGFloat = 20
    fileprivate let doneBtnTopMargin: CGFloat = 60

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
extension OrderEmptyPlaceHolderView {
    class func loadXib() -> OrderEmptyPlaceHolderView? {
        return Bundle.main.loadNibNamed("OrderEmptyPlaceHolderView", owner: nil, options: nil)?.first as? OrderEmptyPlaceHolderView
    }
}

// MARK: - LifeCircle Function
extension OrderEmptyPlaceHolderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension OrderEmptyPlaceHolderView {

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
        self.iconView.image = UIImage(named: "IMG_bg_placeholder_empty_order")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            //make.top.equalToSuperview().offset(iconTopMargin)
            make.bottom.equalTo(mainView.snp.centerY).offset(-50)
        }
        // 2. promptLabel
        mainView.addSubview(self.promptLabel)
        self.promptLabel.set(text: "您暂时没有订单记录", font: UIFont.systemFont(ofSize: 15), textColor: UIColor(hex: 0x333333), alignment: .center)
        self.promptLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(promptTopMargin)
        }
        // 3. doneBtn
        mainView.addSubview(self.doneBtn)
        let gradientLayer = AppUtil.commonGradientLayer()
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: self.doneBtnW, height: self.doneBtnH)
        gradientLayer.cornerRadius = self.doneBtnH * 0.5
        self.doneBtn.layer.addSublayer(gradientLayer)
        self.doneBtn.addTarget(self, action: #selector(doneBtnClick(_:)), for: .touchUpInside)
        self.doneBtn.set(title: "随便逛逛", titleColor: UIColor.white, for: .normal)
        self.doneBtn.set(font: UIFont.systemFont(ofSize: 18), cornerRadius: self.doneBtnH * 0.5, borderWidth: 0, borderColor: UIColor.clear)
        self.doneBtn.snp.makeConstraints { (make) in
            make.width.equalTo(self.doneBtnW)
            make.height.equalTo(self.doneBtnH)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.promptLabel.snp.bottom).offset(doneBtnTopMargin)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension OrderEmptyPlaceHolderView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function

// MARK: - Event Function
extension OrderEmptyPlaceHolderView {
    /// 确定按钮点击
    @objc fileprivate func doneBtnClick(_ button: UIButton) -> Void {
        self.delegate?.orderPlaceHolderView(self, didClickedDone: button)
        self.doneClickAction?(self, button)
    }
}

// MARK: - data
extension OrderEmptyPlaceHolderView {

}
