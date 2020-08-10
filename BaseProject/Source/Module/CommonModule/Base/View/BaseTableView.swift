//
//  BaseTableView.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    fileprivate let emptyDefaultView: ListEmptyPlaceHolderView = ListEmptyPlaceHolderView()

    var showDefaultEmpty: Bool = false {
        didSet {
            self.emptyDefaultView.isHidden = !showDefaultEmpty
        }
    }

    public func setupDefaultImageName(_ imageName: String?, title: String? = nil) {
        if let imageName = imageName {
           self.emptyDefaultView.iconView.image = UIImage.init(named: imageName)
        }
        if let title = title {
            self.emptyDefaultView.titleLabel.text = "\(title)~"
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    fileprivate func commonInit() -> Void {
        self.addSubview(self.emptyDefaultView)
        self.emptyDefaultView.isHidden = true
        self.emptyDefaultView.snp.makeConstraints { (make) in
            make.edges.width.height.equalToSuperview()
        }
    }

}
