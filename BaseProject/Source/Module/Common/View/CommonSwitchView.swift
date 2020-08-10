//
//  CommonSwitchView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  通用的Switch控件，用于设置中UISwitch的代替

import UIKit


/// 通用的Switch控件
class CommonSwitchView: UIControl {

    // MARK: - Internal Property

    static let viewWidth: CGFloat = 36
    static let viewHeight: CGFloat = 20

    var isOn: Bool = false {
        didSet {
            // IMG_switch_close  IMG_switch_open
            let imageName: String = isOn ? "IMG_switch_open" : "IMG_switch_close"
            self.bgImageView.image = UIImage.init(named: imageName)
        }
    }

    // MARK: - Private Property

    fileprivate let bgImageView: UIImageView = UIImageView()


    // MARK: - Initialize Function

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
        self.addTarget(self, action: #selector(selfClick(_:)), for: .touchUpInside)
    }
}

// MARK: - Internal Function
extension CommonSwitchView {
    // setOn, does not send action
    func setOn(_ on: Bool, animated: Bool) -> Void {
        self.isOn = on
    }

}

// MARK: - Override Function

// MARK: - Private  UI
extension CommonSwitchView {
    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.bgImageView)
        // IMG_switch_close  IMG_switch_open
        self.bgImageView.image = UIImage.init(named: "IMG_switch_close")
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Private  数据(处理 与 加载)
extension CommonSwitchView {

}

// MARK: - Private  事件
extension CommonSwitchView {
    /// 自身点击，触发valueChanged事件
    @objc fileprivate func selfClick(_ control: UIControl) -> Void {
        self.isOn = !self.isOn
        self.sendActions(for: UIControl.Event.valueChanged)
    }

}
