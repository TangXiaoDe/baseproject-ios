//
//  XDWKWebViewController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/22.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit
import UIKit
import JavaScriptCore
import WebKit
import MJRefresh

private struct XDWKWebViewControllerUX {
    static let timeoutInterval: TimeInterval = 60
}

class XDWKWebViewController: BaseViewController {
    // MARK: - Internal Property

    /// 是否开启请求网页时,携带口令在请求头中
    var haveToken: Bool = true

    let type: XDWebViwSourceType
    weak var webView: WKWebView!

    // MARK: - Internal Function
    // MARK: - Private Property

    // navItem
    fileprivate var leftItem: UIBarButtonItem = UIBarButtonItem()
    fileprivate var closeItem: UIBarButtonItem = UIBarButtonItem()

    /// 进度条
    let progressView = UIProgressView(progressViewStyle: .bar)
    /// 缺省图
    fileprivate let occupiedView = UIButton(type: .custom)

    fileprivate var oldBarShadowImage: UIImage? = nil

    var duration: Int = 0
    var isComplete: Bool = false
    var playCompleteBlock:(() -> Void)?

    // MARK: - Initialize Function

    init(type: XDWebViwSourceType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    init(type: XDWebViwSourceType, duration: Int, isComplete: Bool, completeBlock:(() -> Void)?) {
        self.type = type
        self.duration = duration
        self.isComplete = isComplete
        self.playCompleteBlock = completeBlock
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.progressView.removeFromSuperview()
    }

    // MARK: - LifeCircle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 添加观察者观察 webView 加载进度
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 移除观察者
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        // 隐藏进度条
        progressView.isHidden = true
    }

}

// MARK: - UI

extension XDWKWebViewController {
    /// 页面布局
    @objc func initialUI() -> Void {
        // navigationbar
        self.leftItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "IMG_navbar_back"), style: .plain, target: self, action: #selector(leftBarItemClick))
        self.closeItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeBarItemClick))
        self.navigationItem.leftBarButtonItems = [leftItem]
        // 在右方放置了一个同样大小的 view，可以将 title view 顶在正中间
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIView(frame: CGRect(x: 0, y: 0, width: 88, height: 44)))
        // webview
        let config: WKWebViewConfiguration = WKWebViewConfiguration()
        let strJS: String = "window.ISAPP = true"
        let script: WKUserScript = WKUserScript(source: strJS, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        let webView: WKWebView = WKWebView(frame: CGRect.zero, configuration: config)
        self.view.addSubview(webView)
        webView.scrollView.bounces = false
        webView.scrollView.mj_header = XDRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshRequest))
        webView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottomMargin)
        }
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.webView = webView
        // progress view
        progressView.frame = CGRect(x: 0, y: kNavigationStatusBarHeight, width: UIScreen.main.bounds.width, height: progressView.frame.height)
        progressView.tintColor = UIColor.init(hex: 0x3a92f4)
        navigationController?.view.addSubview(progressView)
        // occupied view
        occupiedView.frame = UIScreen.main.bounds
        occupiedView.backgroundColor = UIColor.clear
        occupiedView.addTarget(self, action: #selector(occupiedViewClick), for: .touchUpInside)
        view.addSubview(occupiedView)
        self.view.bringSubviewToFront(occupiedView)
    }
}

// MARK: - 数据处理与加载

extension XDWKWebViewController {
    /// 默认数据加载
    @objc func initialDataSource() -> Void {
        //self.loadLocalHtmlData()
//        self.loadNetworkData(url)
        switch self.type {
        case .none:
            break
        case .url(let url):
            self.loadNetworkData(url)
        case .strUrl(let strUrl):
            if let url = URL.init(string: strUrl) {
                self.loadNetworkData(url)
            }
        case .content(let html):
            self.loadContent(html: html)
        case  .local(let filePath):
            self.loadLocalHtmlData(htmlPath: filePath)
        }
    }

    /// 加载本地网页数据
    fileprivate func loadLocalHtmlData() -> Void {
        guard let htmlPath = Bundle.main.path(forResource: "h5test", ofType: "html"), let htmlData: Data = try? Data(contentsOf: URL(fileURLWithPath: htmlPath)), let htmlString = String(data: htmlData, encoding: String.Encoding.utf8) else {
            return
        }
        self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }

    /// 加载网页数据
    func loadNetworkData(_ url: URL) -> Void {
        var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: XDWKWebViewControllerUX.timeoutInterval)
        if let authorization = AccountManager.share.currentAccountInfo?.token?.token, haveToken {
            request.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        }
        self.webView.load(request)
    }
    /// 加载本地数据
    fileprivate func loadLocalHtmlData(htmlPath: String) -> Void {
        guard let htmlData: Data = try? Data(contentsOf: URL(fileURLWithPath: htmlPath)), let htmlString = String(data: htmlData, encoding: String.Encoding.utf8) else {
            return
        }
        self.webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
    /// 加载文本内容
    fileprivate func loadContent(html: String) -> Void {
        //self.webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        self.webView.loadHTMLString(html, baseURL: nil)
    }

    /// 执行隐藏控件的js
    fileprivate func executeIdentiferWebViewJS() -> Void {
        let strJS: String = "window.ISAPP = true"
        self.executeJS(strJS)
    }
}

// MARK: - 事件响应

extension XDWKWebViewController {
    /// 点击了返回按钮
    @objc fileprivate func leftBarItemClick() {
        if self.webView.canGoBack {
            self.webView.goBack()
            self.showCloseItem(self.webView.canGoBack)
        } else {
            self.closeBarItemClick()
        }
    }

    /// 点击了关闭按钮
    @objc fileprivate func closeBarItemClick() {
        let popVC = navigationController?.popViewController(animated: true)
        if popVC == nil {
            dismiss(animated: true, completion: nil)
        }
    }

    /// 点击了占位图
    @objc fileprivate func occupiedViewClick() {
        self.updateWebView()
    }

    @objc fileprivate func refreshRequest() -> Void {
        self.webView.reload()
    }
}

// MARK: - Notification

extension XDWKWebViewController {
    // MARK: - Observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            switch Float(self.webView.estimatedProgress) {
            case 1.0: // 隐藏进度条
                UIView.animate(withDuration: 0.1, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.progress = 0
                })
            default:  // 显示进度条
                self.progressView.alpha = 1
            }
            progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
        }
    }
}

// MARK: - Extension Function

extension XDWKWebViewController {
    /// 是否显示关闭按钮
    fileprivate func showCloseItem(_ show: Bool) -> Void {
        var items: [UIBarButtonItem] = [self.leftItem]
        if show {
            items.append(self.closeItem)
        }
        self.navigationItem.leftBarButtonItems = items
    }
}

extension XDWKWebViewController {

    /// 执行js - 子类继承，需要放开权限
    func executeJS(_ js: String, complete: ((Any?, Error?) -> Void)? = nil ) -> Void {
        self.webView.evaluateJavaScript(js) { (result, error) in
            complete?(result, error)
        }
    }

    /// 刷新网页
    fileprivate func updateWebView() {
        self.webView.reload()
    }

    fileprivate func isJumpToExternalAppWithURL(_ url: URL) -> Bool {
        guard let shceme = url.scheme else {
            return false
        }
        let validSchemes: Set<String> = Set<String>(["http", "https"])
        return !validSchemes.contains(shceme)
    }

}

// MARK: - Delegate Function

// MARK: - <WKNavigationDelegate>
extension XDWKWebViewController: WKNavigationDelegate {

    /// 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //print("webView didFinish")
        self.webView.scrollView.mj_header.endRefreshing()
        // 更新网页标题: 若外界传入标题，则不使用网页本身标题；否则使用网页本身标题
        if let title = self.navigationItem.title, !title.isEmpty {
            return
        }
        self.navigationItem.title = webView.title
    }

    /// 加载错误
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        //print("webView didReceiveServerRedirectForProvisionalNavigation")
        self.webView.scrollView.mj_header.endRefreshing()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        //print("webView decidePolicy")
        if let url = navigationAction.request.url, self.isJumpToExternalAppWithURL(url) {
            UIApplication.shared.openURL(url)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }

    /// 在提交的主帧中发生错误时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //print("webView didFail \(error.localizedDescription)")
        // 显示占位图，再次点击可重新刷新
        occupiedView.isHidden = false
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //print("webView didFailProvisionalNavigation \(error.localizedDescription)")
        // 显示占位图，再次点击可重新刷新
        occupiedView.isHidden = false
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 这里为了让用户感觉到进度，设置了一个假进度
        progressView.progress = 0.2
        progressView.isHidden = false
        // 隐藏占位图
        occupiedView.isHidden = true
    }

    /// 加载https
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //print("webView didReceive")
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, let serverTrust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential.init(trust: serverTrust)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        }
    }

}

// MARK: - <WKUIDelegate>
extension XDWKWebViewController: WKUIDelegate {

}
