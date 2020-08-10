//
//  CommonAvatarView.swift
//  BaseProject
//
//  Created by zhaowei on 2019/8/5.
//  Copyright © 2019 ChainOne. All rights reserved.
//
import UIKit

enum AvatarTagType: Int {
    // 无
    case none = 0
    //  官方
    case official = 1
    //  大咖
    case celebrity = 2
}

// 遇见首页顶部视图-新朋友入口
class CommonAvatarView: UIControl {

    // MARK: - Internal Property

    var viewHeight: CGFloat = 56
    /// 数据模型，新朋友数
    var image: UIImage? {
        didSet {
            self.setupImage(image)
        }
    }
    var userModel: SimpleUserModel? {
        didSet {
            self.setupWithUserModel(userModel)
        }
    }
    var customModel: (avatar: String?, sex: Int)? {
        didSet {
            self.setupWithCustomModel(customModel)
        }
    }
    var tagType: AvatarTagType = .none {
        didSet {
            self.setupWithTagType(tagType)
        }
    }

    //
    let avatarImgView: UIImageView = UIImageView()
    let tagImgView: UIImageView = UIImageView()

    // MARK: - Private Property

    fileprivate var tagWH: CGFloat = 18

    // MARK: - Initialize Function

    var clickBlock: ((_ view: CommonAvatarView) -> Void)?

    init(avatarWH: CGFloat) {
        self.viewHeight = avatarWH
        if self.viewHeight > 44 {
            self.tagWH = 18
        } else {
            self.tagWH = 12
        }
        super.init(frame: CGRect(x: 0, y: 0, width: self.viewHeight, height: self.viewHeight))
        self.commonInit()
    }

    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    /// 通用初始化：UI、配置、数据等
    fileprivate func commonInit() -> Void {
        self.initialUI()
    }
}

// MARK: - Internal Function
extension CommonAvatarView {
    /// 加载默认头像
    func loadDefaultIcon() -> Void {
        self.avatarImgView.image = AppImage.PlaceHolder.avatar
    }
}


// MARK: - Override Function

// MARK: - event
extension CommonAvatarView {
     @objc func avatarImgViewClick() {
        self.clickBlock?(self)
    }
}

// MARK: - Private  UI
extension CommonAvatarView {
    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.isUserInteractionEnabled = false
        self.addTarget(self, action: #selector(avatarImgViewClick), for: .touchUpInside)
        // 1. avatarImgView
        self.addSubview(self.avatarImgView)
        self.avatarImgView.layer.masksToBounds = true
        self.avatarImgView.layer.cornerRadius = viewHeight / 2.0
        self.avatarImgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. tagImgView
        self.addSubview(self.tagImgView)
        self.tagImgView.snp.makeConstraints { (make) in
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.centerX.equalTo(viewHeight * 0.85)
            make.centerY.equalTo(viewHeight * 0.85)
            make.size.equalTo(CGSize.init(width: tagWH, height: tagWH))
        }
    }

}

// MARK: - Private  数据(处理 与 加载)
extension CommonAvatarView {
    fileprivate func setupImage(_ image: UIImage?) -> Void {
        guard let image = image else {
            return
        }
        self.avatarImgView.image = image
    }
    fileprivate func setupWithUserModel(_ userModel: SimpleUserModel?) -> Void {
        guard let userModel = userModel else {
            return
        }
        self.avatarImgView.kf.setImage(with: userModel.avatarUrl, placeholder: AppImage.placeHolder(for: userModel))
//        if userModel.bigNameStatus == .big {
//            self.tagImgView.image = UIImage.init(named: "IMG_icon_vip_max")
//        } else {
//            self.tagImgView.image = nil
//        }
    }
    fileprivate func setupWithCustomModel(_ customModel: (avatar: String?, sex: Int)?) -> Void {
        guard let customModel = customModel else {
            return
        }
        self.avatarImgView.kf.setImage(with: UrlManager.fileUrl(name: customModel.avatar), placeholder: AppImage.placeHolder(for: UserSex.init(rawValue: customModel.sex)))
    }

    /// 设置右下角图标
    func setupWithTagType(_ tagType: AvatarTagType) -> Void {
        switch tagType {
        case .none:
            self.tagImgView.image = nil
        case .official:
            if self.viewHeight > 44 {
                self.tagImgView.image = UIImage.init(named: "IMG_icon_official_max")
            } else {
                self.tagImgView.image = UIImage.init(named: "IMG_icon_official_mini")
            }
        case .celebrity:
            if self.viewHeight > 44 {
                self.tagImgView.image = UIImage.init(named: "IMG_icon_vip_max")
            } else {
                self.tagImgView.image = UIImage.init(named: "IMG_icon_vip_mini")
            }

        }
    }
    /// 设置边框和颜色
    func set(borderWidth: CGFloat, borderColor: UIColor) {
        self.avatarImgView.layer.masksToBounds = true
        self.avatarImgView.layer.cornerRadius = viewHeight / 2.0
        self.avatarImgView.layer.borderWidth = borderWidth
        self.avatarImgView.layer.borderColor = borderColor.cgColor
    }
}
