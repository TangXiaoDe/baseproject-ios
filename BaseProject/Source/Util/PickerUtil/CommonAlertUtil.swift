//
//  CommonAlertUtil.swift
//  BaseProject
//
//  Created by zhaowei on 2019/12/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import UIKit

class CommonAlertUtil: NSObject {
    static let commonMargin = 10
    static var handleBlock: ((_ buttonTitle: String) -> Void)?

    class func showCustomAlert(title: String, message: String, subMessage: String, leftTitle: String, rightTitle: String, leftTitleColor: UIColor? = nil, rightTitleColor: UIColor? = nil, handle: @escaping ((_ buttonTitle: String) -> Void)) {
        handleBlock = handle

        let lastView = AppUtil.currentWindow().viewWithTag(2009)
        if lastView != nil {
            lastView?.removeAllSubView()
            lastView?.removeFromSuperview()
        }
        let bgControl = UIControl()
        let mainView = UIView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        let subMessageLabel = UILabel()
        let leftBtn = UIButton.init(type: .custom)
        let rightBtn = UIButton.init(type: .custom)
        let bili: CGFloat = 160 / 540.0
        let mainViewWidth = kScreenWidth - kScreenWidth * bili
        let btnHeight = 40
        let titleCenterY: CGFloat = 40
        let messageCenterY: CGFloat = 36
        let subMessageTopMargin: CGFloat = 12
        let messageBottomMargin: CGFloat = 18

        bgControl.tag = 2009
        bgControl.frame = UIScreen.main.bounds
        bgControl.backgroundColor = UIColor.init(hex: 0x000000, alpha: 0.5)
//        bgControl.alpha = 0.4
        bgControl.addTarget(self, action: #selector(bgClick), for: .touchUpInside)
        AppUtil.currentWindow().addSubview(bgControl)

        /// mainView

        bgControl.addSubview(mainView)
        mainView.backgroundColor = UIColor.white
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        mainView.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(0)
            make.width.equalTo(mainViewWidth)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        /// subview
        mainView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = UIFont.pingFangSCFont(size: 18, weight: .bold)
        titleLabel.textColor = UIColor.init(hex: 0x202a46)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(mainView.snp.top).offset(titleCenterY)
            make.left.equalToSuperview().offset(commonMargin)
            make.right.equalToSuperview().offset(-commonMargin)
            make.centerX.equalToSuperview()
        }
        mainView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.pingFangSCFont(size: 14)
        messageLabel.textColor = UIColor.init(hex: 0x202a46)
        messageLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY).offset(messageCenterY)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(commonMargin)
            make.right.equalToSuperview().offset(-commonMargin)
        }
        mainView.addSubview(subMessageLabel)
        subMessageLabel.text = subMessage
        subMessageLabel.textAlignment = .center
        subMessageLabel.numberOfLines = 0
        subMessageLabel.font = UIFont.pingFangSCFont(size: 11)
        subMessageLabel.textColor = UIColor.init(hex: 0x999999)
        subMessageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(subMessageTopMargin)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(commonMargin)
            make.right.equalToSuperview().offset(-commonMargin)
        }
        mainView.addSubview(leftBtn)
        leftBtn.setTitle(leftTitle, for: .normal)
        leftBtn.setTitleColor(UIColor.init(hex: 0x5F656F), for: .normal)
        if let leftTitleColor = leftTitleColor {
            leftBtn.setTitleColor(leftTitleColor, for: .normal)
        }
        leftBtn.titleLabel?.font = UIFont.pingFangSCFont(size: 16)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        leftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(btnHeight)
            make.width.equalTo(mainViewWidth / 2)
            make.bottom.equalToSuperview()
        }
        leftBtn.addLineWithSide(.inTop, color: UIColor.init(hex: 0xECECEC), thickness: 0.5, margin1: 0, margin2: 0)
        leftBtn.addLineWithSide(.inRight, color: UIColor.init(hex: 0xECECEC), thickness: 0.5, margin1: 0, margin2: 0)

        mainView.addSubview(rightBtn)
        rightBtn.setTitle(rightTitle, for: .normal)
        rightBtn.setTitleColor(UIColor.init(hex: 0x29313D), for: .normal)
        if let rightTitleColor = rightTitleColor {
            rightBtn.setTitleColor(rightTitleColor, for: .normal)
        }
        rightBtn.titleLabel?.font = UIFont.pingFangSCFont(size: 16)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        rightBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(btnHeight)
            make.width.equalTo(mainViewWidth / 2)
        }
        rightBtn.addLineWithSide(.inTop, color: UIColor.init(hex: 0xECECEC), thickness: 0.5, margin1: 0, margin2: 0)
        
        if subMessage.isEmpty {
            subMessageLabel.snp.removeConstraints()
            subMessageLabel.isHidden = true
            leftBtn.snp.remakeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.height.equalTo(btnHeight)
                make.width.equalTo(mainViewWidth / 2)
                make.bottom.equalToSuperview()
                make.top.equalTo(messageLabel.snp.bottom).offset(messageBottomMargin)
            }
        } else {
            leftBtn.snp.remakeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.height.equalTo(btnHeight)
                make.width.equalTo(mainViewWidth / 2)
                make.bottom.equalToSuperview()
                make.top.equalTo(subMessageLabel.snp.bottom).offset(subMessageTopMargin)
            }
        }
    }

    class func hideAlertView() {
        let lastView = AppUtil.currentWindow().viewWithTag(2009)
        if lastView != nil {
            lastView?.removeAllSubView()
            lastView?.removeFromSuperview()
        }
    }

}

extension CommonAlertUtil {
    @objc class func leftBtnClick(_ btn: UIButton) {
        CommonAlertUtil.hideAlertView()
        handleBlock?(btn.currentTitle ?? "")
    }
    @objc class func rightBtnClick(_ btn: UIButton) {
        CommonAlertUtil.hideAlertView()
        handleBlock?(btn.currentTitle ?? "")
    }
    @objc class func bgClick() {
        CommonAlertUtil.hideAlertView()
    }
}
