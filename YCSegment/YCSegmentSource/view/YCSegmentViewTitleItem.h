//
//  YCSegmentViewTitleItem.h
//  YCSegment
//
//  Created by LakesMac on 16/3/28.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSegmentViewTitleItem : UIView

///标题
@property (nonatomic,copy) NSString  *title;
///非选中颜色
@property (nonatomic,strong) UIColor *normalColor;
///选中颜色
@property (nonatomic,strong) UIColor *highlightColor;
///字体
@property (nonatomic,strong) UIFont  *font;
///间距
@property (nonatomic,assign) CGFloat  space;
///高亮
@property (nonatomic,assign) BOOL     highlight;

///不知道是什么
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;

///添加点击事件
- (void)addTarget:(id)target action:(SEL)action;

///计算宽度
+ (CGFloat)calcuWidth:(NSString *)title;

@end
