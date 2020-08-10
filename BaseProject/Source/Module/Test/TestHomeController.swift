//
//  TestHomeController.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/10.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  测试界面

import UIKit

/// 测试列表页
typealias TestListController = TestHomeController
/// 测试主页
class TestHomeController: BaseViewController {

    // MARK: - Internal Property
    // MARK: - Private Property
    fileprivate let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)

    fileprivate var sourceList: [String] = []

    fileprivate let bubbleView: RedDotBubbleView = RedDotBubbleView()

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
extension TestHomeController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }
}

// MARK: - UI
extension TestHomeController {
    fileprivate func initialUI() -> Void {
        // 1. navigationbar
        self.navigationItem.title = "测试"
        // 2. tableView
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 250
        tableView.showsVerticalScrollIndicator = false
        //tableView.mj_header =
        //tableView.mj_footer =
        //tableView.mj_footer.isHidden = true
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Data(数据处理与加载)
extension TestHomeController {
    // MARK: - Private  数据处理与加载
    fileprivate func initialDataSource() -> Void {
        self.sourceList = ["图片裁剪", "加载动画", "LabelCopy", "TextViewCopy",
                           "PushPop", "PresentDismiss",
                           "PushPopInteractive", "PresentDismissInteractive", "Presentation",
                           "Bubble", "BubbleDraw",
                           "爆炸或还原", "动画的爆炸效果", "移除控件", "回弹", "shapeLayer", "animateWithDuration"]
        self.tableView.reloadData()
    }
}

// MARK: - Event(事件响应)
extension TestHomeController {

}

// MARK; - Request(网络请求)
extension TestHomeController {

}

// MARK: - Enter Page
extension TestHomeController {
    func showImagePicker() -> Void {
        let picker = UIImagePickerController.init()


        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self

        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        picker.modalTransitionStyle = .coverVertical


//        UIImagePickerController *pc = [[UIImagePickerController alloc]init];
//        pc.delegate = self;
//        [pc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        [pc setModalPresentationStyle:UIModalPresentationFullScreen];
//        [pc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
//        [pc setAllowsEditing:YES];

        self.present(picker, animated: true, completion: nil)
    }

    fileprivate func enterLoadingAnimationPage() -> Void {
        let testVC = LoadingAnimationTestController()
        self.enterPageVC(testVC)
    }

    fileprivate func enterLabelCopyPage() -> Void {
        let testVC = LabelCopyTestController()
        self.enterPageVC(testVC)
    }
    fileprivate func enterTextViewCopyPage() -> Void {
        let testVC = TextViewTestController()
        self.enterPageVC(testVC)
    }
    fileprivate func enterPushPopPage() -> Void {
        let testVC = TestPushController()
        self.enterPageVC(testVC)
    }
    fileprivate func enterPresentDismissPage() -> Void {
        let testVC = TestPresentController()
        self.enterPageVC(testVC)
    }
    fileprivate func enterPushPopInteractivePage() -> Void {
        let testVC = TestPushInteractiveController()
        self.enterPageVC(testVC)
    }
    fileprivate func enterPresentDismissInteractivePage() -> Void {
        let testVC = TestPresentInteractiveController()
        self.enterPageVC(testVC)
    }
    fileprivate func enterPresentationPage() -> Void {
        let testVC = TestPresentationController()
        self.enterPageVC(testVC)
    }

}

// MARK: - Notification
extension TestHomeController {

}

// MARK: - Extension
extension TestHomeController {

}

// MARK: - Delegate Function

// MARK: - <UITableViewDataSource>
extension TestHomeController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourceList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = self.sourceList[indexPath.row]
        let cell = TestHomeCell.cellInTableView(tableView)
        cell.model = (title: title, unreadNum: 3)

        //self.bubbleView.attach(item: cell.unreadLabel, with: nil)
        self.bubbleView.attach(item: cell.bubbleView, with: nil)


        return cell
    }


}

// MARK: - <UITableViewDelegate>
extension TestHomeController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return TestHomeCell.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt\(indexPath.row)")

        let model = self.sourceList[indexPath.row]
        switch model {
        case "图片裁剪":
            self.showImagePicker()
        case "加载动画":
            self.enterLoadingAnimationPage()
        case "LabelCopy":
            self.enterLabelCopyPage()
        case "TextViewCopy":
            self.enterTextViewCopyPage()
        case "PushPop":
            self.enterPushPopPage()
        case "PresentDismiss":
            self.enterPresentDismissPage()
        case "PushPopInteractive":
            self.enterPushPopInteractivePage()
        case "PresentDismissInteractive":
            self.enterPresentDismissInteractivePage()
        case "Presentation":
            self.enterPresentationPage()
        case "Bubble":
            let testVC = BubbleTestController()
            self.enterPageVC(testVC)
        case "BubbleDraw":
            let testVC = BubbleDrawTestController()
            self.enterPageVC(testVC)
        default:
            break
        }
    }

}

extension TestHomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // 获取原始的照片
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        let cropVC = ImageCropTestController.init(image: image)
        picker.pushViewController(cropVC, animated: true)

//        self.imageView.image = image

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("ViewController imagePickerControllerDidCancel")
        picker.dismiss(animated: true, completion: nil)
    }

}
