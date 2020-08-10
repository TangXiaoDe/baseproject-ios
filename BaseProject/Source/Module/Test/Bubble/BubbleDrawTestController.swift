//
//  BubbleDrawTestController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/10/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  气泡绘制测试界面

import UIKit

/// 气泡绘制测试界面
class BubbleDrawTestController: BaseViewController
{
    // MARK: - Internal Property
    
    // MARK: - Private Property
    
    fileprivate let testView: BubbleDrawTestView = BubbleDrawTestView.init()
    
    // MARK: - Initialize Function
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function

// MARK: - LifeCircle & Override Function
extension BubbleDrawTestController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }
    
}

// MARK: - UI
extension BubbleDrawTestController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.addSubview(self.testView)
        self.testView.backgroundColor = UIColor.lightGray
        self.testView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(self.view.snp.bottomMargin)
        }
    }

}

// MARK: - Data(数据处理与加载)
extension BubbleDrawTestController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        
    }

}

// MARK: - Event(事件响应)
extension BubbleDrawTestController {


}

// MARK: - Enter Page
extension BubbleDrawTestController {
    
}

// MARK: - Notification
extension BubbleDrawTestController {
    
}

// MARK: - Extension Function
extension BubbleDrawTestController {
    
}

// MARK: - Delegate Function

// MARK: - <>
extension BubbleDrawTestController {
    
}

