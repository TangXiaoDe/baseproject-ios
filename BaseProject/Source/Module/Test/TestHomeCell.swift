//
//  TestHomeCell.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/16.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit


class TestHomeCellRedDotBubbleView: UIView {

    let unreadLabel: UILabel = UILabel()

    // MARK: - Initialize Function

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    /// 通用初始化：UI、配置、数据等
    fileprivate func commonInit() -> Void {
        self.initialUI()
    }

    fileprivate func initialUI() -> Void {
        // unreadLabel
        self.addSubview(self.unreadLabel)
        self.unreadLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.white, alignment: .center)
        self.unreadLabel.backgroundColor = UIColor.red
        self.unreadLabel.set(cornerRadius: 10)
        self.unreadLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(30)

            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

}
extension TestHomeCellRedDotBubbleView: RedDotBubbleAttachViewProtocol {
    var bubbleSize: CGSize {
        return self.unreadLabel.bounds.size
    }
}


class TestHomeCell: UITableViewCell {

    // MARK: - Internal Property
    static let cellHeight: CGFloat = 55
    /// 重用标识符
    static let identifier: String = "TestHomeCellReuseIdentifier"

    var indexPath: IndexPath?
    var model: (title: String, unreadNum: Int)? {
        didSet {
            self.setupWithModel(model)
        }
    }

    // MARK: - fileprivate Property

    fileprivate let mainView: UIView = UIView()

    fileprivate let titleLabel: UILabel = UILabel()
    //fileprivate let bubbleView: UnreadNumBubbleView = UnreadNumBubbleView()

    //let unreadLabel: UILabel = UILabel()

    //let bubbleView: UIView = UIView()
    //let unreadLabel: UILabel = UILabel()

    let bubbleView: TestHomeCellRedDotBubbleView = TestHomeCellRedDotBubbleView()

    // MARK: - Initialize Function

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    /// 通用初始化：UI、配置、数据等
    fileprivate func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension TestHomeCell {
    /// 便利构造方法
    class func cellInTableView(_ tableView: UITableView, at indexPath: IndexPath? = nil) -> TestHomeCell {
        let identifier = TestHomeCell.identifier
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if nil == cell {
            cell = TestHomeCell.init(style: .default, reuseIdentifier: identifier)
        }
        // 状态重置
        if let cell = cell as? TestHomeCell {
            cell.resetSelf()
            cell.indexPath = indexPath
        }
        return cell as! TestHomeCell
    }
}

// MARK: - Override Function
extension TestHomeCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - UI 界面布局
extension TestHomeCell {
    // 界面布局
    fileprivate func initialUI() -> Void {
        // mainView - 整体布局，便于扩展，特别是针对分割、背景色、四周间距
        self.contentView.addSubview(mainView)
        self.initialMainView(self.mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    // 主视图布局
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.backgroundColor = UIColor.white
        // title
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 15), textColor: UIColor.init(hex: 0x333333))
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }

//        // bubble
//        mainView.addSubview(self.bubbleView)
//        self.bubbleView.isHidden = true
//        self.bubbleView.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview()
//        }

//        // unreadLabel
//        mainView.addSubview(self.unreadLabel)
//        self.unreadLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.white, alignment: .center)
//        self.unreadLabel.backgroundColor = UIColor.red
//        self.unreadLabel.set(cornerRadius: 10)
//        self.unreadLabel.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.height.equalTo(20)
//            make.width.greaterThanOrEqualTo(30)
//            make.trailing.equalToSuperview().offset(-12)
//        }

//        // bubbleView
//        mainView.addSubview(self.bubbleView)
//        self.bubbleView.backgroundColor = UIColor.lightGray
//        self.bubbleView.snp.makeConstraints { (make) in
//            make.centerY.trailing.equalToSuperview()
//        }
//        // unreadLabel
//        self.bubbleView.addSubview(self.unreadLabel)
//        self.unreadLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.white, alignment: .center)
//        self.unreadLabel.backgroundColor = UIColor.red
//        self.unreadLabel.set(cornerRadius: 10)
//        self.unreadLabel.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.height.equalTo(20)
//            make.width.greaterThanOrEqualTo(30)
//
//            make.trailing.equalToSuperview().offset(-12)
//            make.leading.equalToSuperview().offset(12)
//            make.top.equalToSuperview().offset(12)
//            make.bottom.equalToSuperview().offset(-12)
//        }

        // bubbleView
        mainView.addSubview(self.bubbleView)
        self.bubbleView.snp.makeConstraints { (make) in
            make.centerY.trailing.equalToSuperview()
        }

    }
}

// MARK: - Data 数据加载
extension TestHomeCell {
    /// 重置
    fileprivate func resetSelf() -> Void {
        self.selectionStyle = .none
        self.titleLabel.text = nil
        //self.bubbleView.isHidden = true
        //self.unreadLabel.text = nil
    }
    /// 数据加载
    fileprivate func setupWithModel(_ model: (title: String, unreadNum: Int)?) -> Void {
        guard let model = model else {
            return
        }
        self.titleLabel.text = model.title
        //self.bubbleView.unreadNum = model.unreadNum
        //self.unreadLabel.text = "\(model.unreadNum)"

        self.bubbleView.unreadLabel.text = "\(model.unreadNum)"
    }

}

// MARK: - Event  事件响应
extension TestHomeCell {

}
