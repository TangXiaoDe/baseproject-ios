//
//  PicturesThumbView.swift
//  ThinkSNSPlus
//
//  Created by 小唐 on 28/06/2018.
//  Copyright © 2018 ZhiYiCX. All rights reserved.
//
//  图片数组的缩略展示——九宫格展示

import Foundation

protocol PicturesThumbViewProtocol: class {
    /// 点击了指定索引上的缩略图
    func picturesView(_ picturesView: PicturesThumbView, didSelectedPictureAt index: Int) -> Void
    /// 点击了最后位置处的数量蒙层
    func didClickLastCountMask(in picturesView: PicturesThumbView) -> Void
}

/// 图片数组的缩略展示——九宫格展示
class PicturesThumbView: UIView {

    // MARK: - Internal Property

    /// 回调
    weak var delegate: PicturesThumbViewProtocol?

    /// 数据源
    var models: [PictureModel] = [] {
        didSet {
            self.setupWithModels(models)
        }
    }

    /// 所有图片
    var pictures: [UIImage?] {
        return itemViews.map { $0.picture }
    }
    /// 所有图片在屏幕上的 frames
    var frames: [CGRect] {
        return itemViews.map { $0.frameOnScreen }
    }

    /// 视图宽度，用于布局
    var viewWidth: CGFloat = kScreenWidth
    /// 左右间距，默认为0
    var lrMargin: CGFloat = 0
    /// 顶部间距
    var topMargin: CGFloat = 0
    /// 底部间距
    var bottomMargin: CGFloat = 0

    // MARK: - Private Property

    /// 最大显示数
    fileprivate let maxShow: Int = 9
    fileprivate var itemViews: [PictureThumbItemView] = []
    fileprivate let mainView: UIView = UIView()
    fileprivate let kPictureTagBase: Int = 200
    // MARK: - Initialize Function
    init(viewWidth: CGFloat, lrMargin: CGFloat) {
        self.viewWidth = viewWidth
        self.lrMargin = lrMargin
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

    // MARK: - LifeCircle Function

}

// MARK: - Internal Function
extension PicturesThumbView {
    /// 通过内容计算高度
    class func heightWithModel(_ models: [PictureModel], viewWidth: CGFloat, lrMargin: CGFloat) -> CGFloat {
        let view: PicturesThumbView = PicturesThumbView.init(viewWidth: viewWidth, lrMargin: lrMargin)
        var height: CGFloat = 0
        if !models.isEmpty {
            height = view.heightWithModels(models)
        }
        return height
    }
}

// MARK: - Private  UI
extension PicturesThumbView {

    // 界面布局
    fileprivate func initialUI() -> Void {
        // 构造图片数组，但并不添加，加载数据时才移除添加
        for index in 0..<self.maxShow {
            let itemView = PictureThumbItemView()
            itemView.addTarget(self, action: #selector(pictureItemClick(_:)), for: .touchUpInside)
            itemView.tag = kPictureTagBase + index
            //itemView.addTarget(self, action: #selector(countMaskBtnClick(_:)), for: .touchUpInside)
            itemViews.append(itemView)
        }
        // 1. mainView 便于整体布局
        self.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(0)  // 高度默认为0
//            make.top.equalTo(self).offset(topMargin)
//            make.bottom.equalTo(self).offset(-bottomMargin)
        }
    }

}

// MARK: - Data Function
extension PicturesThumbView {
    /// 数据加载
    fileprivate func setupWithModels(_ models: [PictureModel]) -> Void {
        self.mainView.removeAllSubView()
        // 1.调整需要显示的图片的数量
        let count: Int = min(models.count, self.maxShow)
        if count <= 0 {
            self.mainView.snp.updateConstraints({ (make) in
                make.height.equalTo(0)
            })
            return
        }
        // 2.获取图片的 frames
        var pictureFrames: [CGRect] = []
        if models.count == 1 {
            let model = models[0]
            pictureFrames = [self.getOnlyOneFrame(pictureSize: model.originalSize)]
//                [getOneFrame(pictureOriginalSize: model.originalSize)]
        } else {
            pictureFrames = self.getMultiFrames(count: count)
//                getMultiFrames(count: imageCount)
        }
        // 3.刷新每张图片并更新其 frame
        for index in 0..<count {
            let model = models[index]
            let itemView = itemViews[index]
            let pictureFrame = pictureFrames[index]
            itemView.frame = pictureFrame
//            // 如果是第九张图片，且图片的总数大于 9，那么最后一张图片要显示数量蒙层
//            if index == 8 {
//                model.unshowCount = models.count - 9
//            }

            itemView.model = model
            self.mainView.addSubview(itemView)
        }

        // 4.更新九宫格视图的 高度
        let height: CGFloat = self.heightWithModels(models)
        self.mainView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }

    }
}

// MARK: - Event Function
extension PicturesThumbView {
    /// 图片元素点击响应
    @objc fileprivate func pictureItemClick(_ control: UIControl) -> Void {
        let index = control.tag - self.kPictureTagBase
        self.delegate?.picturesView(self, didSelectedPictureAt: index)
    }
    /// 最后一张且带数量的蒙版点击响应
    @objc fileprivate func countMaskBtnClick(_ button: UIButton) -> Void {
        self.delegate?.didClickLastCountMask(in: self)
    }
}

// MARK: - Extension Function
extension PicturesThumbView {

    func getOnlyOneFrame(pictureSize: CGSize) -> CGRect {
        var rect: CGRect = CGRect(origin: CGPoint(x: lrMargin, y: topMargin), size: pictureSize)
        var showSize: CGSize = CGSize(width: pictureSize.width, height: pictureSize.height)
        let showWidth: CGFloat = self.viewWidth - self.lrMargin * 2.0
        if pictureSize.width - pictureSize.height > 0.1 {
            // width > height，横图
            // 若 width > showWidth，则以showWidth为准进行等比显示
            // 若 width <= showWidth，则以width为准进行正常显示(不拉伸)
            if pictureSize.width - showWidth > 0.1 {
                showSize = pictureSize.scaleAspectForWidth(showWidth)
            }
            // 横图的最大高度限制：175
            let itemMaxH: CGFloat = 175
            if showSize.height > itemMaxH {
                showSize.height = itemMaxH
            }
        } else if pictureSize.width - pictureSize.height < 0.1 {
            // width < height，竖图， 注：给予最大高度限制——宽的3倍
            // 宽度处理，竖图的宽度限制：最小1/3，最大1/2
            let itemMinW: CGFloat = CGFloat(floor(Double(showWidth / 3.0)))
            let itemMaxW: CGFloat = CGFloat(floor(Double(showWidth * 0.5)))
            if pictureSize.width - itemMinW < 0.1 {
                showSize = pictureSize.scaleAspectForWidth(itemMinW)
            } else if pictureSize.width - itemMaxW > 0.1 {
                showSize = pictureSize.scaleAspectForWidth(itemMaxW)
            }
            // 高度处理，竖图的高度限制：当前显示宽度的1.5倍
            let itemMaxH: CGFloat = CGFloat(floor(Double(showSize.width * 1.5)))
            if showSize.height - itemMaxH > 0.1 {
                showSize.height = itemMaxH
            }
        } else {
            // width = height，方图
            if pictureSize.width - showWidth * 0.5 > 0.1 {
                showSize = pictureSize.scaleAspectForWidth(showWidth * 0.5)
            }
        }
        rect.size = showSize
        return rect
    }

    func getMultiFrames(count: Int) -> [CGRect] {
        var colNum: Int = 3
        let margin: CGFloat = 5
        let itemWH: CGFloat = (self.viewWidth - lrMargin * 2.0 - margin * 2.0) / CGFloat(colNum)
        var frames: [CGRect] = []
        // count==4时的特殊处理，注意：不能放到上面，因为itemWH 和 count相关
        if count == 4 {
            colNum = 2
        }
        for index in 0...count - 1 {
            let row = index / colNum
            let col = index % colNum
            let x: CGFloat = lrMargin + (itemWH + margin) * CGFloat(col)
            let y: CGFloat = topMargin + (itemWH + margin) * CGFloat(row)
            let rect: CGRect = CGRect(x: x, y: y, width: itemWH, height: itemWH)
            frames.append(rect)
        }
        return frames
    }

    func heightWithModels(_ models: [PictureModel]) -> CGFloat {
        let colNum: Int = 3
        let margin: CGFloat = 5
        let itemWH: CGFloat = (self.viewWidth - lrMargin * 2.0 - margin * 2.0) / CGFloat(colNum)
        var height: CGFloat = self.getOnlyOneFrame(pictureSize: models[0].originalSize).size.height + topMargin + bottomMargin
        if models.count > 1 {
            let showCount: Int = min(models.count, self.maxShow)
            let rowCount: Int = (showCount % 3 == 0) ? (showCount / 3) : (showCount / 3 + 1)
            let pictureHeight: CGFloat = CGFloat(rowCount) * itemWH + margin * CGFloat(rowCount - 1)
            height = topMargin + bottomMargin + pictureHeight
        }
        return height
    }

    /**
    // 一张图设置
    ///
    /// - Parameters:
    ///   - pictureOriginalSize: 图片原大小
    ///   - isLong: 是否为长图
    /// - Returns: 一张图时显示的大小
    open func getOneFrame(pictureOriginalSize: CGSize) -> CGRect {
        guard isUseVideoFrameRule == false else {
            // 视屏的占位图是另外的计算规则
            //            如果 宽等于高 播放器大小显示为width1*width1 播放时内容等比缩放，完整填充播放
            //            如果 宽小于高（竖着的长方形） 播放器大小显示width1*width1 播放时内容等比缩放，左右无内容处两边显示黑边
            //            如果 宽大于高（横着的长方形） 播放器大小显示宽度width1*高度为原视频高度等比缩放后的高度 播放时内容等比缩放，完成填充内容播放
            if pictureOriginalSize.width == pictureOriginalSize.height {
                let buttonFrame = CGRect(x: 0, y: 0, width: width1, height: width1)
                return buttonFrame
            } else if pictureOriginalSize.width < pictureOriginalSize.height {
                let buttonFrame = CGRect(x: 0, y: 0, width: width1, height: width1)
                return buttonFrame
            } else if pictureOriginalSize.width > pictureOriginalSize.height {
                var heigth = width1 / pictureOriginalSize.width * pictureOriginalSize.height
                if heigth > width1 {
                    heigth = width1
                }
                let buttonFrame = CGRect(x: 0, y: 0, width: width1, height: heigth)
                return buttonFrame
            }
            return CGRect.zero
        }
        if pictureOriginalSize.isLongPictureSize() {
            // 如果是长图
            let heigth = widthLong * 1.333
            let buttonFrame = CGRect(x: 0, y: 0, width: widthLong, height: heigth)
            return buttonFrame
        } else {
            // 如果不是长图
            var heigth = width1 / pictureOriginalSize.width * pictureOriginalSize.height
            // 高度最大尺寸为最大宽度的 4/3
            if heigth > width1 * 4 / 3 {
                heigth = width1 * 4 / 3
            }
            let buttonFrame = CGRect(x: 0, y: 0, width: width1, height: heigth)
            return buttonFrame
        }
    }
    
    open func getMultiFrames(count: Int) -> [CGRect] {
        switch count {
        case 2, 3, 4, 9:
            return get2349Frames(count:count)
        case 5:
            return get5Frames()
        case 6:
            return get6Frames()
        case 7:
            return get7Frames()
        case 8:
            return get8Frames()
        default:
            return []
        }
    }

    
    // MARK: 内部调用方法
    /// 2/3/4/9 张图设置
    internal func get2349Frames(count: Int) -> [CGRect] {
        var frames: [CGRect] = []
        for index in 0...count - 1 {
            var buttonFrame = CGRect.zero
            let number = (count == 2 || count == 4) ? 2 : 3
            let buttonWidth = (width1 - CGFloat(number - 1) * spacing) / CGFloat(number)
            buttonFrame = CGRect(x: CGFloat(index % number) * (buttonWidth + spacing), y: CGFloat(index / number) * (buttonWidth + spacing), width: buttonWidth, height: buttonWidth)
            frames.append(buttonFrame)
        }
        return frames
    }
    
    /// 五张图设置
    internal func get5Frames() -> [CGRect] {
        var frames: [CGRect] = []
        for index in 0...4 {
            var buttonFrame = CGRect.zero
            if index == 0 {
                buttonFrame = CGRect(x: 0, y: 0, width: width3 * 2 + spacing, height: width3 * 2 + spacing)
            }
            if index == 1 || index == 2 {
                buttonFrame = CGRect(x: (width3 + spacing) * 2, y: CGFloat(index - 1) * (width3 + spacing), width: width3, height: width3)
            }
            if index == 3 || index == 4 {
                buttonFrame = CGRect(x: CGFloat(index - 3) * (width2 + spacing), y: (width3 + spacing) * 2, width: width2, height: width2)
            }
            frames.append(buttonFrame)
        }
        return frames
    }
    
    /// 六张图设置
    internal func get6Frames() -> [CGRect] {
        var frames: [CGRect] = []
        for index in 0...5 {
            var buttonFrame = CGRect.zero
            if index == 0 {
                buttonFrame = CGRect(x: 0, y: 0, width: width3 * 2 + spacing, height: width3 * 2 + spacing)
            }
            if index == 1 || index == 2 {
                buttonFrame = CGRect(x: (width3 + spacing) * 2, y: CGFloat(index - 1) * (width3 + spacing), width: width3, height: width3)
            }
            if index > 2 {
                buttonFrame = CGRect(x: CGFloat(index - 3) * (width3 + spacing), y: (width3 + spacing) * 2, width: width3, height: width3)
            }
            frames.append(buttonFrame)
        }
        return frames
    }
    
    /// 七张图设置
    internal func get7Frames() -> [CGRect] {
        var frames: [CGRect] = []
        for index in 0...6 {
            var buttonFrame = CGRect.zero
            if index == 0 {
                buttonFrame = CGRect(x: 0, y: 0, width: width2, height: width2)
            }
            if index == 1 || index == 2 {
                buttonFrame = CGRect(x: width2 + spacing + CGFloat(index - 1) * (width4 + spacing), y: 0, width: width4, height: width4)
            }
            if index == 3 {
                buttonFrame = CGRect(x: width2 + spacing, y: width4 + spacing, width: width2, height: width2)
            }
            if index == 4 {
                buttonFrame = CGRect(x: 0, y: width2 + spacing, width: width2, height: width2)
            }
            if index > 4 {
                buttonFrame = CGRect(x: width2 + spacing + CGFloat(index - 5) * (width4 + spacing), y: width2 + spacing * 2 + width4, width: width4, height: width4)
            }
            frames.append(buttonFrame)
        }
        return frames
    }
    
    /// 八张图设置
    internal func get8Frames() -> [CGRect] {
        var frames: [CGRect] = []
        for index in 0...7 {
            var buttonFrame = CGRect.zero
            if index < 3 {
                buttonFrame = CGRect(x: CGFloat(index) * (width3 + spacing), y: 0, width: width3, height: width3)
            }
            if index == 3 || index == 4 {
                buttonFrame = CGRect(x: CGFloat(index - 3) * (spacing + width2), y: width3 + spacing, width: width2, height: width2)
            }
            if index > 4 {
                buttonFrame = CGRect(x: CGFloat(index - 5) * (width3 + spacing), y: width3 + spacing * 2 + width2, width: width3, height: width3)
            }
            frames.append(buttonFrame)
        }
        return frames
    }

    **/

}
