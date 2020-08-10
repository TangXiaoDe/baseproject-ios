//
//  AreaSelectDemoController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/1/23.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  省市区选择的使用Demo

import UIKit

class AreaSelectDemoController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property

    fileprivate let selectBtn: UIButton = UIButton(type: .custom)

    fileprivate var address: String? = nil
    fileprivate var selectedArea: SelectedAreaModel?

    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension AreaSelectDemoController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - UI
extension AreaSelectDemoController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = UIColor.init(hex: 0xf6f6f6)
        // nav
        self.navigationItem.title = "省市区选择"
        // selectBtn
        self.view.addSubview(self.selectBtn)
        self.selectBtn.set(title: "请选择", titleColor: UIColor.white, for: .normal)
        self.selectBtn.contentHorizontalAlignment = .left
        self.selectBtn.backgroundColor = UIColor.random
        self.selectBtn.set(font: UIFont.systemFont(ofSize: 15), cornerRadius: 35.0 * 0.5, borderWidth: 0, borderColor: UIColor.clear)
        self.selectBtn.addTarget(self, action: #selector(selectAreaBtnClick(_:)), for: .touchUpInside)
        self.selectBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(35)
        }

    }
}

// MARK: - Data(数据处理与加载)
extension AreaSelectDemoController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension AreaSelectDemoController {

    @objc fileprivate func selectAreaBtnClick(_ button: UIButton) -> Void {
        let picker = AreaPicker(pickerHeight: 200, frame: UIScreen.main.bounds)
        UIApplication.shared.keyWindow?.addSubview(picker)
        //let areaData1 = AreaManager.share.areaData(withAreaId: "710000")
        //picker.showArea(with: areaData1)
//        let areaData2 = AreaManager.share.areaData(withAreaId: "659003")
//        picker.showArea(with: areaData2)
//        let areaData3 = AreaManager.share.areaData(withAddress: "", separator: " ")
        //picker.showArea(with: nil)
        picker.selectedAction = { (picker, area) in
            print(area)
        }
    }

}

// MARK: - Notification
extension AreaSelectDemoController {

}

// MARK: - Extension Function
extension AreaSelectDemoController {

}

// MARK: - Delegate Function

// MARK: - <>
extension AreaSelectDemoController {

}
