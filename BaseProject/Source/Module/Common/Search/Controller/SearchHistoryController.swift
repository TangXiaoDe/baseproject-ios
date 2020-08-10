//
//  SearchHistoryController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  搜索历史页

import UIKit

protocol SearchHistoryControllerProtocol: class {
    /// 历史记录选中回调
    func historyVC(_ historyVC: SearchHistoryController, didSelected history: SearchHistoryModel) -> Void
    /// 滚动回调
    func historyVC(_ historyVC: SearchHistoryController, didScrolled scrollView: UIScrollView) -> Void
}

/// 搜索历史控制器
class SearchHistoryController: BaseTableViewController {

    // MARK: - Internal Property

    let type: SearchHistoryType

    /// 回调
    weak var historyDelegate: SearchHistoryControllerProtocol?
    var historySelectedAction: ((_ historyVC: SearchHistoryController, _ selectedHistory: SearchHistoryModel) -> Void)?


    // MARK: - Private Property

    fileprivate var sourceList: [SearchHistoryModel] = []

    fileprivate var afterId: Int = 0

    // MARK: - Initialize Function
    init(type: SearchHistoryType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension SearchHistoryController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UI
extension SearchHistoryController {
    override func initialUI() -> Void {
        super.initialUI()
        // 1. navigationbar
        // 2. tableView
        self.tableView.mj_header.isHidden = false
        self.tableView.backgroundColor = AppColor.pageBg
    }

}

// MARK: - Data(数据处理与加载)
extension SearchHistoryController {
    // MARK: - Private  数据处理与加载
    override func initialDataSource() -> Void {
        self.tableView.mj_header.beginRefreshing()
    }

}

// MARK: - Event(事件响应)
extension SearchHistoryController {

}

// MARK; - Request(网络请求)
extension SearchHistoryController {
    /// 重写下拉刷新请求
    override func refreshRequest() {
        // 根据搜索类型 获取搜索历史记录 并加载数据
//        self.sourceList = DataBaseManager().search.getSearchHistory(for: self.type)
        self.tableView.mj_header.endRefreshing()
        self.tableView.reloadData()
    }
    /// 重写上拉加载更多请求
    override func loadMoreRequest() {

    }

}

// MARK: - Enter Page
extension SearchHistoryController {

}

// MARK: - Notification
extension SearchHistoryController {

}

// MARK: - Extension
extension SearchHistoryController {

}

// MARK: - Delegate Function

// MARK: - <UITableViewDataSource>
extension SearchHistoryController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchHistoryCell.cellInTableView(tableView)
        cell.model = self.sourceList[indexPath.row]
        return cell
    }

}

// MARK: - <UITableViewDelegate>
extension SearchHistoryController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        self.historyDelegate?.historyVC(self, didScrolled: scrollView)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchHistorySectionHeader.headerInTableView(tableView)
        header.clearAction = { (header, clearControl) in
//            DataBaseManager().search.deleteAllHistory(for: self.type)
            self.sourceList = []
            self.tableView.reloadData()
        }
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SearchHistorySectionHeader.headerHeight
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = self.sourceList[indexPath.row]
        self.historyDelegate?.historyVC(self, didSelected: history)
        self.historySelectedAction?(self, history)
    }

}
