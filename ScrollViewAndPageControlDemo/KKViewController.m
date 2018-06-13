//
//  KKViewController.m
//  ScrollViewAndPageControlDemo
//
//  Created by user on 14/9/10.
//  Copyright (c) 2014年 QTPay. All rights reserved.
//

#import "KKViewController.h"
#import "KKScrollView.h"

@interface KKViewController ()

@property (nonatomic, retain) KKScrollView *scrollView;

@end

@implementation KKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [[KKScrollView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 258.8 / 2) images:nil autoCycle:YES defaultImageName:nil];
    
    
    self.scrollView.imagesArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"main_banner_1"], [UIImage imageNamed:@"main_banner_2"], [UIImage imageNamed:@"main_banner_3"],[UIImage imageNamed:@"main_banner_3"],nil];
    [self.scrollView refreshScrollView];
    //    [self.scrollView refreshScrollViewImages:self.item.currentPageIndex];
    
    //    _scrollView.needAutoCycle = YES;
    //    _scrollView.timeInterval = 1.0;
    
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
