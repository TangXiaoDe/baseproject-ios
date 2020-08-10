//
//  PasswordLoginInputView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/11.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  密码登录输入视图

import UIKit
import ChainOneKit

class PasswordLoginInputView: UIView {

    // MARK: - Internal Property

    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var pwdSecurityBtn: UIButton!

    /// 回调
    var inputChangedAction: ((_ inputView: PasswordLoginInputView) -> Void)?

    // MARK: - Private Property

    fileprivate let accountLen: Int = 11
    fileprivate let passwordLen: Int = 25

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
extension PasswordLoginInputView {
    class func loadXib() -> PasswordLoginInputView? {
        return Bundle.main.loadNibNamed("PasswordLoginInputView", owner: nil, options: nil)?.first as? PasswordLoginInputView
    }

    /// 是否可登录
    func couldDone() -> Bool {
        var flag: Bool = false
        guard let account = self.accountField.text, let password = self.passwordField.text else {
            return flag
        }
        flag = !account.isEmpty && !password.isEmpty
        return flag
    }
}

// MARK: - LifeCircle Function
extension PasswordLoginInputView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension PasswordLoginInputView {

    /// 界面布局
    fileprivate func initialUI() -> Void {

    }

}
// MARK: - Private UI Xib加载后处理
extension PasswordLoginInputView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        self.backgroundColor = UIColor.clear
        // accountField
        let accountClearBtn: UIButton = UIButton.init(type: .custom)
        accountClearBtn.setImage(UIImage.init(named: "IMG_icon_input_clear"), for: .normal)
        accountClearBtn.bounds = CGRect.init(x: 0, y: 0, width: 22, height: 30)
        accountClearBtn.addTarget(self, action: #selector(accountClearBtnClick(_:)), for: .touchUpInside)
        self.accountField.rightView = accountClearBtn
        self.accountField.rightViewMode = .whileEditing
        self.accountField.addTarget(self, action: #selector(accountFieldValueChanged(_:)), for: .editingChanged)
        self.accountField.attributedPlaceholder = NSAttributedString.init(string: "input.placeholder.phone".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x525C6E)])
        // passwordField
        self.passwordField.isSecureTextEntry = true
        self.passwordField.addTarget(self, action: #selector(passwordFieldValueChanged(_:)), for: .editingChanged)
        self.passwordField.attributedPlaceholder = NSAttributedString.init(string: "input.placeholder.password".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hex: 0x525C6E)])
        self.pwdSecurityBtn.isSelected = false
        // 版本适配
        if #available(iOS 11.0, *) {
            self.passwordField.textContentType = UITextContentType.name
        }
    }
}

// MARK: - Data Function
extension PasswordLoginInputView {

}

// MARK: - Event Function
extension PasswordLoginInputView {
    /// 密码可见性按钮点击响应
    @IBAction func pwdSecurityBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordField.isSecureTextEntry = !sender.isSelected
    }
    /// 账号输入框输入值变更
    @objc fileprivate func accountFieldValueChanged(_ textField: UITextField) -> Void {
        TextFieldHelper.limitTextField(textField, withMaxLen: self.accountLen)
        self.inputChangedAction?(self)
    }
    /// 密码输入框输入值变更
    @objc fileprivate func passwordFieldValueChanged(_ textField: UITextField) -> Void {
        TextFieldHelper.limitTextField(textField, withMaxLen: self.passwordLen)
        self.inputChangedAction?(self)
    }
    /// 账号清除按钮点击
    @objc fileprivate func accountClearBtnClick(_ button: UIButton) -> Void {
        self.accountField.text = nil
        self.inputChangedAction?(self)
    }

}

// MARK: - Extension Function
extension PasswordLoginInputView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension PasswordLoginInputView {

}
