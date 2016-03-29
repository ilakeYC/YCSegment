//
//  ViewController.m
//  YCSegment
//
//  Created by LakesMac on 16/3/28.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "ViewController.h"
#import "YCSegmentViewTitleItem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YCSegmentViewTitleItem *item = [[YCSegmentViewTitleItem alloc] initWithFrame:(CGRectMake(0, 0, 100, 50)) title:@"测试一aaaaaaaaa下"];
    [self.view addSubview:item];
    
    [item addTarget:self action:@selector(touchAction:)];
    
}

- (void)touchAction:(YCSegmentViewTitleItem *)sender {
    sender.heiglight = !sender.heiglight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
