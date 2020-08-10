//
//  XDRefreshHeader.swift
//  Thinksns Plus
//
//  Created by GorCat on 17/3/20.
//  Copyright © 2017年 ZhiYiCX. All rights reserved.
//
//  下拉刷新 header

import UIKit
import MJRefresh

class XDRefreshHeader: MJRefreshGifHeader {

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
        // 下拉刷新图片数组
        var images: [UIImage] = []
        for index in 0...14 {
            //let imageName = String.init(format: "IMG_refresh_header_000%02d", index)
            let imageName = String.init(format: "refresh_icon_header_000%02d", index)
            let image = UIImage(named: imageName)!
            images.append(image)
        }
        // 设置动画
        setImages(images, for: .idle)
        setImages(images, for: .pulling)
        setImages(images, for: .refreshing)
        // 隐藏时间
        lastUpdatedTimeLabel.isHidden = true
        // 隐藏状态
        stateLabel.isHidden = true
    }
}
