//
//  CWAIMIndexBar.h
//  CubeWare
//
//  Created by Mario on 17/4/7.
//  Copyright © 2017年 shixinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CWAIMIndexBar;

@protocol CWAIMTableViewIndexBarDelegate <NSObject>

- (void)tableViewIndexBar:(CWAIMIndexBar*)indexBar didSelectSectionAtIndex:(NSInteger)index;

@end

@interface CWAIMIndexBar : UIView

@property (nonatomic, strong) NSArray *indexes;

@property (nonatomic, weak) id <CWAIMTableViewIndexBarDelegate> delegate;

@end
