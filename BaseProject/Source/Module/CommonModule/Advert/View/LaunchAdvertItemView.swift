//
//  LaunchAdvertItemView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/28.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告Item视图

import UIKit
import SnapKit

protocol LaunchAdvertItemViewProtocol: class {
    /// 点击了广告界面
    func didClickedAdert(in item: LaunchAdvertItemView)
    /// 点击了跳转按钮
    func advertItem(_ item: LaunchAdvertItemView, didClickedSkip skipButton: UIButton)
}

class LaunchAdvertItemView: UIView {

    // MARK: - Internal Property

    var model: AdvertModel? {
        didSet {
            self.setupModel(model)
        }
    }

    weak var delegate: LaunchAdvertItemViewProtocol?

    var isShowing: Bool = false

    // MARK: - Private Property

    let mainView: UIView = UIView()

    let skipBtn: UIButton = UIButton.init(type: .custom)
    let advertImgView: UIImageView = UIImageView()
    let actionControl: UIControl = UIControl()
    
    let bottomView: UIView = UIView()
    
    fileprivate let bottomViewHeight: CGFloat = 80 + kBottomHeight

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension LaunchAdvertItemView {
    class func loadXib() -> LaunchAdvertItemView? {
        return Bundle.main.loadNibNamed("LaunchAdvertItemView", owner: nil, options: nil)?.first as? LaunchAdvertItemView
    }

    /// 更新跳转按钮
    func updateSkipButton(countDown: Int) {
        guard let model = self.model else {
            return
        }
        if !model.canSkip { // 不可跳过
            skipBtn.isEnabled = false
            skipBtn.set(font: UIFont.systemFont(ofSize: 11), cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear)
            skipBtn.setTitle(nil, for: .normal)
        } else { // 可跳过
            skipBtn.isEnabled = true
            skipBtn.set(font: UIFont.systemFont(ofSize: 11), cornerRadius: 12, borderWidth: 0.5, borderColor: UIColor(hex: 0xb0b7c8))
            skipBtn.setTitle("\(countDown) | 跳过", for: .normal)
        }
    }

}

// MARK: - LifeCircle Function
extension LaunchAdvertItemView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension LaunchAdvertItemView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. advertImg
        mainView.addSubview(self.advertImgView)
        self.advertImgView.set(cornerRadius: 0)
        self.advertImgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. actionControl
        mainView.addSubview(self.actionControl)
        self.actionControl.addTarget(self, action: #selector(actionControlClick(_:)), for: .touchUpInside)
        self.actionControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 3. skipBtn
        mainView.addSubview(self.skipBtn)
        //self.skipBtn.contentHorizontalAlignment = .right
        self.skipBtn.set(font: UIFont.systemFont(ofSize: 11))
        self.skipBtn.set(title: "跳过广告", titleColor: UIColor.init(hex: 0x9BA1B0), for: .normal)
        self.skipBtn.addTarget(self, action: #selector(skipBtnClick(_:)), for: .touchUpInside)
        self.skipBtn.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(kStatusBarHeight + 5)
        }
        // 4. bottomView
        mainView.addSubview(self.bottomView)
        self.initialBottomView(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.bottomViewHeight)
        }
    }
    fileprivate func initialBottomView(_ bottomView: UIView) -> Void {
        bottomView.backgroundColor = UIColor.white
        // logo
        let logoView: UIImageView = UIImageView.init()
        bottomView.addSubview(logoView)
        logoView.image = UIImage.init(named: "IMG_launch_advert_logo")
        logoView.set(cornerRadius: 0)
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(18)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension LaunchAdvertItemView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension LaunchAdvertItemView {
    fileprivate func setupModel(_ model: AdvertModel?) -> Void {
        self.advertImgView.image = kPlaceHolderImage
        guard let model = model else {
            return
        }
        self.advertImgView.kf.setImage(with: model.imageUrl, placeholder: kPlaceHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
        // 按钮的默认值
        if !model.canSkip { // 不可跳过
            skipBtn.isEnabled = false
            skipBtn.set(font: UIFont.systemFont(ofSize: 11), cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear)
            skipBtn.setTitle(nil, for: .normal)
        } else { // 可跳过
            skipBtn.isEnabled = true
            skipBtn.set(font: UIFont.systemFont(ofSize: 11), cornerRadius: 12, borderWidth: 0.5, borderColor: UIColor(hex: 0xb0b7c8))
            skipBtn.setTitle("\(model.duration) | 跳过", for: .normal)
        }
    }
}

// MARK: - Event Function
extension LaunchAdvertItemView {

    @objc fileprivate func actionControlClick(_ control: UIControl) -> Void {
        self.delegate?.didClickedAdert(in: self)
    }

    @objc fileprivate func skipBtnClick(_ button: UIButton) -> Void {
        self.delegate?.advertItem(self, didClickedSkip: button)
    }
}

// MARK: - Extension Function
extension LaunchAdvertItemView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension LaunchAdvertItemView {

}
