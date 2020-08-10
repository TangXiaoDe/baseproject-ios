//
//  HQImagePageControl.m
//  HQCardFlowView
//
//  Created by HQ on 2018/7/24.
//  Copyright © 2018年 HQ. All rights reserved..
//

#import "HQImagePageControl.h"

@implementation HQImagePageControl

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    activeImage = [UIImage imageNamed:@"IMG_icon_pageControl_selected"];
    inactiveImage = [UIImage imageNamed:@"IMG_icon_pageControl_normal"] ;
    
    return self;
}
-(UIImage*) createImageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView *vi = [self.subviews objectAtIndex:i];
        
        //添加imageView
        if ([vi.subviews count] == 0) {
            UIImageView * view = [[UIImageView alloc]initWithFrame:vi.bounds];
            [vi addSubview:view];
        };
        
        //配置imageView
        UIImageView * view = vi.subviews[0];
        
        if (i == self.currentPage) {
            view.bounds = CGRectMake(0, 0, 7, 7);
            view.image = activeImage;
        } else {
            view.image = inactiveImage;
            view.bounds = CGRectMake(0, 0, 5, 5);
        }
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    //修改图标大小
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 7;
        
        size.width = 7;
        
        subview.backgroundColor = [UIColor clearColor];
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
        
    }
    
    
    [self updateDots];
}

@end
