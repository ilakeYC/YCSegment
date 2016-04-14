//
//  ViewController.m
//  YCSegment
//
//  Created by LakesMac on 16/3/28.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "ViewController.h"
#import "YCSegmentView.h"
#import "HomeViewController.h"
#import "RankViewController.h"
#import "MasterViewController.h"
#import "ChoicenessViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HomeViewController *vc1 = [[HomeViewController alloc] init];
    vc1.title = @"首页";
    
    RankViewController *vc2 = [[RankViewController alloc] init];
    vc2.title = @"榜单";
    
    MasterViewController *vc3 = [[MasterViewController alloc] init];
    vc3.title = @"达人";
    
    ChoicenessViewController *vc4 = [[ChoicenessViewController alloc] init];
    vc4.title = @"每周精选";
    
    
    YCSegmentView *view = [[YCSegmentView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) titleHeight:44 viewControllers:@[vc1, vc2, vc3, vc4]];
    view.highlightColor = [UIColor orangeColor];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
