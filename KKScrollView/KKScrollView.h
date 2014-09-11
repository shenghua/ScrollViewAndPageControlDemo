//
//  KKScrollView.h
//  ScrollViewAndPageControlDemo
//
//  Created by user on 14/9/10.
//  Copyright (c) 2014年 QTPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKScrollView : UIView

@property (nonatomic, assign) BOOL needAutoCycle;
@property (nonatomic, assign) NSTimeInterval timeInterval;

- (id)initWithFrame:(CGRect)frame images:(NSMutableArray *)images;

@end
