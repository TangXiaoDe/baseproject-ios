//
//  BubbleTestController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  气泡测试界面

import UIKit

class BubbleTestController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property

    fileprivate let bubbleView: UnreadNumBubbleView = UnreadNumBubbleView()



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
extension BubbleTestController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

// MARK: - UI
extension BubbleTestController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        // navbar
        self.navigationItem.title = "Bubble"


        // bubbleView
        self.view.addSubview(self.bubbleView)
        self.bubbleView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.top).offset(55)
        }
    }

}

// MARK: - Data(数据处理与加载)
extension BubbleTestController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension BubbleTestController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.bubbleView.unreadNum = 5
    }
}

// MARK: - Enter Page
extension BubbleTestController {

}

// MARK: - Notification
extension BubbleTestController {

}

// MARK: - Extension Function
extension BubbleTestController {

}

// MARK: - Delegate Function

// MARK: - <>
extension BubbleTestController {

}
