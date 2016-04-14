//
//  YCSegmentItemsContentView.h
//  YCSegment
//
//  Created by LakesMac on 16/4/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSegmentViewTitleItem.h"

@protocol YCSegmentItemsContentViewDelegate;
@interface YCSegmentItemsContentView : UIView

@property (nonatomic,assign) id<YCSegmentItemsContentViewDelegate> delegate;

@property (nonatomic,assign) BOOL touching;

@property (nonatomic,assign) NSInteger page;

///非选中颜色
@property (nonatomic,strong) UIColor *normalColor;
///选中颜色
@property (nonatomic,strong) UIColor *highlightColor;
///字体
@property (nonatomic,strong) UIFont  *font;


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;



@end

@protocol YCSegmentItemsContentViewDelegate <NSObject>


- (void)didSelectedButtonAtIndex:(NSInteger)index;


@end