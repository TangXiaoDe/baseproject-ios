//
//  PickerPopView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/20.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Picker的容器视图，用作弹窗使用

import Foundation
import UIKit

class PickerPopView: UIView {

    // MARK: - Internal Property

    /// 回调
    var pickerDoneBtnClickAction: ((_ picker: UIPickerView) -> Void)?
    var datePickerDoneBtnClickAction: ((_ picker: UIDatePicker) -> Void)?

    // MARK: - Private Property

    fileprivate let coverBtn: UIButton = UIButton(type: .custom)

    fileprivate let pickerTopBar: UIView = UIView()
    fileprivate let titleLabel: UILabel = UILabel()
    fileprivate let cancelBtn: UIButton = UIButton(type: .custom)
    fileprivate let doneBtn: UIButton = UIButton(type: .custom)

    fileprivate let pickerHeight: CGFloat
    fileprivate let pickerTopBarH: CGFloat = 40

    fileprivate var picker: UIPickerView?
    fileprivate var datePicker: UIDatePicker?

    // MARK: - Initialize Function
    init(pickerHeight: CGFloat = 200, frame: CGRect = UIScreen.main.bounds) {
        self.pickerHeight = pickerHeight
        super.init(frame: frame)
        self.initialUI()
        self.initialDataSource()
    }
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        //self.initialUI()
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension PickerPopView {
    ///
    func showPicker(picker: UIPickerView) -> Void {
        self.picker = picker
        // 1. picker
        self.addSubview(picker)
        picker.backgroundColor = UIColor.white
        picker.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.pickerHeight)
        }
        // 2. topBar
        self.pickerTopBar.snp.remakeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.pickerTopBarH)
            // 8.1.1版本特别约束(底部有10的间隙)，别的8.x版本是否有该问题，不确定，目前只能限定为8.1.1版本
            let bottomMargin: Float = (UIDevice.current.systemVersion.hasSuffix("8.1")) ? 10 : 0
            make.bottom.equalTo(picker.snp.top).offset(bottomMargin)
        }
    }
    ///
    func showDatePicker(picker: UIDatePicker) -> Void {
        self.datePicker = picker
        // 1. picker
        self.addSubview(picker)
        picker.locale = Locale.init(identifier: "zh_CN")
        picker.backgroundColor = UIColor.white
        picker.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.pickerHeight)
        }
        // 2. topBar
        self.pickerTopBar.snp.remakeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.pickerTopBarH)
            // 8.1.1版本特别约束(底部有10的间隙)，别的8.x版本是否有该问题，不确定，目前只能限定为8.1.1版本
            let bottomMargin: Float = (UIDevice.current.systemVersion.hasSuffix("8.1")) ? 10 : 0
            make.bottom.equalTo(picker.snp.top).offset(bottomMargin)
        }
    }

}

// MARK: - LifeCircle Function

// MARK: - Private  UI
extension PickerPopView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 设置透明度 且 不影响子视图
        self.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        // 1. coverBtn
        self.addSubview(self.coverBtn)
        coverBtn.addTarget(self, action: #selector(coverBtnClick(_:)), for: .touchUpInside)
        coverBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. pickerTopBar 默认布局，之后需修改
        coverBtn.addSubview(self.pickerTopBar)
        pickerTopBar.backgroundColor = UIColor(hex: 0xd9d9d9)
        self.initialPickerTopBar(self.pickerTopBar)
        pickerTopBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.pickerTopBarH)
            make.bottom.equalToSuperview().offset(-self.pickerHeight)
        }
    }
    /// topBar布局
    fileprivate func initialPickerTopBar(_ barView: UIView) -> Void {
        let lrMargin: CGFloat = 10
        // 1. cancelBtn
        barView.addSubview(self.cancelBtn)
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.init(hex: 0x008ae0), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelBtn.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 8, bottom: 5, right: 8)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClick(_:)), for: .touchUpInside)
        cancelBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(barView).offset(lrMargin)
            make.centerY.equalTo(barView)
        }
        // 2. doneBtn
        barView.addSubview(self.doneBtn)
        doneBtn.layer.cornerRadius = 5
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.setTitleColor(UIColor.init(hex: 0x008ae0), for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        doneBtn.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 8, bottom: 5, right: 8)
        doneBtn.addTarget(self, action: #selector(doneBtnClick(_:)), for: .touchUpInside)
        doneBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(barView).offset(-lrMargin)
            make.centerY.equalTo(barView)
        }
        // 3. titleLabel
        barView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.systemFont(ofSize: 15), textColor: UIColor(hex: 0x333333), alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}

// MARK: - Data Function
extension PickerPopView {
    /// 数据源处理
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event Function
extension PickerPopView {
    /// 遮罩点击
    @objc fileprivate func coverBtnClick(_ button: UIButton) -> Void {
        self.removeFromSuperview()
    }
    /// 取消按钮点击响应
    @objc fileprivate func cancelBtnClick(_ button: UIButton) -> Void {
        self.removeFromSuperview()
    }
    /// 确定按钮点击响应
    @objc fileprivate func doneBtnClick(_ button: UIButton) -> Void {
        self.removeFromSuperview()
        if let datePicker = self.datePicker {
            self.datePickerDoneBtnClickAction?(datePicker)
        }
        if let picker = self.picker {
            self.pickerDoneBtnClickAction?(picker)
        }
    }
}

// MARK: - Extension Function

// MARK: - Delegate Function
