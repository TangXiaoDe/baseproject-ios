//
//  UnreadNumBubbleView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  未读数气泡视图

import UIKit

/// 未读数气泡视图
class UnreadNumBubbleView: UIView {

    // MARK: - Internal Property

    var unreadNum: Int = 0 {
        didSet {
            self.setupWithUnreadNum(unreadNum)
        }
    }

    /// 气泡颜色
    var bubbleColor: UIColor = UIColor.red {
        didSet {

        }
    }


    // MARK: - Private Property

    fileprivate let mainView: UIView = UIView()

    fileprivate let frontView: UIView = UIView()
    fileprivate let backView: UIView = UIView()
    fileprivate let unreadLabel: UILabel = UILabel()

    fileprivate let minWH: CGFloat = 15

    fileprivate let shapeLayer: CAShapeLayer = CAShapeLayer.init()


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
extension UnreadNumBubbleView {
    class func loadXib() -> UnreadNumBubbleView? {
        return Bundle.main.loadNibNamed("UnreadNumBubbleView", owner: nil, options: nil)?.first as? UnreadNumBubbleView
    }

}

// MARK: - LifeCircle Function
extension UnreadNumBubbleView {
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
extension UnreadNumBubbleView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.backgroundColor = UIColor.lightGray
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()

            make.width.height.equalTo(25)
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // backView
        mainView.addSubview(self.backView)
        self.backView.backgroundColor = UIColor.red
        self.backView.set(cornerRadius: 5 * 0.5)
        self.backView.isHidden = true       // 默认隐藏
        self.backView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(5)
        }


        // frontView
        mainView.addSubview(self.frontView)
        self.frontView.set(cornerRadius: self.minWH * 0.5)
        self.frontView.backgroundColor = UIColor.red
        self.frontView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()

            make.height.equalTo(self.minWH)
            make.width.greaterThanOrEqualTo(self.minWH)
            make.width.lessThanOrEqualToSuperview()
        }
        // unreadLabel
        self.frontView.addSubview(self.unreadLabel)
        self.unreadLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.white, alignment: .center)
        self.unreadLabel.snp.makeConstraints { (make) in
            make.top.bottom.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
        }

        // shapeLayer
        self.layer.insertSublayer(self.shapeLayer, below: nil)
        //self.layer.insertSublayer(self.shapeLayer, above: nil)
        self.shapeLayer.fillColor = UIColor.red.cgColor
        self.shapeLayer.isHidden = true     // 默认隐藏

        // 拖动手势
        let panGR: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panGRProcess(_:)))
        self.frontView.addGestureRecognizer(panGR)

    }

}
// MARK: - Private UI Xib加载后处理
extension UnreadNumBubbleView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension UnreadNumBubbleView {
    /// 数据加载
    fileprivate func setupWithUnreadNum(_ unreadNum: Int) -> Void {
        // 子控件数据加载
        self.unreadLabel.text = "\(unreadNum)"
        self.unreadLabel.isHidden = unreadNum <= 0
        self.isHidden = unreadNum <= 0
    }

}

// MARK: - Event Function
extension UnreadNumBubbleView {
    @objc fileprivate func panGRProcess(_ panGR: UIPanGestureRecognizer) -> Void {
        let panPoint = panGR.location(in: self)
        let circleDistance = self.getDistanceWith(pointA: panPoint, pointB: self.center)
        switch panGR.state {
        case .began:
            self.backView.isHidden = false
        case .changed:
            self.frontView.center = panPoint
            //panGR.setTranslation(CGPoint.zero, in: self)
            // 计算并绘制贝塞尔曲线
            if circleDistance < self.minWH * 0.5 + 5 * 0.5 {
                self.shapeLayer.isHidden = true
            } else {
                print("\(self.backView.center) ", " \(self.frontView.center)")
                self.shapeLayer.isHidden = false
                self.shapeLayer.path = self.getBezierPathWith(smallCircle: self.backView, bigCircle: self.frontView).cgPath
            }
        case .ended:
            // 超过距离，移除动画(爆炸)；否则返回圆点
            self.shapeLayer.isHidden = true
            self.frontView.center = CGPoint.init(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)

        case .failed:
            fallthrough
        case .cancelled:
            fallthrough
        case .possible:
            // 返回圆点
            self.shapeLayer.isHidden = true
            self.frontView.center = CGPoint.init(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        default:
            break
        }
    }

}

// MARK: - Extension Function
extension UnreadNumBubbleView {
    // 获取两点之间的间距 - 圆心距
    fileprivate func getDistanceWith(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        let offsetX: CGFloat = pointA.x - pointB.x
        let offsetY: CGFloat = pointA.y - pointB.y
        let offset: CGFloat = sqrt(offsetX * offsetX + offsetY * offsetY)
        return offset
    }

    // 获取贝塞尔曲线
    fileprivate func getBezierPathWith(smallCircle: UIView, bigCircle: UIView) -> UIBezierPath {
        // 获取小圆信息
        let x1: CGFloat = smallCircle.center.x
        let y1: CGFloat = smallCircle.center.y
        //let r1: CGFloat  = smallCircle.bounds.width * 0.5
        let r1: CGFloat = 2.5

        // 获取大圆信息
        let x2: CGFloat = bigCircle.center.x
        let y2: CGFloat = bigCircle.center.y
        //let r2: CGFloat  = bigCircle.bounds.width * 0.5
        let r2: CGFloat = 7.5

        // 获取三角函数
        let d: CGFloat = self.getDistanceWith(pointA: smallCircle.center, pointB: bigCircle.center)
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
extension UnreadNumBubbleView {

}


/**
 
 - (void)panAction:(UIPanGestureRecognizer *)pan {
 
 CGPoint panPoint = [pan locationInView:self.superview];
 if (pan.state == UIGestureRecognizerStateBegan) {
     self.backView.hidden = NO;
     [self removeBubbleAnimation];
 } else if (pan.state == UIGestureRecognizerStateChanged) {
     self.frontView.center = panPoint;
     [self calculatePoint];
     if (radius_B < radius_A / 10) {
         self.backView.hidden = YES;
         [self.animationLayer removeFromSuperlayer];
     }
 } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
 
 if (radius_B >= radius_A / 10) {
 
 [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.4 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
 self.frontView.frame = self.frame;
 } completion:^(BOOL finished) {
 if (finished) {
 //                    [self addBubbleAnimation];
 }
 }];
 if (self.cleanMessageBlock) {
 self.cleanMessageBlock(NO);
 }
 } else {
 [self hidenBubbleView];
 self.frontView.frame = self.frame;
 //            [self addBubbleAnimation];
 if (self.cleanMessageBlock) {
 self.cleanMessageBlock(YES);
 }
 }
 self.backView.bounds = self.frontView.bounds;
 self.backView.layer.cornerRadius = self.backView.frame.size.height * .5;
 [self.animationLayer removeFromSuperlayer];
 self.backView.hidden = YES;
 }
 }
 
 - (void)calculatePoint {
 
 circleA_Center = self.frontView.center;
 circleB_Center = self.backView.center;
 CGFloat x1 = circleA_Center.x;
 CGFloat y1 = circleA_Center.y;
 CGFloat x2 = circleB_Center.x;
 CGFloat y2 = circleB_Center.y;
 center_distance = sqrtf(powf(x1 - x2, 2) + powf(y1 - y2, 2));
 if (center_distance == 0) {
 sinValue = 0;
 cosValue = 1;
 } else {
 
 sinValue = (x2 - x1) / center_distance;
 cosValue = (y2 - y1) / center_distance;
 }
 
 radius_A = self.frontView.bounds.size.height * .5;
 radius_B = self.frontView.bounds.size.height * .5 - center_distance / self.decayCoefficent;
 
 point_A = CGPointMake(x1 - radius_A * cosValue, y1 + radius_A * sinValue);
 point_B = CGPointMake(x1 + radius_A * cosValue, y1 - radius_A * sinValue);
 point_C = CGPointMake(x2 - radius_B * cosValue, y2 + radius_B * sinValue);
 point_D = CGPointMake(x2 + radius_B * cosValue, y2 - radius_B * sinValue);
 controlPoint_AC = CGPointMake(point_C.x - center_distance * .5 * sinValue, point_C.y - center_distance * .5 * cosValue);
 controlPoint_BD = CGPointMake(point_D.x - center_distance * .5 * sinValue, point_D.y - center_distance * .5 * cosValue);
 UIBezierPath *shapePath = [UIBezierPath bezierPath];
 [shapePath moveToPoint:point_A];
 [shapePath addQuadCurveToPoint:point_C controlPoint:controlPoint_AC];
 [shapePath addLineToPoint:point_D];
 [shapePath addQuadCurveToPoint:point_B controlPoint:controlPoint_BD];
 [shapePath moveToPoint:point_A];
 [shapePath closePath];
 self.backView.bounds = CGRectMake(0, 0, radius_B * 2, radius_B * 2);
 self.backView.layer.cornerRadius = radius_B;
 
 self.animationLayer.path = shapePath.CGPath;
 self.animationLayer.fillColor = self.bubbleColor.CGColor;
 if (!self.backView.hidden) {
 [self.superview.layer addSublayer:self.animationLayer];
 }
 }
 
 - (void)setDecayCoefficent:(CGFloat)decayCoefficent {
 
 if (decayCoefficent > 1) {
 decayCoefficent = 1;
 }
 if (decayCoefficent < .05) {
 decayCoefficent = .03;
 }
 if (_decayCoefficent != decayCoefficent) {
 _decayCoefficent = decayCoefficent * 50;
 }
 }
 
 **/
