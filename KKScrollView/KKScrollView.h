//
//  KKScrollView.h
//  ScrollViewAndPageControlDemo
//
//  Created by user on 14/9/10.
//  Copyright (c) 2014年 QTPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKScrollView : UIView

@property (nonatomic, retain) NSMutableArray *imagesArray;
@property (nonatomic, assign) BOOL needAutoCycle;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, copy) NSString *defaultImageName;
@property (nonatomic, retain) UIPageControl *pageControl;

- (id)initWithFrame:(CGRect)frame images:(NSMutableArray *)images autoCycle:(BOOL)autoCycle defaultImageName:(NSString *)defaultImageName;

- (void)refreshScrollView;

- (void)refreshScrollViewImages:(NSUInteger)currentIndex;

- (void)updateFrame;
@end
