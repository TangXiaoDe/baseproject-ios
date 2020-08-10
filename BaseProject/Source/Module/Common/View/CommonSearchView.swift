//
//  CommonSearchView.swift
//  BaseProject
//
//  Created by zhaowei on 2019/6/12.
//  Copyright © 2019 ChainOne. All rights reserved.
//
protocol CommonSearchViewDelegate: class {
    func searchBarTextBeginEditing(_ textField: UITextField)
    func searchBarTextDidChange(_ textField: UITextField)
    func searchBarTextClear(_ textField: UITextField)
    func searchBarShouldReturn(_ textField: UITextField) -> Bool
}

extension CommonSearchView: CommonSearchViewDelegate {
    func searchBarShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    func searchBarTextBeginEditing(_ textField: UITextField) {

    }
    func searchBarTextDidChange(_ textField: UITextField) {

    }
    func searchBarTextClear(_ textField: UITextField) {

    }
}

import UIKit
/// 添加话题页面
class CommonSearchView: UIView {
    // MARK: - Internal Property
    // MARK: - Private Property
    var mainView = UIView()

    var searchIcon = UIImageView()

    var searchTextField = UITextField()

    var clearBtn = UIButton()

    weak var delegate: CommonSearchViewDelegate?

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        //fatalError("init(coder:) has not been implemented")
    }

    /// 通用初始化：UI、配置、数据等
    fileprivate func commonInit() -> Void {
        self.initialUI()

        // 添加监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(searchBarTextDidChangeNotificationProcess(_:)), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(searchBarTextBeginEditingNotificationProcess(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UI
extension CommonSearchView {
    fileprivate func initialUI() -> Void {
        self.backgroundColor = UIColor.white
        self.addSubview(self.mainView)
        self.mainView.layer.masksToBounds = true
        self.mainView.layer.cornerRadius = 16
        self.mainView.backgroundColor = UIColor.init(hex: 0xF1F2F6)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        self.mainView.addSubview(self.searchIcon)
        self.searchIcon.image = UIImage.init(named: "IMG_icon_moment_post_search")
        self.searchIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 16, height: 16))
        }

        self.mainView.addSubview(self.clearBtn)
        self.clearBtn.setImage(UIImage.init(named: "IMG_icon_input_clear"), for: .normal)
        self.clearBtn.addTarget(self, action: #selector(clearBtnClick), for: .touchUpInside)
        self.clearBtn.isHidden = true
        self.clearBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 16, height: 16))
        }

        self.mainView.addSubview(self.searchTextField)
        self.searchTextField.delegate = self as? UITextFieldDelegate
        self.searchTextField.returnKeyType = .search
        self.searchTextField.textColor = UIColor.init(hex: 0x202A46)
        self.searchTextField.placeholder = "添加标签可以获得更多互动"
        self.searchTextField.attributedPlaceholder = NSAttributedString.init(string: "添加标签可以获得更多互动", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0xC7CED8)])
        self.searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(self.searchIcon.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalTo(self.clearBtn.snp.left).offset(-10)
            make.height.equalToSuperview()
        }

    }
}

// MARK: - event
extension CommonSearchView {
    @objc fileprivate func clearBtnClick() {
        self.clearBtn.isHidden = true
        self.searchTextField.text = ""
        self.delegate?.searchBarTextClear(self.searchTextField)
    }
}

// MARK: - Notification
extension CommonSearchView {

    @objc fileprivate func searchBarTextBeginEditingNotificationProcess(_ notification: Notification) {
        self.delegate?.searchBarTextBeginEditing(self.searchTextField)
    }

    @objc fileprivate func searchBarTextDidChangeNotificationProcess(_ notification: Notification) {
        if !self.searchTextField.text!.isEmpty {
            self.clearBtn.isHidden = false
        } else {
            self.clearBtn.isHidden = true
        }
        self.delegate?.searchBarTextDidChange(self.searchTextField)
    }
}

extension CommonSearchView: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.delegate?.searchBarShouldReturn(textField) ?? true
    }
}
