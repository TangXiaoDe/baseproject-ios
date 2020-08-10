//
//  LoadingAnimationTestController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/16.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  加载中动画测试界面

import UIKit
import NVActivityIndicatorView

/// 加载中动画测试界面
class LoadingAnimationTestController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property

    let loadingContainer: UIView = UIView()
    let imageView: UIImageView = UIImageView()

    let statusBtn: UIButton = UIButton.init(type: .custom)
    weak var indicatorView: NVActivityIndicatorView!


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
extension LoadingAnimationTestController {
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
extension LoadingAnimationTestController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        // navbar
        self.navigationItem.title = "加载动画"

        self.view.addSubview(self.statusBtn)
        self.statusBtn.set(title: "Start", titleColor: UIColor.white, for: .normal)
        self.statusBtn.set(title: "Stop", titleColor: UIColor.white, for: .selected)
        self.statusBtn.set(font: UIFont.pingFangSCFont(size: 15), cornerRadius: 5)
        self.statusBtn.addTarget(self, action: #selector(statusBtnClick(_:)), for: .touchUpInside)
        self.statusBtn.backgroundColor = AppColor.theme
        self.statusBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(35)
            make.top.equalToSuperview().offset(25)
        }

        // loading
        self.view.addSubview(self.loadingContainer)
        self.loadingContainer.backgroundColor = UIColor.white
        self.loadingContainer.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
        self.loadingContainer.addSubview(self.imageView)
        self.imageView.set(cornerRadius: 0)
        self.imageView.image = UIImage.init(named: "IMG_icon_loading")
        self.imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.center.equalToSuperview()
        }

        //IndicatorView
//         = NVActivityIndicatorView.init
        //let indicatorView = NVActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), type: NVActivityIndicatorType.ballClipRotatePulse, color: UIColor.white, padding: 0)
        let indicatorView = NVActivityIndicatorView.init(frame: CGRect.zero)
        indicatorView.type = NVActivityIndicatorType.ballClipRotatePulse
        indicatorView.color = UIColor.white
        indicatorView.padding = 0
        self.view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-75)
        }
        self.indicatorView = indicatorView


    }

}

// MARK: - Data(数据处理与加载)
extension LoadingAnimationTestController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension LoadingAnimationTestController {
    @objc fileprivate func statusBtnClick(_ button: UIButton) -> Void {
        button.isSelected = !button.isSelected
        if button.isSelected {
            self.startLoading()
        } else {
            self.stopLoading()
        }
    }
    internal override func startLoading() -> Void {

        // 旋转动画
        //self.imageView.layer.add(self.getRotateAnmation(), forKey: nil)
        // 缩放动画
//        self.imageView.layer.add(self.getScaleAnmation("transform.scale.x"), forKey: nil)
//        self.imageView.layer.add(self.getScaleAnmation("transform.scale.y"), forKey: nil)

        self.indicatorView.startAnimating()

        // 缩小动画、放大动画



    }
    internal override func stopLoading() -> Void {

    }

    // 缩放动画
    fileprivate func getScaleAnmation(_ keyPath: String) -> CABasicAnimation {
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: keyPath)
        animation.toValue = 0.25
        animation.duration = 1.0
        animation.autoreverses = false
        animation.isCumulative = false
        animation.fillMode = .forwards
        animation.repeatCount = 10
        //animation.delegate = self
        return animation
    }

    // 旋转
    fileprivate func getRotateAnmation() -> CABasicAnimation {
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.x")
        animation.toValue = CGFloat(Double.pi / 4)
        animation.duration = 0.5
        animation.autoreverses = false
        animation.isCumulative = false
        animation.fillMode = .forwards
        animation.repeatCount = 10
        //animation.delegate = self
        return animation

    }

    // 组合动画


}

// MARK: - Enter Page
extension LoadingAnimationTestController {

}

// MARK: - Notification
extension LoadingAnimationTestController {

}

// MARK: - Extension Function
extension LoadingAnimationTestController {

}

// MARK: - Delegate Function

// MARK: - <>
extension LoadingAnimationTestController {

}
