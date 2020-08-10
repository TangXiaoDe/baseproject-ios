//
//  BaseTableViewController.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  继承自BaseViewController并使用BaseTableView，而不是直接继承UITableViewController
/**
 *****
    严重Bug：BaseTableViewController的子类中，对于UITableViewDataSource和UITableViewDelegate的中的方法，
        如果BaseTableViewController已实现，则override重新实现；
        如果BaseTableViewController未实现，则子类直接实现时，在Debug模式下正常，在release模式下无效，根本就不走这些方法。
    建议：将BaseTableViewController更改为UIBaseTableViewController。
 *****
 
 **/

import UIKit
import MJRefresh

protocol BaseTableViewControllerProtocol: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView) -> Void
}
extension BaseTableViewControllerProtocol {
    func scrollViewDidScroll(_ scrollView: UIScrollView) -> Void {}
}

/// TableViewController的基类
class BaseTableViewController: BaseViewController {

    // MARK: - Internal Property
    var tableView: BaseTableView = BaseTableView(frame: CGRect.zero, style: .plain)

    weak var delegate: BaseTableViewControllerProtocol?

    var limit: Int = 15
    var offset: Int = 0

    // 内容为空时能否显示占位图
    var canShowPlaceHolder: Bool = true

    // MARK: - Private Property

    // MARK: - Initialize Function

}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }
}

// MARK: - UI
extension BaseTableViewController {
    @objc func initialUI() -> Void {
        self.view.backgroundColor = AppColor.pageBg
        // 1. navigationbar
        // 2. tableView
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 250
        tableView.backgroundColor = AppColor.pageBg
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableView.mj_header = XDRefreshHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        tableView.mj_footer = XDRefreshFooter(refreshingTarget: self, refreshingAction: #selector(footerLoadMore))
        tableView.mj_header.isHidden = true
        tableView.mj_footer.isHidden = true
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //// 顶部位置 的版本适配
        //if #available(iOS 11.0, *) {
        //    self.scrollView.contentInsetAdjustmentBehavior = .never
        //} else if #available(iOS 9.0, *) {
        //    self.automaticallyAdjustsScrollViewInsets = false
        //}
    }
}

// MARK: - Data(数据处理与加载)
extension BaseTableViewController {
    // MARK: - Private  数据处理与加载
    @objc func initialDataSource() -> Void {
        //self.tableView.mj_header.beginRefreshing()
    }
}

// MARK: - Event(事件响应)
extension BaseTableViewController {
    /// 顶部刷新
    @objc func headerRefresh() -> Void {
        self.refreshRequest()
    }
    /// 底部记载更多
    @objc func footerLoadMore() -> Void {
        self.loadMoreRequest()
    }

}

// MARK; - Request(网络请求)
extension BaseTableViewController {
    /// 初始化请求
    @objc func initialRequest() -> Void {
        self.refreshRequest()
    }

    /// 下拉刷新请求 - 需子类重写实现
    @objc func refreshRequest() -> Void {
//        PowerNetworkManager.getPowerRecord(offset: self.offset, limit: self.limit) { [weak self](status, msg, models) in
//            guard let `self` = self else {
//                return
//            }
//            self.tableView.mj_header.endRefreshing()
//            guard status, let models = models else {
//                ToastUtil.showToast(title: msg)
//                return
//            }
//            self.sourceList = data.records
//            self.offset = self.sourceList.count
//            self.tableView.mj_footer.state = .idle
//            self.tableView.mj_footer.isHidden = data.records.count < self.limit
//            self.tableView.showDefaultEmpty = models?.isEmpty
//            self.tableView.reloadData()
//        }
    }

    /// 上拉加载更多请求 - 需子类重写实现
    @objc func loadMoreRequest() -> Void {
//        PowerNetworkManager.getPowerRecord(offset: self.offset, limit: self.limit) { [weak self](status, msg, models) in
//            guard let `self` = self else {
//                return
//            }
//            self.tableView.mj_footer.endRefreshing()
//            guard status, let models = models else {
//                ToastUtil.showToast(title: msg)
//                self.tableView.mj_footer.endRefreshingWithWeakNetwork()
//                return
//            }
//            if models.count < self.limit {
//                self.tableView.mj_footer.endRefreshingWithNoMoreData()
//            }
//            self.sourceList += models
//            self.offset = self.sourceList.count
//            self.tableView.reloadData()
//        }
    }

}

// MARK: - Enter Page
extension BaseTableViewController {

}

// MARK: - Notification
extension BaseTableViewController {

}

// MARK: - Extension
extension BaseTableViewController {

}

// MARK: - Delegate Function

// MARK: - <UITableViewDataSource>
extension BaseTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if nil == cell {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }

        //cell?.preservesSuperviewLayoutMargins = false
        //cell?.layoutMargins = UIEdgeInsets.zero
        //cell?.selectionStyle = .none
        cell?.textLabel?.text = "Just Test"

        return cell!
    }

    /// return list of section titles to display in section index view (e.g. "ABCD...Z#")
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }

}

// MARK: - <UITableViewDelegate>
extension BaseTableViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.scrollViewDidScroll(scrollView)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt\(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = "UITableViewHeaderFooterViewIdentifier"
        var sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if nil == sectionHeader {
            sectionHeader = UITableViewHeaderFooterView(reuseIdentifier: identifier)
        }
        sectionHeader?.contentView.backgroundColor = AppColor.pageBg
        return sectionHeader
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let identifier = "UITableViewHeaderFooterViewIdentifier"
        var sectionFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if nil == sectionFooter {
            sectionFooter = UITableViewHeaderFooterView(reuseIdentifier: identifier)
        }
        sectionFooter?.contentView.backgroundColor = AppColor.pageBg
        return sectionFooter
    }

    // 选中索引时的回调
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    // 编辑相关
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        // 只使用tableView右侧排序功能，而不显示左侧删除和插入，并且左侧不留白的方法
        // UITableViewCellEditingStyleNone隐藏了左侧编辑按钮，
        // shouldIndentWhileEditingRowAtIndexPath控制cell在编辑模式下左侧是否缩进。
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }

}
