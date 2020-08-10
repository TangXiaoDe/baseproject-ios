//
//  CWAIMIndexBar.m
//  CubeWare
//
//  Created by Mario on 17/4/7.
//  Copyright © 2017年 shixinyun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CWAIMIndexBar.h"

#if !__has_feature(objc_arc)
#error AIMTableViewIndexBar must be built with ARC.
// You can turn on ARC for only AIMTableViewIndexBar files by adding -fobjc-arc to the build phase for each of its files.
#endif

@interface CWAIMIndexBar (){
    BOOL isLayedOut;
    NSArray *letters;
    CAShapeLayer *shapeLayer;
    CALayer *imageLayer;
    CATextLayer *imageTextLayer;
    CGFloat letterHeight;
}
@end

@implementation CWAIMIndexBar

@synthesize indexes, delegate;

- (id)init{
    if (self = [super init]){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (void)setup{
    letters = @[@"↑", @"A", @"B", @"C",
                @"D", @"E", @"F", @"G",
                @"H", @"I", @"J", @"K",
                @"L", @"M", @"N", @"O",
                @"P", @"Q", @"R", @"S",
                @"T", @"U", @"V", @"W",
                @"X", @"Y", @"Z",@"#"];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.layer.masksToBounds = NO;
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = CGRectMake(0, 0, 60, 60);
    image.image = [UIImage imageNamed:@"IMG_indexBar"];
    image.contentMode = UIViewContentModeScaleAspectFit;
    imageLayer = image.layer;
    
    imageTextLayer = [self textLayerWithSize:20
                                        string:@""
                                      andFrame:CGRectMake(15, 20, 20, 20)];
    [imageTextLayer setForegroundColor:[UIColor whiteColor].CGColor];
    [imageLayer addSublayer:imageTextLayer];
}

- (void)setIndexes:(NSArray *)idxs{
    indexes = idxs;
    letters = idxs;
    isLayedOut = NO;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!isLayedOut && indexes.count != 0)
    {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        shapeLayer = nil;
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.frame = (CGRect) {.origin = CGPointZero, .size = self.layer.frame.size};

        shapeLayer.frame = CGRectMake(0, self.layer.frame.size.height/2 - indexes.count * 20 / 2, self.layer.frame.size.width,indexes.count * 20);
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        letterHeight = 20;
        CGFloat fontSize = 12;
        if (letterHeight < 14){
            fontSize = 10;
        }
        [letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * letterHeight;
            CATextLayer *ctl = [self textLayerWithSize:fontSize
                                                string:letter
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, letterHeight)];
            [shapeLayer addSublayer:ctl];
            [bezierPath moveToPoint:CGPointMake(shapeLayer.frame.origin.y, originY )];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        isLayedOut = YES;
    }
}

- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *tl = [CATextLayer layer];
    [tl setFont:@"ArialMT"];
    [tl setFontSize:size];
    [tl setFrame:frame];
    [tl setAlignmentMode:kCAAlignmentCenter];
    [tl setContentsScale:[[UIScreen mainScreen] scale]];
    [tl setForegroundColor:[[UIColor colorWithRed:140/255.0 green:151/255.0 blue:172/255.0 alpha:1] CGColor]];
    [tl setString:string];
    return tl;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self sendEventToDelegate:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self sendEventToDelegate:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [imageLayer removeFromSuperlayer];
}

- (void)sendEventToDelegate:(UIEvent*)event{

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < shapeLayer.frame.origin.y || point.y > (shapeLayer.frame.origin.y + shapeLayer.frame.size.height)) {
        //没有选择字母区域
        [imageLayer removeFromSuperlayer];
        return;
    }
    
    NSInteger indx = (NSInteger) floorf(fabs(point.y - shapeLayer.frame.origin.y) / letterHeight);
    //(point.y-40)
    indx = indx < [letters count] ? indx : [letters count] - 1;
    //点击颜色
    [self animateLayerAtIndex:indx];
    __block NSInteger scrollIndex;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, indx + 1)];//原来indx+1
    [letters enumerateObjectsAtIndexes:indexSet options:NSEnumerationReverse usingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
        scrollIndex = [indexes indexOfObject:letter];
        *stop = scrollIndex != NSNotFound;
    }];
    if (nil != delegate && [delegate respondsToSelector:@selector(tableViewIndexBar:didSelectSectionAtIndex:)])
    {
        [delegate tableViewIndexBar:self didSelectSectionAtIndex:scrollIndex];
    }
    
    if (!imageLayer.superlayer) {
        [self.layer addSublayer:imageLayer];
    }
    [imageTextLayer setString:indexes[scrollIndex]];
    imageLayer.frame = CGRectMake(-100, shapeLayer.frame.origin.y + scrollIndex*20 - 30, 60, 60);
    
}

- (void)animateLayerAtIndex:(NSInteger)index{
    
    if ([self.layer.sublayers count] - 1 > index){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        animation.toValue = (id)[[UIColor clearColor] CGColor];
        [self.layer.sublayers[index] addAnimation:animation forKey:@"myAnimation"];
    }
}

@end
