//
//  IndicatorWindowTop.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/23.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  窗口上方弹窗

import Foundation
import UIKit

enum LoadingState {
    case success
    case faild
    case loading
}

class IndicatorWindowTop: UIView {

    /// 默认的弹窗显示时间
    static let defaultTimeInterval = 1

    /// 信息状态，为 success 表示成功信息，显示蓝色图标；为 faild 表示失败信息，显示红色图标；为 loading 表示加载中，显示小菊花
    var loadingState: LoadingState = .success
    /// 标题
    var _title: String?
    var title: String? {
        set(newValue) {
            _title = newValue
            if let newValue = newValue {
                set(title: newValue)
            }
        }
        get {
            return _title
        }
    }

    /// 状态图标
    let imageViewForState = UIImageView()
    /// 标题
    let labelForTitle = UILabel()

    /// 中心位置
    var midY: CGFloat = 0

    init(state: LoadingState, title: String?) {
        super.init(frame: CGRect(x: 0, y: -kNavigationStatusBarHeight, width: UIScreen.main.bounds.width, height: kNavigationStatusBarHeight))
        loadingState = state
        setUI()
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }

    // MARK: - Custom user interface

    /// 设置视图
    func setUI() {
        backgroundColor = UIColor.white
        midY = (frame.height - kStatusBarHeight) / 2 + kStatusBarHeight

        // state image
        var imageSize: CGSize = .zero
        switch loadingState {
        case .success: // 成功，显示蓝色图标
            let stateImage = UIImage(named: "IMG_indicator_msg_succeed")!
            imageSize = stateImage.size
            imageViewForState.image = stateImage
        case .faild: // 失败，显示红色图标
            let stateImage = UIImage(named: "IMG_indicator_msg_remind")!
            imageSize = stateImage.size
            imageViewForState.image = stateImage
        case .loading: // 加载中，显示小菊花
            var images: [UIImage] = []
            for index in 0...9 {
                let image = UIImage(named: "IMG_indicator_rotate_gray00\(index)")
                imageSize = image!.size
                if let image = image {
                    images.append(image)
                }
            }
            imageViewForState.animationImages = images
            imageViewForState.animationDuration = Double(images.count) / 24.0
            imageViewForState.animationRepeatCount = 0
        }
        imageViewForState.contentMode = .center
        imageViewForState.frame = CGRect(x: 15, y: midY - imageSize.height / 2, width: imageSize.height, height: imageSize.height)

        // title label
        labelForTitle.font = UIFont.systemFont(ofSize: 15)
        labelForTitle.numberOfLines = 0
        labelForTitle.textColor = UIColor(hex: 0x666666)
        // shawdow
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)

        addSubview(imageViewForState)
        addSubview(labelForTitle)
    }

    // MAKR: - Public

    /// 默认动画时间
    private let showAnimationTimeInterval = TimeInterval(1)

    /// 展示显示器
    func show() {
        show(timeInterval: nil)
    }

    func show(timeInterval: Int?, complete: (() -> Void)? = nil) {
        if superview != nil {
            return
        }
        if loadingState == .loading {
            imageViewForState.startAnimating()
        }
        RootManager.share.rootVC.view.addSubview(self)
        UIView.animate(withDuration: showAnimationTimeInterval, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 20, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }) { (_) in
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            if let timeInterval = timeInterval {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(timeInterval * 1_000), execute: { [weak self] in
                    if let weakSelf = self {
                        weakSelf.dismiss()
                        complete?()
                    }
                })
            }
        }
    }

    /// 隐藏显示器
    func dismiss() {
        if self.superview == nil {
            return
        }
        UIView.animate(withDuration: TimeInterval(0.4), animations: {
            self.frame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
        }) { (_) in
            self.removeFromSuperview()
        }
    }

    ///MARK: - Private

    /// 设置标题
    func set(title: String) {
        labelForTitle.text = title
        let labelWidth = UIScreen.main.bounds.width - 50
        let labelHeight = title.size(maxSize: CGSize(width: labelWidth, height: CGFloat(MAXFLOAT)), font: labelForTitle.font!).height
        labelForTitle.frame = CGRect(x: imageViewForState.frame.maxY + 5, y: midY - labelHeight / 2, width: labelWidth, height: labelHeight)
    }
}
