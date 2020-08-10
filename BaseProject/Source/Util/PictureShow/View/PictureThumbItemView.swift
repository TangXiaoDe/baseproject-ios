//
//  PictureThumbItemView.swift
//  ThinkSNSPlus
//
//  Created by 小唐 on 28/06/2018.
//  Copyright © 2018 ZhiYiCX. All rights reserved.
//
//  图片缩略展示时的元素/原子视图

import UIKit
import Kingfisher

class PictureThumbItemView: UIControl {

    // MARK: - Internal Property

    /// 数据
    var model: PictureModel? {
        didSet {
            self.setupWithModel(model)
        }
    }

    /// 图片
    var picture: UIImage? {
        return imageView.image
    }
    /// 在屏幕上的 frame
    var frameOnScreen: CGRect {
        let screenOrigin = imageView.convert(imageView.frame.origin, to: nil)
        return CGRect(origin: screenOrigin, size: size)
    }

    /// 图片占位图
    var placeholder: UIImage {
        return cacheImage ?? UIImage.imageWithColor(AppColor.disable)
    }
    /// 缓存图片
    var cacheImage: UIImage?

    /// 图片标识
    let identifyIcon: UIImageView = UIImageView()
    /// 长图标识
    let longImgIdentifyIcon: UIButton = UIButton.init(type: .custom)
    /// 图片视图
    let imageView: UIImageView = UIImageView()
    /// 未显示图片数量蒙层
    let unShowNumBtn: UIButton = UIButton(type: .custom)

    // MARK: - Private Property

    fileprivate let longIconW: CGFloat = 32
    fileprivate let longIconH: CGFloat = 16

    /// 屏幕比例
    internal let scale = UIScreen.main.scale
    // 加载图片的网络请求头
    internal let modifier = AnyModifier { request in
        var r = request
        if let authorization = AccountManager.share.currentAccountInfo?.token?.token {
            r.setValue("Bearer " + authorization, forHTTPHeaderField: "Authorization")
        }
        return r
    }

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
        self.initialUI()
        //fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCircle Function

}

// MARK: - Internal Function

// MARK: - Private  UI
extension PictureThumbItemView {

    // 界面布局
    fileprivate func initialUI() -> Void {
        // 1.图片视图
        self.addSubview(imageView)
        imageView.set(cornerRadius: 3, borderWidth: 0, borderColor: UIColor.clear)
        //imageView.contentScaleFactor = UIScreen.main.scale
        //imageView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        // 2.图片标识
        self.addSubview(identifyIcon)
//        identifyIcon.image = #imageLiteral(resourceName: "IMG_pic_longpic")
        //identifyIcon.contentMode = .center
        identifyIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.trailing.equalTo(self)
        }
        // 长图标识
        self.addSubview(self.longImgIdentifyIcon)
        self.longImgIdentifyIcon.set(title: "长图", titleColor: UIColor.white, for: .normal)
        self.longImgIdentifyIcon.set(font: UIFont.pingFangSCFont(size: 11), cornerRadius: self.longIconH * 0.5)
        self.longImgIdentifyIcon.backgroundColor = UIColor.init(hex: 0x2B313C).withAlphaComponent(0.4)
        self.longImgIdentifyIcon.isHidden = true
        self.longImgIdentifyIcon.isUserInteractionEnabled = false
        self.longImgIdentifyIcon.snp.makeConstraints { (make) in
            make.width.equalTo(self.longIconW)
            make.height.equalTo(self.longIconH)
            make.top.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
        }

        // 3. 未读数蒙层
        self.addSubview(unShowNumBtn)
        unShowNumBtn.isHidden = true    // 默认隐藏
        //unShowNumBtn.setTitle("+unshowCount", for: .normal)
        unShowNumBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        unShowNumBtn.setTitleColor(.white, for: .normal)
        unShowNumBtn.backgroundColor = UIColor(white: 0, alpha: 0.4)
        unShowNumBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}

// MARK: - Data Function
extension PictureThumbItemView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: PictureModel?) -> Void {
        guard let model = model else {
            return
        }
        self.imageView.backgroundColor = UIColor.white

        // 2. 图片标识
        self.loadIdentifyIcon(model: model)
        // 3. 未读数蒙层
        self.loadUnShowNum(model: model)
        // 1. 加载图片
        self.loadPicture(model: model)
    }
    /// 加载图片标识
    fileprivate func loadIdentifyIcon(model: PictureModel) -> Void {
        // 标识类型
        switch model.mimeType {
        case "image/gif":
            // gif动图标识 - 暂无
            self.identifyIcon.isHidden = false
        default:
            // 长图标识 - 暂无
            self.identifyIcon.isHidden = false
        }
        self.identifyIcon.isHidden = false

        // 长图标识，单独显示处理
        if model.originalSize.height > model.originalSize.width * 3.0 {
            self.longImgIdentifyIcon.isHidden = !model.showIconIdentify
        } else {
            self.longImgIdentifyIcon.isHidden = true
        }
    }
    /// 加载未读数
    fileprivate func loadUnShowNum(model: PictureModel) -> Void {
        self.unShowNumBtn.isHidden = model.unshowCount <= 0
        self.unShowNumBtn.setTitle("+\(model.unshowCount)", for: .normal)
    }

    /// 加载图片
    fileprivate func loadPicture(model: PictureModel) -> Void {
        // 1.如果有本地缓存，先加载缓存图片
        self.cacheImage = nil
        self.loadCachePicture(model: model)
        // 2.如果有网络链接，再加载网络图片（网络加载出的图片会覆盖缓存图片）
        guard let strUrl = model.strUrl else {
            return
        }
        let imageUrl: String = strUrl.thumbPicUrl(showSize: frame.size, originalSize: model.originalSize)
        downPicture(imageUrl: imageUrl, forceToRefresh: false)
    }

    /// 获取本地缓存图片
    internal func loadCachePicture(model: PictureModel) {
        guard let cache = model.cache else {
            return
        }
        self.imageView.image = UIImage(color: AppColor.disable)
        let pictureSize = CGSize(width: frame.width * 1.5, height: frame.height * 1.5)
        ImageCache.default.retrieveImage(forKey: cache, options: []) { (image, _) in
            let image = image?.kf.resize(to: pictureSize, for: .aspectFill)
            DispatchQueue.main.sync {
                self.imageView.image = image
                self.cacheImage = image
            }
        }
    }

    /// 下载图片
    internal func downPicture(imageUrl: String, forceToRefresh: Bool) {
        let url = URL(string: imageUrl)
        var options: KingfisherOptionsInfo = [.requestModifier(modifier)]
        if forceToRefresh {
            options.append(.forceRefresh)
        }
        var placeholderImage: UIImage
        if let cacheImage = cacheImage {
            placeholderImage = cacheImage
        } else {
            placeholderImage = UIImage.imageWithColor(AppColor.disable)
        }
        imageView.kf.setImage(with: url, placeholder: placeholderImage, options: options, progressBlock: nil, completionHandler: nil)
    }

}

// MARK: - Event Function

// MARK: - Extension Function

extension String {
    /// 小图链接
    func thumbPicUrl(showSize: CGSize, originalSize: CGSize) -> String {
        // 获取指定尺寸的图片链接时可能获取不成功，为了避免问题，直接使用原图
        return self

//        // 尺寸设置为 CGSize.zero，获取原图
//        if showSize == CGSize.zero {
//            let imageUrl = self
//            return imageUrl
//        }
//        assert(originalSize.width >= 0.0)
//        assert(originalSize.height >= 0.0)
//        let height = floor(showSize.width * UIScreen.main.scale)
//        let width = floor(showSize.height * UIScreen.main.scale)
//        /// 特别大的图片直接获取原图不要传递宽高参数，会导致无法显示
//        if height > 4_000 || width > 4_000 {
//            let imageUrl = self
//            return imageUrl
//        }
//        let imageUrl = self + "?w=\(height)&h=\(width)&q=\(50)"
//        return imageUrl
    }
}
