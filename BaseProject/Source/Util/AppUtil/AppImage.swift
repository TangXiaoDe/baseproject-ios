//
//  BaseProjectImage.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  链优品图片工具集

import Foundation
import UIKit

class AppImage: UIImage {

    struct PlaceHolder {
        static let colorIcon: UIImage = kPlaceHolderImage
        static let logo: UIImage = kPlaceHolderLogo
        static let avatar: UIImage = kPlaceHolderAvatar
        static let product: UIImage = kPlaceHolderProduct
        static let image: UIImage = kPlaceHolderImage

        static let user_secrecy: UIImage = kPlaceHolderUserSecrecyAvatar
        static let user_man: UIImage = kPlaceHolderUserManAvatar
        static let user_woman: UIImage = kPlaceHolderUserWomanAvatar
    }

    /// 获取用户占位头像
    /// 若用户可能为nil，则使用这种方式；若用户不为nil，则直接使用user.sex.placeholder
     static func placeHolder(for user: SimpleUserModel?) -> UIImage? {
        var placeholder: UIImage? = UserSex.unknown.placeholder
        guard let user = user else {
            return placeholder
        }
        placeholder = user.sex.placeholder
        return placeholder
    }
     static func placeHolder(for userSex: UserSex?) -> UIImage? {
        var placeholder: UIImage? = UserSex.unknown.placeholder
        guard let sex = userSex else {
            return placeholder
        }
        placeholder = sex.placeholder
        return placeholder
    }

    @objc public static func getAvatarPlaceHolder(sex: Int) -> UIImage? {
        return  self.placeHolder(for: UserSex(rawValue: sex))
    }

    @objc public static func getCardPlaceHolder() -> UIImage? {
        return UserSex.unknown.placeholder
    }

    @objc public static func getNoticePlaceHolder() -> UIImage {
        return PlaceHolder.image
    }

}
