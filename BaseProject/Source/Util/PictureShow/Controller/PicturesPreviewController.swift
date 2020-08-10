//
//  PicturesPreviewController.swift
//  ThinkSNSPlus
//
//  Created by 小唐 on 28/06/2018.
//  Copyright © 2018 ZhiYiCX. All rights reserved.
//
//  图片预览界面

import UIKit
import Photos

class PicturesPreviewController: UIViewController {
    // MARK: - Internal Property

    /// 判断是否有图片查看器正在显示
    static var isShowing: Bool = false

    /// 数据源列表
    var imageModels: [PictureModel] = []
    /// 缩略图位置列表(九宫格图位置)
    var thumbImageFrames: [CGRect] = []
    /// 缩略图列表
    var thumbImages: [UIImage?] = []

    // MARK: - Private Property

    /// 当前页数
    fileprivate var currentPage: Int = 0

    /// 动画 ImageView
    fileprivate let animationImageView = UIImageView()
    /// item的tag基值
    fileprivate let kItemTagBase: Int = 200

    /// scroll view
    fileprivate let scrollView = UIScrollView()
    /// 分页控制器
    fileprivate let pageControl = UIPageControl()

    fileprivate let kAnimationDuration: TimeInterval = 0.25

    // MARK: - Initialize Function

    init(imageModels: [PictureModel], thumbImages: [UIImage?], thumbImageFrames: [CGRect], index: Int) {
        self.imageModels = imageModels
        self.thumbImages = thumbImages
        self.thumbImageFrames = thumbImageFrames
        self.currentPage = index
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

// MARK: - Internal Function

extension PicturesPreviewController {
    /// 显示
    func show() -> Void {
        self.animationShow()
    }
    /// 消失
    func dismiss() -> Void {
        self.animationDismiss()
    }
}

// MARK: - LifeCircle Function
extension PicturesPreviewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}

// MARK: - UI
extension PicturesPreviewController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.black

        // 1. scrollView
        self.view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        // 2. pageControl
        self.view.addSubview(pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(6)
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.view).offset(kStatusBarHeight + 20)
        }
        // 3. animationImageView
        self.animationImageView.contentMode = .scaleAspectFill
        self.animationImageView.backgroundColor = AppColor.imgBg
    }
}

// MARK: - Data(数据处理与加载)
extension PicturesPreviewController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        // 限制图片显示的数量
        let imageCount = min(imageModels.count, 9)
        // scrollView
        for index in 0..<imageCount {
            let imageModel = self.imageModels[index]
            let itemView = PicturePreviewItemView()
            self.scrollView.addSubview(itemView)
            itemView.tag = self.kItemTagBase + index
            itemView.delegate = self
            itemView.loadModel(imageModel, thumbImage: self.thumbImages[index])
            itemView.snp.makeConstraints({ (make) in
                make.size.equalTo(CGSize.init(width: kScreenWidth, height: kScreenHeight))
                make.top.bottom.equalTo(self.scrollView)
                make.leading.equalTo(self.scrollView).offset(kScreenWidth * CGFloat(index))
                if index == imageCount - 1 {
                    make.trailing.equalTo(self.scrollView)
                }
            })
        }
        scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(imageCount), height: kScreenHeight)
        scrollView.contentOffset = CGPoint(x: kScreenWidth * CGFloat(self.currentPage), y: 0)
        // pageControl
        pageControl.numberOfPages = imageCount
        pageControl.currentPage = self.currentPage
    }
}

// MARK: - Event(事件响应)
extension PicturesPreviewController {

}

// MARK: - Notification
extension PicturesPreviewController {

}

// MARK: - Extension Function
extension PicturesPreviewController {

    /// 获取图片查看器的图片位置
    fileprivate func getPicturePreviewItem(at index: Int) -> PicturePreviewItemView? {
        let item = self.scrollView.viewWithTag(self.kItemTagBase + index) as? PicturePreviewItemView
        return item
    }

    /// 设置显示的动画视图
    fileprivate func setShowAnimationUX() {
        self.view.backgroundColor = UIColor.clear

        self.view.addSubview(self.animationImageView)
        self.animationImageView.image = self.thumbImages[currentPage]
        self.animationImageView.frame = self.thumbImageFrames[currentPage]
    }

    /// 设置消失时的动画视图
    fileprivate func setDismissAnimationUX() -> Void {
        self.view.backgroundColor = UIColor.black

        self.view.addSubview(self.animationImageView)
        if let item = self.getPicturePreviewItem(at: self.currentPage) {
            self.animationImageView.image = item.imageView.image
            self.animationImageView.frame = item.imageViewFrame
        }
    }

    /// 动画显示
    fileprivate func animationShow() -> Void {
        if PicturesPreviewController.isShowing {
            return
        }
        PicturesPreviewController.isShowing = true

        //        UIApplication.shared.keyWindow?.rootViewController?.addChild(self)
        //        UIApplication.shared.keyWindow?.addSubview(self.view)
        if let presentVC = RootManager.share.showRootVC.presentedViewController {
            presentVC.addChild(self)
            presentVC.view.addSubview(self.view)
        } else {
            RootManager.share.showRootVC.addChild(self)
            RootManager.share.showRootVC.view.addSubview(self.view)
        }

        self.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.setShowAnimationUX()
        self.scrollView.isHidden = true
        self.pageControl.isHidden = true
        UIView.animate(withDuration: self.kAnimationDuration, animations: {
            self.animationImageView.frame = PicturePreviewItemView.imageViewFrameWith(model: self.imageModels[self.currentPage])
            self.view.backgroundColor = UIColor.black
        }) { (_) in
            self.scrollView.isHidden = false
            self.pageControl.isHidden = false
            self.animationImageView.removeFromSuperview()
        }

    }

    /// 动画消失
    fileprivate func animationDismiss() -> Void {
        PicturesPreviewController.isShowing = false

        self.setDismissAnimationUX()

        self.scrollView.isHidden = true
        self.pageControl.isHidden = true
        UIView.animate(withDuration: self.kAnimationDuration, animations: {
            self.animationImageView.frame = self.thumbImageFrames[self.currentPage]
            self.animationImageView.alpha = 0.3
            self.view.backgroundColor = UIColor.clear
        }) { (_) in
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }

}

// MARK: - Delegate Function

// MARK: - <UIScrollViewDelegate>
extension PicturesPreviewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        currentPage = Int(round(offset.x / self.view.bounds.width))
        pageControl.currentPage = currentPage

//        let preview = scrollow.viewWithTag(currentPage + tagForScrollowItem) as? TSPicturePreviewItem
//        let value = offset.x / self.view.bounds.width - CGFloat((preview!.tag - tagForScrollowItem))
//        if value != 0 {
//            UIView.animate(withDuration: 0.2, animations: {
//                preview?.progressButton?.alpha = 0
//            })
//        } else {
//            UIView.animate(withDuration: 0.2, animations: {
//                preview?.progressButton?.alpha = 1
//            })
//        }
    }
}

// MARK: - <PicturePreviewItemViewProtocol>
extension PicturesPreviewController: PicturePreviewItemViewProtocol {
    /// 被点击回调
    func didClickedItemView(_ itemView: PicturePreviewItemView) -> Void {
        self.dismiss()
    }
    /// 长按回调
    func didLongPressedItemView(_ itemView: PicturePreviewItemView) -> Void {
        // 判断图中是否有二维码
        let hasQrCode: Bool = QRCodeUtil.haveQRCode(in: itemView.imageView.image)
        // 弹窗
        let alertVC: UIAlertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "保存图片", style: UIAlertAction.Style.default, handler: { (action) in
            self.saveImageProcess(in: itemView)
        }))
        if hasQrCode, let image = itemView.imageView.image {
            let qrcodeAction = UIAlertAction.init(title: "识别图中的二维码", style: .default) { (action) in
                self.scanQrCodeProcess(in: image)
            }
            alertVC.addAction(qrcodeAction)
        }
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alertVC, animated: false, completion: nil)
    }

    func itemView(_ itemView: PicturePreviewItemView, didSaveImageWithError error: Error?) {
        if let _ = error {
            Toast.showToast(title: "保存失败")
        } else {
            Toast.showToast(title: "保存成功")
        }
    }

}

extension PicturesPreviewController {

    /// 保存图片
    fileprivate func saveImageProcess(in itemView: PicturePreviewItemView) -> Void {
        // 检查写入相册的授权
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        if photoStatus == .authorized {
            itemView.saveImage()
            return
        }
        if photoStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ [weak self] (newState) in
                guard newState == .authorized else {
                    return
                }
                itemView.saveImage()
            })
            return
        }

        if photoStatus == .denied || photoStatus == .restricted {
            let appName = AppConfig.share.appName
            let alertVC = UIAlertController.init(title: "相册权限设置", message: "请为\(appName)开放相册权限：手机设置-隐私-照片-\(appName)(打开)", preferredStyle: .alert)
            let setAction = UIAlertAction.init(title: "去设置", style: .default) { (action) in
                if let url = URL.init(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.openURL(url)
                }
            }
            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alertVC.addAction(setAction)
            alertVC.addAction(cancelAction)
            RootManager.share.rootVC.present(alertVC, animated: true, completion: nil)
        }
    }

    /// 识别图中的二维码并作相关处理
    func scanQrCodeProcess(in image: UIImage) -> Void {
        guard let result = QRCodeUtil.scanQRCode(image: image) else {
            Toast.showToast(title: "图片中无二维码")
            return
        }
        self.animationDismiss()
        // 消失动画完成后再通知处理跳转到结果页
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.kAnimationDuration) {
            NotificationCenter.default.post(name: NSNotification.Name.PictureLongPressQRCode, object: result, userInfo: nil)
        }
    }

}

/***

class TSPicturePreviewVC: TSViewController, UIScrollViewDelegate, TSPicturePreviewItemDelegate, TSCustomAcionSheetDelegate {
    

 
    
 
    /// 完成了保存图片
    func item(_ item: TSPicturePreviewItem, didSaveImage error: Error?) {
        let indicator = TSIndicatorWindowTop(state: error == nil ? .success : .faild, title: error == nil ? "提示信息_图片保存成功".localized : "提示信息_图片保存失败".localized)
        indicator.show(timeInterval: TSIndicatorWindowTop.defaultShowTimeInterval)
    }
    
    /// 购买了某张图片
    func itemFinishPaid(_ item: TSPicturePreviewItem) {
        paidBlock?(currentPage)
    }
    
    /// 代理直接执行保存图片
    func itemSaveImage(item: TSPicturePreviewItem) {
        self.saveImage()
    }
    
    /// 执行保存图片
    func saveImage() {
        // 检查写入相册的授权
        let photoStatus = PHPhotoLibrary.authorizationStatus()
        if photoStatus == .authorized {
            toSaveImage()
            return
        }
        if photoStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ [weak self] (newState) in
                guard newState == .authorized else {
                    return
                }
                self?.toSaveImage()
            })
            return
        }
        
        if photoStatus == .denied || photoStatus == .restricted {
            let appName = TSAppConfig.share.localInfo.appDisplayName
            TSErrorTipActionsheetView().setWith(title: "相册权限设置", TitleContent: "请为\(appName)开放相册权限：手机设置-隐私-相册-\(appName)(打开)", doneButtonTitle: ["去设置", "取消"], complete: { (_) in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.openURL(url!)
                }
            })
        }
    }
    
    // MARK: TSCustomAcionSheetDelegate
    /// 点击 "保存图片"
    func returnSelectTitle(view: TSCustomActionsheetView, title: String, index: Int) {
        if index == 0 {
            self.saveImage()
        }
    }
    
    func toSaveImage() {
        if let item = scrollow.viewWithTag(tagForScrollowItem + currentPage) as? TSPicturePreviewItem {
            item.saveImage()
        }
    }

}


**/
