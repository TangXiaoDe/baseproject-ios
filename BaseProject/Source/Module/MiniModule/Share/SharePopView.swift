//
//  SharePopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/26.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  通用分享弹窗

import UIKit
import MonkeyKing

enum ShareType {
    case image
    case url
}

class SharePopView: UIView {

    // MARK: - Internal Property

    /// 需要分享成功后进行任务统计
    var needShareTaskCount: Bool = true

    fileprivate var shareImage: UIImage? = nil
    fileprivate var shareUrl: String
    fileprivate var shareTitle: String? = nil
    fileprivate var shareDesc: String? = nil

    fileprivate let shareType: ShareType

    // MARK: - Private Property

    fileprivate let mainView: UIView = UIView()
    fileprivate let coverView: UIButton = UIButton(type: .custom)
    fileprivate let itemContainer: UIView = UIView()
    fileprivate let cancelBtn: UIButton = UIButton(type: .custom)

    fileprivate let kItemTagBase: Int = 250

    fileprivate let cancelBtnH: CGFloat = 50
    fileprivate let cancelBtnTopMargin: CGFloat = 10
    fileprivate let itemContainerH: CGFloat = 100

    // MARK: - Initialize Function
    // 注 shareType对应的类型则该类型参数必传，否则分享失败
    init(shareType: ShareType, shareImage: UIImage? = nil, shareUrl: String, copyLink: String? = nil, shareTitle: String? = nil, shareDesc: String? = nil) {
        self.shareType = shareType
        self.shareImage = shareImage
        self.shareUrl = shareUrl
        self.shareTitle = shareTitle
        self.shareDesc = shareDesc
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        //self.initialUI()
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension SharePopView {
    /// 显示在window上
    func show(on view: UIView? = nil) -> Void {
        var superView: UIView? = UIApplication.shared.keyWindow
        if let view = view {
            superView = view
        }
        if let superView = superView {
            superView.addSubview(self)
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    /// 消失
    func dismiss() -> Void {
        self.removeFromSuperview()
    }
}

// MARK: - LifeCircle Function

// MARK: - Private  UI
extension SharePopView {
    // 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. coverView
        mainView.addSubview(coverView)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        coverView.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        coverView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 3. cancelBtn
        mainView.addSubview(self.cancelBtn)
        self.cancelBtn.addTarget(self, action: #selector(cancelBtnClick(_:)), for: .touchUpInside)
        self.cancelBtn.set(title: "取消", titleColor: UIColor(hex: 0x333333), image: nil, bgImage: UIImage.imageWithColor(UIColor.white), for: .normal)
        self.cancelBtn.set(font: UIFont.systemFont(ofSize: 15))
        self.cancelBtn.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(mainView.snp_bottomMargin)
            make.height.equalTo(self.cancelBtnH)
        }
        // 4. itemContainer
        mainView.addSubview(self.itemContainer)
        self.initialItemContainer(self.itemContainer)
        self.itemContainer.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.itemContainerH)
            make.bottom.equalTo(self.cancelBtn.snp.top).offset(-cancelBtnTopMargin)
        }

    }
    fileprivate func initialItemContainer(_ itemContainer: UIView) -> Void {
        itemContainer.backgroundColor = UIColor.white
        itemContainer.set(cornerRadius: 0)
        // item布局
        let items: [(iconName: String, title: String)] = [
            (iconName: "IMG_share_icon_wechat", title: "微信"),
            (iconName: "IMG_share_icon_circle", title: "朋友圈"),
//            (iconName: "IMG_share_link", title: "复制链接"),
//            (iconName: "IMG_share_save", title: "保存图片")
        ]
        let lrMargin: CGFloat = 15
        let itemMaxW: CGFloat = CGFloat(Int((kScreenWidth - lrMargin * 2.0) / CGFloat(items.count)))
        for (index, item) in items.enumerated() {
            let itemControl: UIControl = UIControl()
            itemContainer.addSubview(itemControl)
            itemControl.tag = self.kItemTagBase + index
            itemControl.addTarget(self, action: #selector(itemControlClick(_:)), for: .touchUpInside)
            self.setupItemControl(itemControl, with: item)
            itemControl.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(20)
                let centerXoffset: CGFloat = lrMargin + CGFloat(Int((CGFloat(index) + 0.5) * itemMaxW))
                make.centerX.equalTo(itemContainer.snp.leading).offset(centerXoffset)
            }
        }

    }
    /// itemControl布局
    fileprivate func setupItemControl(_ itemControl: UIControl, with item: (iconName: String, title: String)) -> Void {
        let topMargin: CGFloat = 0
        let bottomMargin: CGFloat = 0
        let iconWH: CGFloat = 36
        let nameIconMargin: CGFloat = 10
        // iconView
        let iconView: UIImageView = UIImageView()
        itemControl.addSubview(iconView)
        iconView.set(cornerRadius: iconWH * 0.5)
        iconView.isUserInteractionEnabled = false
        iconView.image = UIImage(named: item.iconName)
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(iconWH)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(0)
            make.trailing.lessThanOrEqualToSuperview().offset(-0)
            make.top.equalToSuperview().offset(topMargin)
        }
        // titleLabel
        let titleLabel: UILabel = UILabel()
        itemControl.addSubview(titleLabel)
        titleLabel.set(text: item.title, font: UIFont.systemFont(ofSize: 12), textColor: UIColor(hex: 0x999999), alignment: .center)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(0)
            make.trailing.lessThanOrEqualToSuperview().offset(-0)
            make.top.equalTo(iconView.snp.bottom).offset(nameIconMargin)
            make.bottom.equalToSuperview().offset(-bottomMargin)
        }
    }

}

// MARK: - Data Function
extension SharePopView {

}

// MARK: - Event Function
extension SharePopView {
    /// 背景遮罩点击
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {
        self.dismiss()
    }
    /// 取消按钮点击 - 消失
    @objc fileprivate func cancelBtnClick(_ button: UIButton) -> Void {
        self.dismiss()
    }
    ///
    @objc fileprivate func itemControlClick(_ control: UIControl) -> Void {
        let index: Int = control.tag - self.kItemTagBase
        switch index {
        case 0:
            // 分享到微信
            self.shareToWechatFriend()
        case 1:
            // 分享到朋友圈
            self.shareToWechatCircle()
//        case 2:
//            // 复制链接
//            self.copyLink()
//        case 3:
//            // 保存图片
//            self.saveImageToPhotoLibrary()
        default:
            break
        }

    }
}

// MARK: - Extension Function

extension SharePopView {
    /// 分享到微信
    fileprivate func shareToWechatFriend() -> Void {
        if !ShareManager.thirdAccout(type: .wechat).isAppInstalled {
            Toast.showToast(title: "未安装微信或微信版本过低")
            return
        }
        self.shareToWeChatFriend(URLString: self.shareUrl, image: self.shareImage, description: self.shareDesc, title: self.shareTitle, complete: { result in
            if result == true {
                Toast.showToast(title: "分享成功")
                if self.needShareTaskCount {
//                    // 分享成功的回调
//                    TaskNetworkManager.shareSuccessCallBack(complete: { (status, msg) in
//                    })
                }
            } else {
                Toast.showToast(title: "分享失败")
            }
        })
    }
    /// 分享到微信-MonkeyKing操作
    fileprivate func shareToWeChatFriend(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        var media: MonkeyKing.Media
        switch self.shareType {
        case .image:
            guard let image = image else {
                return
            }
            media = MonkeyKing.Media.image(image)
        case .url:
            guard let strUrl = URLString, let url = URL.init(string: strUrl) else {
                return
            }
            media = MonkeyKing.Media.url(url)
        }
        let info = MonkeyKing.Info(
            title: title,
            description: description,
            thumbnail: image,
            media: media
        )
        MonkeyKing.deliver(MonkeyKing.Message.weChat(.session(info: info))) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("wechat result: \(result)")
        }
    }

}
extension SharePopView {
    /// 分享到朋友圈
    fileprivate func shareToWechatCircle() -> Void {
        if !ShareManager.thirdAccout(type: .wechat).isAppInstalled {
            Toast.showToast(title: "未安装微信或微信版本过低")
            return
        }
        self.shareToWeChatCircle(URLString: self.shareUrl, image: self.shareImage, description: self.shareDesc, title: self.shareTitle, complete: { result in
            if result == true {
                Toast.showToast(title: "分享成功")
                if self.needShareTaskCount {
//                    // 分享成功的回调
//                    TaskNetworkManager.shareSuccessCallBack(complete: { (status, msg) in
//                    })
                }
            } else {
                Toast.showToast(title: "分享失败")
            }
        })
    }
    /// 分享到朋友圈
    fileprivate func shareToWeChatCircle(URLString: String?, image: UIImage?, description: String?, title: String?, complete: @escaping(_ result: Bool) -> Void) {
        var media: MonkeyKing.Media
        switch self.shareType {
        case .image:
            guard let image = image else {
                return
            }
            media = MonkeyKing.Media.image(image)
        case .url:
            guard let strUrl = URLString, let url = URL.init(string: strUrl) else {
                return
            }
            media = MonkeyKing.Media.url(url)
        }
        let info = MonkeyKing.Info(
            title: title,
            description: description,
            thumbnail: image,
            media: media
        )
        MonkeyKing.deliver(MonkeyKing.Message.weChat(.timeline(info: info))) { result in
            let bool: Bool
            switch result {
            case .success(_):
                bool = true
            case .failure(_):
                bool = false
            }
            complete(bool)
            print("moment result: \(result)")
        }
    }

}

extension SharePopView {
//    /// 复制链接
//    fileprivate func copyLink() -> Void {
//        let paste = UIPasteboard.general
//        paste.string = "福利大放送！！！\n加入TBMALL商城\n购物即挖矿 持币享分红\n福利专享地址\n\(self.url)\n别忘记下载APP,注册哦"
//        Toast.showToast(title: "链接已复制到粘贴板")
//    }
//    /// 复制邀请码
//    fileprivate func copyInviteCode() -> Void {
//        let paste = UIPasteboard.general
//        paste.string = self.inviteCode
//        Toast.showToast(title: "邀请码已复制到粘贴板")
//    }

}

extension SharePopView {
//    // 保存图片
//    fileprivate func saveImageToPhotoLibrary() {
//        guard let image = self.shareImage else {
//            return
//        }
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
//    }
//
//    /// 保存图片到本地回调
//    @objc fileprivate func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
//        if let e = error as NSError? {
//            print(e)
//        } else {
//            Toast.showToast(title: "图片已经保存到相册")
//        }
//    }
}
