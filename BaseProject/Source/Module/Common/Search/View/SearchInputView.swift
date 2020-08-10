//
//  SearchInputView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  搜索输入控件

import UIKit
import ChainOneKit

protocol SearchInputViewProtocol: class {
    /// 取消按钮回调点击
    func searchView(_ searchView: SearchInputView, didClickedCancel cancelBtn: UIButton) -> Void
    /// 输入框内容变更回调
    func searchView(_ searchView: SearchInputView, didInputTextChanged text: String?) -> Void
    /// 键盘done按钮点击回调
    func searchView(_ searchView: SearchInputView, didClickedKeyboardDoneWith text: String) -> Void
}

/// 搜索通用输入控件
typealias SearchCommonInputView = SearchInputView
/// 搜索输入控件
class SearchInputView: UIView {

    // MARK: - Internal Property

    static let viewHeight: CGFloat = 44

    /// 回调
    weak var delegate: SearchInputViewProtocol?


    var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                self.searchField.attributedPlaceholder = NSAttributedString.init(string: placeholder, attributes: [NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 16), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x525C6E)])
            }
        }
    }

    // MARK: - Private Property

    let mainView: UIView = UIView()
    let searchField: UITextField = UITextField()
    let cancelBtn: UIButton = UIButton.init(type: .custom)

    fileprivate let lrMargin: CGFloat = 12
    fileprivate let searchH: CGFloat = 32
    fileprivate let cancelBtnW: CGFloat = 55

    fileprivate let inputMaxLen: Int = 20

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
    func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension SearchInputView {
    class func loadXib() -> SearchInputView? {
        return Bundle.main.loadNibNamed("SearchInputView", owner: nil, options: nil)?.first as? SearchInputView
    }
}

// MARK: - LifeCircle Function
extension SearchInputView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }

    /// 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
// MARK: - Private UI 手动布局
extension SearchInputView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.backgroundColor = UIColor.init(hex: 0x2D385C)
        // 1. cancelBtn
        mainView.addSubview(self.cancelBtn)
        self.cancelBtn.set(title: "取消", titleColor: UIColor.white, for: .normal)
        self.cancelBtn.set(font: UIFont.pingFangSCFont(size: 16))
        self.cancelBtn.addTarget(self, action: #selector(cancelBtnClick(_:)), for: .touchUpInside)
        self.cancelBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(self.searchH)
            make.width.equalTo(self.cancelBtnW)
            make.trailing.equalToSuperview()
        }
        // 2. searchField
        mainView.addSubview(self.searchField)
        self.searchField.returnKeyType = .done
        self.searchField.set(cornerRadius: 5)
        self.searchField.backgroundColor = UIColor.init(hex: 0x202A46)
        self.searchField.set(placeHolder: nil, font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.white)
        self.searchField.attributedPlaceholder = NSAttributedString.init(string: "输入搜索内容", attributes: [NSAttributedString.Key.font: UIFont.pingFangSCFont(size: 16), NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x525C6E)])
        self.searchField.leftViewMode = .always
        self.searchField.delegate = self
        self.searchField.addTarget(self, action: #selector(searchFieldChanged(_:)), for: .editingChanged)
        self.searchField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(self.searchH)
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalTo(self.cancelBtn.snp.leading)
        }
        // fieldLeftView
        let leftView: UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 36, height: 32))
        self.searchField.leftView = leftView
        leftView.image = UIImage.init(named: "IMG_icon_moment_post_search")
        leftView.contentMode = .center
        leftView.snp.makeConstraints { (make) in
            make.width.equalTo(36)
            make.height.equalTo(32)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension SearchInputView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension SearchInputView {

}

// MARK: - Event Function
extension SearchInputView {
    /// 取消按钮点击
    @objc fileprivate func cancelBtnClick(_ button: UIButton) -> Void {
        self.delegate?.searchView(self, didClickedCancel: button)
    }

    /// 输入框内容变更
    @objc fileprivate func searchFieldChanged(_ textField: UITextField) -> Void {
        TextFieldHelper.limitTextField(textField, withMaxLen: self.inputMaxLen)
        self.delegate?.searchView(self, didInputTextChanged: textField.text)
    }

}

// MARK: - Extension Function
extension SearchInputView {

}

// MARK: - Delegate Function

// MARK: - <UITextFieldDelegate>
extension SearchInputView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var returnFlag: Bool = false
        guard let text = textField.text, !text.isEmpty else {
            return returnFlag
        }
        returnFlag = true
        self.delegate?.searchView(self, didClickedKeyboardDoneWith: text)
        return returnFlag
    }

}
