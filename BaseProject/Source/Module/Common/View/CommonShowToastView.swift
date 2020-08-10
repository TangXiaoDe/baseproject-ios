//
//  CommonShowToastView.swift
//  BaseProject
//
//  Created by zhaowei on 2019/7/18.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import UIKit

/// 设置矿石数
class CommonShowToastView: UIView {
    let bgView = UIView()
    let mainView = UIView()
    let titleLabel = UILabel()
    let imageView = UIImageView()

    let imageTopMargin: CGFloat = 33
    let imageLrMargin: CGFloat = 26
    let titleTopMargin: CGFloat = 15

    var viewSize = CGSize.zero
    var title = ""
    var imageName = ""


    init() {
        super.init(frame: CGRect.zero)
    }
    required override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func showToast(size: CGSize = CGSize.init(width: 160, height: 160), title: String, imageName: String = "IMG_login_completeinfo", duration: Double = 2) -> Void {
        self.viewSize = size
        self.title = title
        self.imageName = imageName
        self.layer.masksToBounds = true
        self.initialUI()
        UIApplication.shared.keyWindow?.addSubview(self)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.removeFromSuperview()
        }
    }
    func hideItem() {
        self.removeFromSuperview()
    }
    func initialUI() {
        self.frame = UIScreen.main.bounds
        self.bgView.backgroundColor = UIColor.init(hex: 0x000000, alpha: 0.3)
        self.bgView.frame = self.frame
        self.addSubview(self.bgView)
        self.bgView.isUserInteractionEnabled = true
        self.bgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapBg(_:))))

        self.addSubview(self.mainView)
        self.mainView.backgroundColor = UIColor.white
        self.mainView.alpha = 0.9
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 10
        self.mainView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(0)
            make.size.equalTo(self.viewSize)
        }
        self.initalMainView()
    }

    func initalMainView() {
        // 0.titleLabel
        self.mainView.addSubview(self.imageView)
        self.imageView.image = UIImage.init(named: imageName)
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(imageTopMargin)
            make.left.equalToSuperview().offset(imageLrMargin)
            make.right.equalToSuperview().offset(-imageLrMargin)
        }
        // 1.titleLabel
        self.mainView.addSubview(self.titleLabel)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.set(text: self.title, font: UIFont.pingFangSCFont(size: 16, weight: .regular), textColor: UIColor.init(hex: 0x202A46))
        self.titleLabel.textAlignment = .center
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(titleTopMargin)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

    }
}

// MARK: - Extension
extension CommonShowToastView {

}

// MARK: - event
extension CommonShowToastView {

    @objc func tapBg(_ tapGR: UITapGestureRecognizer) {
        self.hideItem()
    }

}
