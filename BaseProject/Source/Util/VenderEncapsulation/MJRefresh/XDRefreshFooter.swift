//
//  XDRefreshFooter.swift
//  Thinksns Plus
//
//  Created by GorCat on 17/3/20.
//  Copyright © 2017年 ZhiYiCX. All rights reserved.
//
//  上拉加载更多 footer

import UIKit
import MJRefresh

class XDRefreshFooter: MJRefreshAutoGifFooter {

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }

    // MARK: - Custom user interface
    func setUI() {
        // 设置标题
        setTitle("上拉加载更多", for: .idle)
        setTitle("加载更多", for: .willRefresh)
        setTitle("加载更多", for: .refreshing)
        setTitle("加载更多", for: .pulling)
        setTitle("我是有底线的", for: .noMoreData)
        // 设置动画// 图片数组
        var images: [UIImage] = []
        for index in 0...9 {
            let imageName = "IMG_activityIndicator_gray000\(index)"
            let image = UIImage(named: imageName)!
            images.append(image)
        }
        setImages(images, for: .idle)
        setImages(images, for: .willRefresh)
        setImages(images, for: .refreshing)
        setImages(images, for: .pulling)
    }

    // MARK: - Public

    /// 网络异常
    override func endRefreshingWithWeakNetwork() {
        setTitle("请检查你的网络设置", for: .idle)
        super.endRefreshing()
    }

    override func endRefreshing() {
        setTitle("上拉加载更多", for: .idle)
        super.endRefreshing()
    }

}

extension MJRefreshFooter {

    /// 网络异常
    @objc func endRefreshingWithWeakNetwork() {
        endRefreshing()
    }
}
