//
//  BubbleDrawTestView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/10/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class BubbleDrawTestView: UIView
{
    
    // MARK: - Internal Property
    
    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }
    
    
    // MARK: - Private Property
    
    fileprivate let mainView: UIView = UIView()
    fileprivate var pointB: CGPoint = CGPoint.init(x: 20, y: 20)
    fileprivate var radiusB: CGFloat = 15
    
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
extension BubbleDrawTestView {
    class func loadXib() -> BubbleDrawTestView? {
        return Bundle.main.loadNibNamed("BubbleDrawTestView", owner: nil, options: nil)?.first as? BubbleDrawTestView
    }
}

// MARK: - LifeCircle Function
extension BubbleDrawTestView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
    
    /// 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 绘图
        // 绘图1：两个圆形 + 两条直线
        // 绘图2：2个弧形 + 两条直线
        // 绘图3：2个弧形 + 两条弧线
        
        // 1.获取上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        // 绘图1：
        //self.drawWay1(context: context, rect: rect)
        // 绘图2：
        
        let pointA: CGPoint = CGPoint.init(x: rect.size.width * 0.5, y: rect.size.height * 0.5)
        let radiusA: CGFloat = 5
        let pointB: CGPoint = self.pointB
        let radiusB: CGFloat = self.radiusB
        let points = self.getTwoCirclesTangentPoints(pointA: pointA, radiusA: radiusA, pointB: pointB, radiusB: radiusB)
        let path = UIBezierPath.init()
        // 1. 半圆1
        path.addArc(withCenter: pointA, radius: radiusA, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        // 2. 切线1
        
        // 3. 半圆2
        path.addArc(withCenter: pointB, radius: radiusB, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI) * 2.0, clockwise: true)
        // 4. 切线2
        
        path.close()
        // 渲染
        path.stroke()
        
        
        
        
    }
    
    // 绘图1：两个圆形 + 两条直线
    fileprivate func drawWay1(context: CGContext, rect: CGRect) -> Void {
        // 1. 圆形1
        let pointA: CGPoint = CGPoint.init(x: rect.size.width * 0.5, y: rect.size.height * 0.5)
        let radiusA: CGFloat = 5
        context.addEllipse(in: CGRect.init(x: pointA.x - radiusA, y: pointA.y - radiusA, width: radiusA * 2.0, height: radiusA * 2.0))
        // 2. 圆形2
        let pointB: CGPoint = self.pointB
        let radiusB: CGFloat = self.radiusB
        context.addEllipse(in: CGRect.init(x: pointB.x - radiusB, y: pointB.y - radiusB, width: radiusB * 2.0, height: radiusB * 2.0))
        
        // 两圆切点
        let points = self.getTwoCirclesTangentPoints(pointA: pointA, radiusA: radiusA, pointB: pointB, radiusB: radiusB)
        // 3. 线条1
        context.move(to: points.tangentPointA1)
        context.addLine(to: points.tangentPointB1)
        // 4. 线条2
        context.move(to: points.tangentPointA2)
        context.addLine(to: points.tangentPointB2)
        
        // 渲染
        context.strokePath()
    }
    
    // 绘图2：2个弧形 + 两条直线
    fileprivate func drawWay2(context: CGContext, rect: CGRect) -> Void {
        
    }

    // 绘图3：2个弧形 + 两条弧线
    fileprivate func drawWay3(context: CGContext, rect: CGRect) -> Void {
        
    }
    
    


}
// MARK: - Private UI 手动布局
extension BubbleDrawTestView {
    
    /// 界面布局
    fileprivate func initialUI() -> Void {

    }
    
}
// MARK: - Private UI Xib加载后处理
extension BubbleDrawTestView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {
        
    }
}

// MARK: - Data Function
extension BubbleDrawTestView {
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let _ = model else {
            return
        }
        // 子控件数据加载
    }
    
}

// MARK: - Event Function
extension BubbleDrawTestView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        self.pointB = point
        self.setNeedsDisplay()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        self.pointB = point
        self.setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}

// MARK: - Extension Function
extension BubbleDrawTestView {
    
    // 获取两点之间的间距 - 圆心距
    fileprivate func getDistanceWith(pointA: CGPoint, pointB: CGPoint) -> CGFloat {
        let offsetX: CGFloat = pointA.x - pointB.x
        let offsetY: CGFloat = pointA.y - pointB.y
        let offset: CGFloat = sqrt(offsetX * offsetX + offsetY * offsetY)
        return offset
    }
    
    /// 已知两圆的圆心和半径，求两圆的正切点
    func getTwoCirclesTangentPoints(pointA: CGPoint, radiusA: CGFloat, pointB: CGPoint, radiusB: CGFloat) -> (tangentPointA1: CGPoint, tangentPointB1: CGPoint, tangentPointA2: CGPoint, tangentPointB2: CGPoint) {
        
        // 圆A中心
        let x1: CGFloat = pointA.x
        let y1: CGFloat = pointA.y
        let r1: CGFloat = radiusA
        
        // 圆B中心
        let x2: CGFloat = pointB.x
        let y2: CGFloat = pointB.y
        let r2: CGFloat = radiusB
        
        // 获取三角函数
        let d: CGFloat = self.getDistanceWith(pointA: pointA, pointB: pointB)
        let sinA: CGFloat = (y2 - y1) / d
        let cosA: CGFloat = (x2 - x1) / d
        
        // 获取2根切线上的4个点
        let tangentPointA: CGPoint = CGPoint.init(x: x1 - r1 * sinA, y: y1 + r1 * cosA)
        let tangentPointB: CGPoint = CGPoint.init(x: x1 + r1 * sinA, y: y1 - r1 * cosA)
        let tangentPointC: CGPoint = CGPoint.init(x: x2 + r2 * sinA, y: y2 - r2 * cosA)
        let tangentPointD: CGPoint = CGPoint.init(x: x2 - r2 * sinA, y: y2 + r2 * cosA)
        
        // 获取2根切线上的控制点，以便画曲线
        //let pointO: CGPoint = CGPoint.init(x: tangentPointA.x + d * 0.5 * cosA, y: tangentPointA.y + d * 0.5 * sinA)
        //let pointP: CGPoint = CGPoint.init(x: tangentPointB.x + d * 0.5 * cosA, y: tangentPointB.y + d * 0.5 * sinA)

        // result
        let result = (tangentPointA1: tangentPointA, tangentPointB1: tangentPointD, tangentPointA2: tangentPointB, tangentPointB2: tangentPointC)
        return result
    }
    
}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension BubbleDrawTestView {
    
}


