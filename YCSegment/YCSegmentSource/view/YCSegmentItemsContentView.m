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
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedButtonAtIndex:)]) {
        [self.delegate didSelectedButtonAtIndex:index];
    }
}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (_scrollView == scrollView) {
        return;
    } else {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSInteger page = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    if (page < 0) {
        page = 0;
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
