//
//  YCSegmentItemsContentView.m
//  YCSegment
//
//  Created by LakesMac on 16/4/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "YCSegmentItemsContentView.h"

@interface YCSegmentItemsContentView ()
{
    CGFloat _buttonWidthSUM;
    YCSegmentViewTitleItem *_currentItem;
}
@property (nonatomic,strong) UIView *buttonContentView;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) NSMutableArray *buttonsArray;
@property (nonatomic,strong) NSMutableArray *buttonWidths;
@property (nonatomic,strong) NSArray *items;

@end

@implementation YCSegmentItemsContentView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles {
    if (self = [super initWithFrame:frame]) {
        self.items = [titles copy];
        [self setupAllButtons];
    }
    return self;
}

- (void)setupAllButtons {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.buttonContentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.buttonContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttonContentView];
    self.line = [[UIView alloc] initWithFrame:CGRectZero];
    self.line.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.line];
    
    for (NSString *title in self.items) {
        YCSegmentViewTitleItem *item = [[YCSegmentViewTitleItem alloc] initWithFrame:(CGRectZero) title:title];
        CGFloat width = [YCSegmentViewTitleItem calcuWidth:title];
        [self.buttonsArray addObject:item];
        [item addTarget:self action:@selector(buttonAction:)];
        [self.buttonWidths addObject:[NSNumber numberWithDouble:width]];
        _buttonWidthSUM += width;
        [self.buttonContentView addSubview:item];
        if (_currentItem == nil) {
            _currentItem = item;
            item.highlight = YES;
        }
    }
}

- (void)layoutSubviews {
    
    CGFloat height = self.bounds.size.height;
    CGFloat width  = self.bounds.size.width;
    
    self.buttonContentView.frame = CGRectMake(0, 0, width, height - 2);
    
    CGFloat spacing = 0;
    if (_buttonWidthSUM >= width) {
        spacing = 0;
    } else {
        spacing = (width - _buttonWidthSUM) / (_buttonWidths.count + 1);
    }
    for (int x = 0; x < self.buttonsArray.count; x++) {
        YCSegmentViewTitleItem *item = self.buttonsArray[x];
        CGFloat buttonWidth = [self.buttonWidths[x] doubleValue];
        if (x == 0) {
            item.frame = CGRectMake(spacing, 0, buttonWidth, _buttonContentView.bounds.size.height);
        } else {
            YCSegmentViewTitleItem *lastItem = self.buttonsArray[x - 1];
            item.frame = CGRectMake(spacing + lastItem.frame.origin.x + lastItem.frame.size.width, 0, buttonWidth, _buttonContentView.bounds.size.height);
        }
    }
    self.line.frame = CGRectMake(_currentItem.frame.origin.x, self.buttonContentView.bounds.size.height, _currentItem.bounds.size.width, 2);
}

- (void)buttonAction:(YCSegmentViewTitleItem *)sender {
    NSInteger index = [self.buttonsArray indexOfObject:sender];
    [self setPage:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedButtonAtIndex:)]) {
        [self.delegate didSelectedButtonAtIndex:index];
    }
}

- (void)setPage:(NSInteger)page {
    if (_page == page) {
        return;
    }
    _page = page;
    [self moveToPage:page];
}

- (void)moveToPage:(NSInteger)page {
    if (page > self.buttonsArray.count) {
        return;
    }
    YCSegmentViewTitleItem *item = self.buttonsArray[page];
    _currentItem.highlight = NO;
    _currentItem = item;
    item.highlight = YES;
    [UIView animateWithDuration:0.2 animations:^{
        CGRect buttonFrame = item.frame;
        CGRect lineFrame = self.line.frame;
        lineFrame.origin.x = buttonFrame.origin.x;
        lineFrame.size.width = buttonFrame.size.width;
        self.line.frame = lineFrame;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}

- (void)setNormalColor:(UIColor *)normalColor {
    if (_normalColor == normalColor) {
        return;
    }
    _normalColor = normalColor;
    for (YCSegmentViewTitleItem *item in self.buttonsArray) {
        item.normalColor = normalColor;
    }
}
- (void)setHighlightColor:(UIColor *)highlightColor {
    if (_highlightColor == highlightColor) {
        return;
    }
    _highlightColor = highlightColor;
    self.line.backgroundColor = highlightColor;
    for (YCSegmentViewTitleItem *item in self.buttonsArray) {
        item.highlightColor = highlightColor;
    }
}

- (void)setFont:(UIFont *)font {
    if (_font == font) {
        return;
    }
    for (YCSegmentViewTitleItem *item in self.buttonsArray) {
        item.font = font;
    }
}

- (NSMutableArray *)buttonsArray{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (NSMutableArray *)buttonWidths{
    if (!_buttonWidths) {
        _buttonWidths = [NSMutableArray array];
    }
    return _buttonWidths;
}
@end
