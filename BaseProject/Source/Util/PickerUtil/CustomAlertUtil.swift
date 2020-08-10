//
//  CustomAlertUtil.swift
//  BaseProject
//
//  Created by zhaowei on 2019/8/1.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import Foundation
import UIKit

class CustomAlertUtil: NSObject {
    static let commonMargin = 10
    static var handleBlock: ((_ buttonTitle: String) -> Void)?

    class func showCustomAlert(title: String, message: String, subMessage: String, leftTitle: String, rightTitle: String, handle: @escaping ((_ buttonTitle: String) -> Void)) {
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
        let mainViewHeight = 160
        let btnHeight = 40

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
            make.height.equalTo(mainViewHeight)
            make.width.equalTo(mainViewWidth)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        /// subview
        mainView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = UIFont.pingFangSCFont(size: 16)
        titleLabel.textColor = UIColor.init(hex: 0x29313D)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(commonMargin)
            make.left.equalToSuperview().offset(commonMargin)
            make.right.equalToSuperview().offset(-commonMargin)
            make.centerX.equalToSuperview()
        }
        mainView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.pingFangSCFont(size: 14)
        messageLabel.textColor = UIColor.init(hex: 0x29313D)
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(commonMargin * 2)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(commonMargin)
            make.right.equalToSuperview().offset(-commonMargin)
        }
        mainView.addSubview(subMessageLabel)
        subMessageLabel.text = subMessage
        subMessageLabel.textAlignment = .center
        subMessageLabel.font = UIFont.pingFangSCFont(size: 11)
        subMessageLabel.textColor = UIColor.init(hex: 0x999999)
        subMessageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(commonMargin)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(commonMargin)
            make.right.equalToSuperview().offset(-commonMargin)
        }
        mainView.addSubview(leftBtn)
        leftBtn.setTitle(leftTitle, for: .normal)
        leftBtn.setTitleColor(UIColor.init(hex: 0x5F656F), for: .normal)
        leftBtn.titleLabel?.font = UIFont.pingFangSCFont(size: 16)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        leftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(btnHeight)
            make.width.equalTo(mainViewWidth / 2)
        }
        leftBtn.addLineWithSide(.inTop, color: UIColor.init(hex: 0xE2E2E2), thickness: 0.5, margin1: 0, margin2: 0)
        leftBtn.addLineWithSide(.inRight, color: UIColor.init(hex: 0xE2E2E2), thickness: 0.5, margin1: 0, margin2: 0)

        mainView.addSubview(rightBtn)
        rightBtn.setTitle(rightTitle, for: .normal)
        rightBtn.setTitleColor(UIColor.init(hex: 0x29313D), for: .normal)
        rightBtn.titleLabel?.font = UIFont.pingFangSCFont(size: 16)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        rightBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(btnHeight)
            make.width.equalTo(mainViewWidth / 2)
        }
        rightBtn.addLineWithSide(.inTop, color: UIColor.init(hex: 0xE2E2E2), thickness: 0.5, margin1: 0, margin2: 0)
    }

    class func hideAlertView() {
        let lastView = AppUtil.currentWindow().viewWithTag(2009)
        if lastView != nil {
            lastView?.removeAllSubView()
            lastView?.removeFromSuperview()
        }
    }

}

extension CustomAlertUtil {
    @objc class func leftBtnClick(_ btn: UIButton) {
        CustomAlertUtil.hideAlertView()
        handleBlock?(btn.currentTitle ?? "")
    }
    @objc class func rightBtnClick(_ btn: UIButton) {
        CustomAlertUtil.hideAlertView()
        handleBlock?(btn.currentTitle ?? "")
    }
    @objc class func bgClick() {
        CustomAlertUtil.hideAlertView()
    }
}
