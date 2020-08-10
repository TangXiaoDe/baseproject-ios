//
//  RootViewController.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  根控界面
//  1. 使用请参考RootManager；
//  2. 常驻线程的使用；

import UIKit
import ChainOneKit

/// 实际的根控界面
class RootViewController: BaseViewController {

    /// 需要展示的根控界面
    var showRootVC: UIViewController = UIViewController() {
        didSet {
            self.setupRootVC(showRootVC, oldValue: oldValue)
        }
    }

    /// 全局线程对象
    fileprivate var thread: Thread?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.showRootVC.view)
        self.addChild(self.showRootVC)
        self.showRootVC.view.frame = UIScreen.main.bounds

        // 初始化线程并启动
        let thread = Thread.init(target: self, selector: #selector(run), object: nil)
        thread.start()
        self.thread = thread
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 第一次显示，获取系统配置，若失败，则显示系统配置失败界面
        if 1 == self.didAppearTime {
            self.getSystemConfig()
        }
    }
    
    
    fileprivate func setupRootVC(_ rootVC: UIViewController, oldValue: UIViewController) -> Void {
        if oldValue == rootVC {
            return
        }
        // 页面过渡动画添加处
        oldValue.view.removeFromSuperview()
        oldValue.removeFromParent()
        self.view.addSubview(rootVC.view)
        rootVC.view.frame = UIScreen.main.bounds
        self.addChild(rootVC)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @objc fileprivate func run() -> Void {
        // 开启常驻线程
        RunLoop.current.add(Port.init(), forMode: RunLoop.Mode.default)
        RunLoop.current.run()
    }

    fileprivate func messageProcess() -> Void {
        // 使用常驻线程处理事情
        self.perform(#selector(action), on: self.thread!, with: nil, waitUntilDone: false)
    }
    @objc fileprivate func action() -> Void {
        print("RootViewController action")
    }
    
    /// 获取系统配置
    fileprivate func getSystemConfig() -> Void {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.5) {
            self.contentType = .error
        }
    }

}
