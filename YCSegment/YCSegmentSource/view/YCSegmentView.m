//
//  YCSegmentView.m
//  YCSegment
//
//  Created by LakesMac on 16/4/14.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "YCSegmentView.h"
#import "YCSegmentItemsContentView.h"
#import "YCSegmentViewUnit.h"

@interface YCSegmentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YCSegmentItemsContentViewDelegate>
{
    NSArray *_viewControllers;
    CGFloat  _titleHeight;
}
@property (nonatomic,strong) UICollectionViewFlowLayout *cLayout;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) YCSegmentItemsContentView *titleView;

@end

@implementation YCSegmentView

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray<UIViewController *> *)viewControllers {
    
    if (self = [super initWithFrame:frame]) {
        _titleHeight = height;
        _viewControllers = viewControllers;
        [self setupAllViews];
    }
    return self;
}

- (void)setupAllViews {
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    for (UIViewController *vc in _viewControllers) {
        [titles addObject:vc.title];
    }
    
    self.titleView = [[YCSegmentItemsContentView alloc] initWithFrame:CGRectZero titles:titles];
    self.titleView.delegate = self;
    [self addSubview:self.titleView];
    
    self.cLayout = [[UICollectionViewFlowLayout alloc] init];
    self.cLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectZero) collectionViewLayout:self.cLayout];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YCSegmentViewUnit class] forCellWithReuseIdentifier:@"YCSegmentViewUnit"];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews {
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, _titleHeight);
    self.collectionView.frame = CGRectMake(0, _titleHeight, self.frame.size.width, self.frame.size.height - _titleHeight);
}




//**************************************************************************

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _viewControllers.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YCSegmentViewUnit * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YCSegmentViewUnit" forIndexPath:indexPath];
    UIViewController *vc = _viewControllers[indexPath.section];
    if (!vc.isViewLoaded) {
        [vc loadViewIfNeeded];
    }
    
    cell.view = vc.view;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (void)didSelectedButtonAtIndex:(NSInteger)index {
    CGFloat width = self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:(CGPointMake(width * index, 0)) animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGPoint offset = self.collectionView.contentOffset;
    CGFloat pageFloat = offset.x / self.collectionView.bounds.size.width + 0.5;
    if (pageFloat < 0) {
        pageFloat = 0;
    }
    if (pageFloat > _viewControllers.count) {
        pageFloat = _viewControllers.count;
    }
    NSInteger page = (NSInteger)pageFloat;
    self.titleView.page = page;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.titleView.normalColor = normalColor;
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    self.titleView.highlightColor = highlightColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleView.font = font;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
