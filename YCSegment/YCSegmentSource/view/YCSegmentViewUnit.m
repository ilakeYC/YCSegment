//
//  YCSegmentViewUnit.m
//  YCSegment
//
//  Created by LakesMac on 16/4/14.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "YCSegmentViewUnit.h"

@implementation YCSegmentViewUnit

- (void)setView:(UIView *)view {
    if (_view) {
        [_view removeFromSuperview];
    }
    [self.contentView addSubview:view];
    [self setNeedsLayout];
    _view = view;
}

- (void)layoutSubviews {
    self.view.frame = self.contentView.bounds;
}

@end
