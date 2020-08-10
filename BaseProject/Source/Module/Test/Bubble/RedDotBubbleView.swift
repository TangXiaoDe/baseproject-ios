//
//  RedDotBubbleView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/17.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  红点气泡图，可拖动
//  绑定attachView，添加拖动事件，拖动开始时将attachView渲染到一张图片上显示给propertyView作为替身使用；
//  黏贴板

import UIKit

/// 黏贴板状态
enum AdhesivePlateStatus {
    /// 粘上
    case stickers
    /// 分离
    case separate
}

protocol RedDotBubbleAttachViewProtocol: UIView {
    /// 实际显示的气泡大小 -> 部分控件可能会增大响应区域，但显示效果仍不变
    var bubbleSize: CGSize { get }
}


class RedDotBubbleView: UIView {

    // MARK: - Internal Property

    /// 气泡的最大距离 - 超过该距离则不显示气泡
    var maxDistance: CGFloat = CGFloat.max
    /// 气泡颜色
    var bubbleColor: UIColor = UIColor.red

    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }


    // MARK: - Private Property

    fileprivate let centerCircleView: UIView = UIView()
    /// 分离时的Block数组
    fileprivate var separateBlocks: [UIView: ((_ view: UIView) -> Bool)?] = [:]
    // 绘制气泡/贝塞尔曲线
    fileprivate let shapeLayer: CAShapeLayer = CAShapeLayer()
    // 替身视图 - 移动视图
    fileprivate let prototypeView: UIImageView = UIImageView()

    /// 黏贴板状态
    fileprivate var status: AdhesivePlateStatus = .separate
    /// 拖动视图 - 当前，每次拖动都不一样
    fileprivate var touchView: RedDotBubbleAttachViewProtocol?
    /// 偏离点差 - 拖动坐标和原始view中心的距离差(拖动视图内 拖动点和中心点的偏差)
    fileprivate var deviationPoint: CGPoint = CGPoint.zero

    fileprivate var bubbleWidth: CGFloat = 10
    fileprivate var centerCircleR: CGFloat = 5
    fileprivate var touchCircleR: CGFloat = 10
    // 原始view和拖动的 view 圆心距离
    fileprivate var centerDistance: CGFloat = 0
    // 原始 view 的中心坐标
    fileprivate var oldBackViewCenter: CGPoint = CGPoint.zero



    // MARK: - Initialize Function

    init(maxDistance: CGFloat = CGFloat.max, bubbleColor: UIColor = UIColor.red) {
        self.maxDistance = maxDistance
        self.bubbleColor = bubbleColor
        super.init(frame: UIScreen.main.bounds)
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
        self.isUserInteractionEnabled = false   // 默认不响应
    }

}

// MARK: - Internal Function
extension RedDotBubbleView {
    /// 视图黏贴
    func attach(item itemView: RedDotBubbleAttachViewProtocol, with separation: ((_ view: UIView) -> Bool)? = nil) -> Void {
        // 1. 添加长按手势
        if !self.separateBlocks.keys.contains(itemView) {
            let panGR = UIPanGestureRecognizer.init(target: self, action: #selector(panGRProcess(_:)))
            itemView.isUserInteractionEnabled = true
            itemView.addGestureRecognizer(panGR)
        }
        // 2. 保存block
        self.separateBlocks[itemView] = separation
    }

}

// MARK: - LifeCircle Function
extension RedDotBubbleView {
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
extension RedDotBubbleView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 0. centerCircleView
        self.addSubview(self.centerCircleView)
        // 1. propertyView
        self.addSubview(self.prototypeView)
        // 2. shapeLayer
        self.layer.insertSublayer(self.shapeLayer, below: self.centerCircleView.layer)
    }

}
// MARK: - Private UI Xib加载后处理
extension RedDotBubbleView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension RedDotBubbleView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }

}

// MARK: - Event Function
extension RedDotBubbleView {
    /// 长按手势处理
    @objc fileprivate func panGRProcess(_ panGR: UIPanGestureRecognizer) -> Void {
        let location: CGPoint = panGR.location(in: self)

        switch panGR.state {
        case .began:
            self.touchView = panGR.view as? RedDotBubbleAttachViewProtocol
            let dragPoint: CGPoint = panGR.location(in: panGR.view)
            if let touchView = panGR.view as? RedDotBubbleAttachViewProtocol {
                self.deviationPoint = CGPoint.init(x: dragPoint.x - touchView.frame.width * 0.5, y: dragPoint.y - touchView.frame.height * 0.5)
            }
            self.panInitial()
        case .changed:
            self.centerCircleView.isHidden = false
            self.centerCircleView.center = self.oldBackViewCenter
            self.centerCircleView.set(cornerRadius: 3)
            self.centerCircleView.bounds = CGRect.init(x: 0, y: 0, width: 6, height: 6)
            self.centerCircleView.backgroundColor = UIColor.red
            self.prototypeView.center = CGPoint.init(x: location.x - self.deviationPoint.x, y: location.y - self.deviationPoint.y)
            self.drawRect()
        case .failed:
            fallthrough
        case .possible:
            fallthrough
        case .cancelled:
            fallthrough
        case .ended:
            self.shapeLayer.isHidden = true
            self.springBack(view: self.prototypeView, point: self.oldBackViewCenter)
        default:
            break
        }
    }

}

// MARK: - Extension Function
extension RedDotBubbleView {
    /// 拖动初始化
    fileprivate func panInitial() -> Void {
        // 1. 添加到屏幕
        self.frame = UIScreen.main.bounds
        UIApplication.shared.keyWindow?.addSubview(self)
        // 2. propertyView配置
        var animationViewOrigin: CGPoint = CGPoint.zero
        if let touchView = self.touchView {
            animationViewOrigin = touchView.convert(CGPoint.zero, to: self)
            prototypeView.frame = CGRect.init(x: animationViewOrigin.x, y: animationViewOrigin.y, width: touchView.frame.size.width, height: touchView.frame.size.height)
            self.prototypeView.isHidden = false
            self.prototypeView.image = UIImage.getImageFromView(touchView)

            self.oldBackViewCenter = CGPoint.init(x: animationViewOrigin.x + touchView.frame.size.width * 0.5, y: animationViewOrigin.y + touchView.frame.size.height * 0.5)
            self.bubbleWidth = min(touchView.bubbleSize.width, touchView.bubbleSize.height)
        }
        // 3. 其他配置
        self.touchView?.isHidden = true
        self.isUserInteractionEnabled = true
        self.status = .stickers
        // 4. 其他记录
        //self.bubbleWidth = min(self.prototypeView.frame.size.width, self.prototypeView.frame.size.height)
        self.touchCircleR = self.bubbleWidth * 0.5
        self.centerDistance = 0
    }

    /// 曲线绘制
    fileprivate func drawRect() {
        let smallCircleRadius: CGFloat = 3
        let smallCircleCenter: CGPoint = self.oldBackViewCenter
        let bigCircleCenter: CGPoint = self.prototypeView.center
        let bigCircleRadius: CGFloat = self.touchCircleR
        let bezierPath = self.getBezierPathWith(smallCircleCenter: smallCircleCenter, smallCircleRadius: smallCircleRadius, bigCircleCenter: bigCircleCenter, bigCircleRadius: bigCircleRadius)
        self.shapeLayer.path = bezierPath.cgPath
        self.shapeLayer.fillColor = self.bubbleColor.cgColor
        self.shapeLayer.isHidden = false
    }

    /// 回弹
    fileprivate func springBack(view: UIView, point: CGPoint) -> Void {
        let duration: TimeInterval = 0.3
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            view.center = point
        }) { (finished) in
            if finished {
                self.touchView?.isHidden = false
                self.isUserInteractionEnabled = false
                view.isHidden = true
                self.removeFromSuperview()
                self.centerCircleView.isHidden = true
            }
        }
    }

    /// 爆炸动效💥
    fileprivate func explore() -> Void {

    }
    /// 爆炸结束
    fileprivate func explosionComplete() -> Void {

    }

}

extension RedDotBubbleView {
    // 获取两点之间的间距 - 圆心距
    fileprivate func getDistanceWith(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        let offsetX: CGFloat = pointA.x - pointB.x
        let offsetY: CGFloat = pointA.y - pointB.y
        let offset: CGFloat = sqrt(offsetX * offsetX + offsetY * offsetY)
        return offset
    }

    // 获取贝塞尔曲线
    fileprivate func getBezierPathWith(smallCircleCenter: CGPoint, smallCircleRadius: CGFloat, bigCircleCenter: CGPoint, bigCircleRadius: CGFloat) -> UIBezierPath {
        // 获取小圆信息
        let x1: CGFloat = smallCircleCenter.x
        let y1: CGFloat = smallCircleCenter.y
        //let r2: CGFloat  = smallCircle.bounds.width * 0.5
        let r1: CGFloat = smallCircleRadius

        // 获取大圆信息
        let x2: CGFloat = bigCircleCenter.x
        let y2: CGFloat = bigCircleCenter.y
        //let r2: CGFloat  = bigCircle.bounds.width * 0.5
        let r2: CGFloat = bigCircleRadius

        // 获取三角函数
        //let d: CGFloat  = self.getDistanceWith(pointA: smallCircle.center, pointB: bigCircle.center)
        let d: CGFloat = self.getDistanceWith(pointA: smallCircleCenter, pointB: bigCircleCenter)
        let sinA: CGFloat = (y2 - y1) / d
        let cosA: CGFloat = (x2 - x1) / d

        // 获取2根切线上的4个点
        let pointA: CGPoint = CGPoint.init(x: x1 - r1 * sinA, y: y1 + r1 * cosA)
        let pointB: CGPoint = CGPoint.init(x: x1 + r1 * sinA, y: y1 - r1 * cosA)
        let pointC: CGPoint = CGPoint.init(x: x2 + r2 * sinA, y: y2 - r2 * cosA)
        let pointD: CGPoint = CGPoint.init(x: x2 - r2 * sinA, y: y2 + r2 * cosA)

        // 获取2根切线上的控制点，以便画曲线
        let pointO: CGPoint = CGPoint.init(x: pointA.x + d * 0.5 * cosA, y: pointA.y + d * 0.5 * sinA)
        let pointP: CGPoint = CGPoint.init(x: pointB.x + d * 0.5 * cosA, y: pointB.y + d * 0.5 * sinA)

        // 创建路径
        let path = UIBezierPath.init()
        path.move(to: pointA)
        path.addLine(to: pointB)
        path.addQuadCurve(to: pointC, controlPoint: pointP)
        path.addLine(to: pointD)
        path.addQuadCurve(to: pointA, controlPoint: pointO)

        return path
    }
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension RedDotBubbleView {

}
