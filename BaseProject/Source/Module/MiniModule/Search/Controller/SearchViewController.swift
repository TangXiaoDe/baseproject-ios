//
//  SearchViewController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  搜索基类: 搜索历史记录页 + 搜索结果页组成
//  页面UI参考动态搜索，即导航栏上放搜索框的布局
//  注：该界面待完善，若参考请参考MomentSearchController界面;

import UIKit

protocol SearchResultControllerProtocol: UIViewController {

}


typealias SearchBaseController = SearchViewController
class SearchViewController: BaseViewController {
    // MARK: - Internal Property

    let historyVC: UIViewController
    let resultVC: UIViewController

    // MARK: - Private Property

    let topView: UIView = UIView()
    let searchView: SearchInputView = SearchInputView()


    // MARK: - Initialize Function

    init() {
        self.historyVC = SearchHistoryController.init(type: SearchHistoryType.none)
        self.resultVC = UIViewController()
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension SearchViewController {
    /// 显示结果页
    func showResult(with keyword: String?) -> Void {
        self.resultVC.view.isHidden = false
        self.historyVC.view.isHidden = true
        // 搜索调用
    }
    /// 显示历史记录页
    func showHistory() -> Void {
        self.resultVC.view.isHidden = true
        self.historyVC.view.isHidden = false
    }

}

// MARK: - LifeCircle & Override Function
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    /// 控制器的view将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    /// 控制器的view即将消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

// MARK: - UI
extension SearchViewController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        // 1. topView
        self.view.addSubview(self.topView)
        self.topView.backgroundColor = UIColor.init(hex: 0x2D385C)
        self.topView.snp.makeConstraints { (make) in
            make.height.equalTo(kNavigationStatusBarHeight)
            make.leading.trailing.top.equalToSuperview()
        }
        // 1.x searchView
        self.topView.addSubview(self.searchView)
        self.searchView.delegate = self
        self.searchView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(SearchInputView.viewHeight)
        }
        // 2. historyVC
        self.addChild(self.historyVC)
        self.view.addSubview(self.historyVC.view)
        self.historyVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomHeight)
        }
        // 3. resultVC
        self.addChild(self.resultVC)
        self.view.addSubview(self.resultVC.view)
        self.resultVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kBottomHeight)
        }
        // 4. defaultShow
        self.showHistory()
    }

}

// MARK: - Data(数据处理与加载)
extension SearchViewController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {

    }
}

// MARK: - Event(事件响应)
extension SearchViewController {

}

// MARK: - Enter Page
extension SearchViewController {

}

// MARK: - Notification
extension SearchViewController {

}

// MARK: - Extension Function
extension SearchViewController {

}

// MARK: - Delegate Function

// MARK: - <SearchInputViewProtocol>
extension SearchViewController: SearchInputViewProtocol {
    /// 取消按钮回调点击
    func searchView(_ searchView: SearchInputView, didClickedCancel cancelBtn: UIButton) -> Void {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    /// 输入框内容变更回调
    func searchView(_ searchView: SearchInputView, didInputTextChanged text: String?) -> Void {

    }
    /// 键盘done按钮点击回调
    func searchView(_ searchView: SearchInputView, didClickedKeyboardDoneWith text: String) -> Void {

    }

}
