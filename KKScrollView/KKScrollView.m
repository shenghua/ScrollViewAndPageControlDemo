//
//  KKScrollView.m
//  ScrollViewAndPageControlDemo
//
//  Created by user on 14/9/10.
//  Copyright (c) 2014年 QTPay. All rights reserved.
//

#import "KKScrollView.h"

#define kkScrollViewPageNumber      3

@interface KKScrollView () <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *leftImageView;
@property (nonatomic, retain) UIImageView *middleImageView;
@property (nonatomic, retain) UIImageView *rightImageView;
@property (nonatomic, retain) NSMutableArray *imagesArray;

@end

@implementation KKScrollView

@synthesize scrollView, pageControl, leftImageView, middleImageView, rightImageView, imagesArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame images:(NSMutableArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        float pageWidth = CGRectGetWidth(frame);
        float pageHeight = CGRectGetHeight(frame);
        
        self.imagesArray = [NSMutableArray arrayWithArray:images];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.contentSize = CGSizeMake(pageWidth * kkScrollViewPageNumber, pageHeight);
        [self addSubview:scrollView];
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
        self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageWidth, 0, pageWidth, pageHeight)];
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageWidth * 2, 0, pageWidth, pageHeight)];
        
        [scrollView addSubview:leftImageView];
        [scrollView addSubview:middleImageView];
        [scrollView addSubview:rightImageView];
        
        [self loadPageWithId:(imagesArray.count - 1) onPage:0];
        [self loadPageWithId:0 onPage:1];
        [self loadPageWithId:1 onPage:2];
    }
    return self;
}

- (void)loadPageWithId:(NSUInteger)imageIndex onPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0:
            leftImageView.image = [imagesArray objectAtIndex:imageIndex];
            break;
            
        case 1:
            middleImageView.image = [imagesArray objectAtIndex:imageIndex];
            break;
            
        case 2:
            rightImageView.image = [imagesArray objectAtIndex:imageIndex];
            break;
            
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float offsetX = scrollView.contentOffset.x;
    if (offsetX)
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
