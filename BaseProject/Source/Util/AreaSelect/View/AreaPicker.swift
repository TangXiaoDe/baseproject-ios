//
//  AreaPicker.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2019/1/15.
//  Copyright © 2019 TangXiaoDe. All rights reserved.
//
//  地区选择器 - 省市区选择器
//  有背景、可默认选中、

import UIKit

protocol AreaPickerProtocol: class {
    /// 选中回调
    func areaPicker(_ areaPicker: AreaPicker, didSelected areaData: SelectedAreaModel) -> Void
}

class AreaPicker: UIView {

    // MARK: - Internal Property

    weak var delegate: AreaPickerProtocol?
    var selectedAction: ((_ areaPicker: AreaPicker, _ areaData: SelectedAreaModel) -> Void)?

    // MARK: - Private Property

    /// 注：cityList与zoneList 不断变化
    fileprivate var provinceList: [AreaItemModel] = []
    fileprivate var cityList: [AreaItemModel] = []
    fileprivate var zoneList: [AreaItemModel] = []

    fileprivate let coverBtn: UIButton = UIButton(type: .custom)

    fileprivate let pickerView: UIPickerView = UIPickerView()

    fileprivate let pickerTopBar: UIView = UIView()
    fileprivate let titleLabel: UILabel = UILabel()
    fileprivate let cancelBtn: UIButton = UIButton(type: .custom)
    fileprivate let doneBtn: UIButton = UIButton(type: .custom)

    fileprivate let pickerHeight: CGFloat
    fileprivate let pickerTopBarH: CGFloat = 40

    // MARK: - Initialize Function
    init(pickerHeight: CGFloat = 250, frame: CGRect = CGRect.zero) {
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
extension AreaPicker {
    /// 显示指定选中
    func showArea(with selectedArea: SelectedAreaModel?) -> Void {
        guard let selectedArea = selectedArea, let provinceRow = selectedArea.provinceRow else {
            return
        }
        pickerView.selectRow(provinceRow, inComponent: 0, animated: false)
        // 默认数据源处理
        self.cityList = []
        self.zoneList = []
        if !self.provinceList.isEmpty {
            self.cityList = self.provinceList[provinceRow].childs
            pickerView.reloadComponent(1)
        }
        if !self.cityList.isEmpty, let cityRow = selectedArea.cityRow {
            pickerView.selectRow(cityRow, inComponent: 1, animated: false)
            self.zoneList = self.cityList[cityRow].childs
            pickerView.reloadComponent(2)
        }
        if !self.zoneList.isEmpty, let zoneRow = selectedArea.zoneRow {
            pickerView.selectRow(zoneRow, inComponent: 2, animated: false)
        }
    }
}

// MARK: - LifeCircle Function

// MARK: - Private  UI
extension AreaPicker {

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
        // 2. picker
        coverBtn.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor(hex: 0xf3f4f5)
        pickerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.pickerHeight)
        }
        // 3. pickerTopBar
        coverBtn.addSubview(self.pickerTopBar)
        pickerTopBar.backgroundColor = UIColor(hex: 0xd9d9d9)
        self.initialPickerTopBar(self.pickerTopBar)
        pickerTopBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.pickerTopBarH)
            // 8.1.1版本特别约束(底部有10的间隙)，别的8.x版本是否有该问题，不确定，目前只能限定为8.1.1版本
            let bottomMargin: Float = (UIDevice.current.systemVersion.hasSuffix("8.1")) ? 10 : 0
            make.bottom.equalTo(pickerView.snp.top).offset(bottomMargin)
        }
    }
    /// topBar布局
    fileprivate func initialPickerTopBar(_ barView: UIView) -> Void {
        let lrMargin: CGFloat = 10
        // 1. cancelBtn
        barView.addSubview(self.cancelBtn)
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.init(hex: 0x666666), for: .normal)
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
        doneBtn.setTitleColor(AppColor.theme, for: .normal)
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
extension AreaPicker {
    /// 数据源处理
    fileprivate func initialDataSource() -> Void {
        // 默认数据源处理
        self.provinceList = AreaManager.share.provinceList
        if !self.provinceList.isEmpty {
            self.cityList = self.provinceList[0].childs
        }
        if !self.cityList.isEmpty {
            self.zoneList = self.cityList[0].childs
        }
    }
}

// MARK: - Event Function
extension AreaPicker {
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

        // selectedRow 为-1和0的特殊处理，特别是该列没有数据源时仍返回0
        let provinceRow = pickerView.selectedRow(inComponent: 0)
        let cityRow = pickerView.selectedRow(inComponent: 1)
        let zoneRow = pickerView.selectedRow(inComponent: 2)
        // 省级id一定存在，但市级和区级可能为空，需根据数据源确定
        var areaId = self.provinceList[provinceRow].id
        if -1 != zoneRow && !self.zoneList.isEmpty {
            areaId = self.zoneList[zoneRow].id
        } else if -1 != cityRow && !self.cityList.isEmpty {
            areaId = self.cityList[cityRow].id
        }
        // 选中回调
        if let areaData = AreaManager.share.areaData(withAreaId: areaId) {
            self.delegate?.areaPicker(self, didSelected: areaData)
            self.selectedAction?(self, areaData)
        }
    }
}

// MARK: - Extension Function

// MARK: - Delegate Function

// MARK: - <UIPickerViewDataSource>
extension AreaPicker: UIPickerViewDataSource {
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        let components = 3
        return components
    }

    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if (0 == component) {
            count = self.provinceList.count
        } else if (1 == component) {
            count = self.cityList.count
        } else {
            count = self.zoneList.count
        }
        return count
    }
}

// MARK: - <UIPickerViewDataSource>
extension AreaPicker: UIPickerViewDelegate {
    // returns width of column and height of row for each component.
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let componentW = UIScreen.main.bounds.size.width / 3.0
        return componentW
    }

    // returns height of row for each component.
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        var pickerLabel: UILabel
        if let label = view as? UILabel {
            pickerLabel = label
        } else {
            let label = UILabel()
            label.minimumScaleFactor = 8.0
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.init(hex: 0x333333)
            pickerLabel = label
        }

        // Fill the label text here
        pickerLabel.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)

        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        if (0 == component) {
            //第0列  省级
            let province = self.provinceList[row]
            title = province.title
        } else if(1 == component) {
            // 第1列 市级
            let city = self.cityList[row]
            title = city.title
        } else {
            // 第2列 区级
            let zone = self.zoneList[row]
            title = zone.title
        }
        return title
    }

    /// 某一列中的某一行选中选中响应 —— 注意联动处理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 联动处理：选中省或市时刷新下级数据源
        if 0 == component {
            // 第0列 省级
            let province = self.provinceList[row]
            self.cityList = province.childs
            pickerView.reloadComponent(1)

            if !self.cityList.isEmpty {
                pickerView.selectRow(0, inComponent: 1, animated: true)

                let city = self.cityList[0]
                self.zoneList = city.childs
                pickerView.reloadComponent(2)
                if !self.zoneList.isEmpty {
                    pickerView.selectRow(0, inComponent: 2, animated: true)
                }
            } else {
                self.zoneList = []
                pickerView.reloadComponent(2)
            }
        } else if 1 == component {
            // 第1列 市级
            if self.cityList.isEmpty {
                return
            }

            let city = self.cityList[row]
            self.zoneList = city.childs
            pickerView.reloadComponent(2)
            if !self.zoneList.isEmpty {
                pickerView.selectRow(0, inComponent: 2, animated: true)
            }
        }
    }

}
