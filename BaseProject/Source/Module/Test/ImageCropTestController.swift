//
//  ImageCropTestController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/10.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  图片裁剪测试界面

import UIKit

class ImageCropTestController: BaseViewController {

    let image: UIImage


    let scrollView: UIScrollView = UIScrollView()
    let imageContainer: UIView = UIView()
    let imageView: UIImageView = UIImageView()

    let cropView: UIView = UIView()

    let cropSize: CGSize = CGSize.init(width: 200, height: 200)


    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // scrollView
        self.view.addSubview(self.scrollView)
        self.scrollView.frame = CGRect.init(x: 0, y: kStatusBarHeight, width: kScreenWidth, height: kScreenHeight - kStatusBarHeight)
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 3

        // imageContainer
        self.scrollView.addSubview(self.imageContainer)

        // imageView
        self.imageContainer.addSubview(self.imageView)
        self.imageView.set(cornerRadius: 0)
        self.imageView.image = image
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.view.addSubview(self.cropView)
        self.cropView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.view.bringSubviewToFront(self.cropView)
        self.cropView.snp.makeConstraints { (make) in
            make.size.equalTo(self.cropSize)
            //make.center.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.view.snp.top).offset(kStatusBarHeight + (kScreenHeight - kStatusBarHeight) * 0.5)
        }

        let scrollFrameW: CGFloat = kScreenWidth
        let scrollFrameH: CGFloat = kScreenHeight - kStatusBarHeight
        let imageW: CGFloat = image.size.width
        let imageH: CGFloat = image.size.height
        let cropW: CGFloat = cropSize.width
        let cropH: CGFloat = cropSize.height

        // 根据image来确定范围
        if image.size.height / image.size.width > cropSize.height / cropSize.width {
            // 以裁剪宽为准

            let containerH: CGFloat = cropW * imageH / imageW
            let containerW: CGFloat = cropW
            let contentH: CGFloat = scrollFrameH + containerH - cropH
            self.imageContainer.bounds = CGRect.init(x: 0, y: 0, width: containerW, height: containerH)
            self.imageContainer.center = CGPoint.init(x: scrollFrameW * 0.5, y: contentH * 0.5)
            self.scrollView.contentSize = CGSize.init(width: scrollFrameW, height: contentH)
        } else {
            // 以裁剪高为准
            let containerH: CGFloat = cropH
            let containerW: CGFloat = cropH * imageW / imageH
            let contentW: CGFloat = scrollFrameW + containerW - cropW
            self.imageContainer.bounds = CGRect.init(x: 0, y: 0, width: containerW, height: containerH)
            self.imageContainer.center = CGPoint.init(x: contentW * 0.5, y: scrollFrameH * 0.5)
            self.scrollView.contentSize = CGSize.init(width: contentW, height: scrollFrameH)
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }


}

extension ImageCropTestController: UIScrollViewDelegate {

    // return a view that will be scaled. if delegate returns nil, nothing happens
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageContainer
    }

    // called before the scroll view begins zooming its content
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.contentInset = UIEdgeInsets.zero
    }

    // any zoom scale changes
    func scrollViewDidZoom(_ scrollView: UIScrollView) {

//        NSLog(@"scrollBounds: %@, scrollContentSize: %@", NSStringFromCGRect(scrollView.frame), NSStringFromCGSize(scrollView.contentSize));
        // imageContainer.size = scrollView.contentSize
        print("ImageCropTestController scrollViewDidZoom scrollView \(scrollView.frame) \(scrollView.contentSize)")
        print("ImageCropTestController scrollViewDidZoom imageView \(imageContainer.frame)")
        scrollView.contentInset = UIEdgeInsets.zero



//        let scrollFrameW: CGFloat = kScreenWidth
//        let scrollFrameH: CGFloat = kScreenHeight - kStatusBarHeight
//        let imageW: CGFloat = image.size.width
//        let imageH: CGFloat = image.size.height
//        let cropW: CGFloat = cropSize.width
//        let cropH: CGFloat = cropSize.height
//
//        // 根据image来确定范围
//        if image.size.height / image.size.width > cropSize.height / cropSize.width {
//            // 以裁剪宽为准
//
//            let containerH: CGFloat = cropW * imageH / imageW
//            let containerW: CGFloat = cropW
//            let contentH: CGFloat = scrollFrameH + containerH - cropH
//            self.imageContainer.bounds = CGRect.init(x: 0, y: 0, width: containerW, height: containerH)
//            self.imageContainer.center = CGPoint.init(x: scrollFrameW * 0.5, y: contentH * 0.5)
//            self.scrollView.contentSize = CGSize.init(width: scrollFrameW, height: contentH)
//        } else {
//            // 以裁剪高为准
//            let containerH: CGFloat = cropH
//            let containerW: CGFloat = cropH * imageW / imageH
//            let contentW: CGFloat = scrollFrameW + containerW - cropW
//            self.imageContainer.bounds = CGRect.init(x: 0, y: 0, width: containerW, height: containerH)
//            self.imageContainer.center = CGPoint.init(x: contentW * 0.5, y: scrollFrameH * 0.5)
//            self.scrollView.contentSize = CGSize.init(width: contentW, height: scrollFrameH)
//        }

    }

    // scale between minimum and maximum. called after any 'bounce' animations
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {

    }

}
