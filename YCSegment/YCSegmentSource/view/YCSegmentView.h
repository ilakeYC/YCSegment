//
//  YCSegmentView.h
//  YCSegment
//
//  Created by LakesMac on 16/4/14.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSegmentView : UIView

///非选中颜色
@property (nonatomic,strong) UIColor *normalColor;
///选中颜色
@property (nonatomic,strong) UIColor *highlightColor;
///字体
@property (nonatomic,strong) UIFont  *font;

- (instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray <UIViewController *> *)viewControllers;

@end
