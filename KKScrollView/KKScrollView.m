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

@property (nonatomic, retain) UIScrollView *pageScrollView;
@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, retain) NSArray *imagesArray;
@property (nonatomic, retain) UIImageView *firstImageView;
@property (nonatomic, retain) UIImageView *secondImageView;
@property (nonatomic, retain) UIImageView *thirdImageView;
@property (nonatomic, assign) NSUInteger firstImageIndex;
@property (nonatomic, assign) NSUInteger secondImageIndex;
@property (nonatomic, assign) NSUInteger thirdImageIndex;

@end

@implementation KKScrollView

@synthesize pageScrollView, pageControl, imagesArray, firstImageView, secondImageView, thirdImageView ,firstImageIndex, secondImageIndex, thirdImageIndex;

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
        
        self.pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
        pageScrollView.delegate = self;
        pageScrollView.showsHorizontalScrollIndicator = NO;
        pageScrollView.showsVerticalScrollIndicator = NO;
        pageScrollView.backgroundColor = [UIColor clearColor];
        pageScrollView.pagingEnabled = YES;
        pageScrollView.contentSize = CGSizeMake(pageWidth * kkScrollViewPageNumber, pageHeight);
        [self addSubview:pageScrollView];
        
        self.firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
        self.secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageWidth, 0, pageWidth, pageHeight)];
        self.thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageWidth * 2, 0, pageWidth, pageHeight)];
        
        [pageScrollView addSubview:firstImageView];
        [pageScrollView addSubview:secondImageView];
        [pageScrollView addSubview:thirdImageView];
        
        [self refreshScrollViewImages:0];
        
        _needAutoCycle = NO;
        _timeInterval = 1.5;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageScrollView.bounds.size.height - 10, pageScrollView.bounds.size.width, 10)];
        pageControl.numberOfPages = imagesArray.count;
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        pageControl.defersCurrentPageDisplay = YES;
//        [pageControl addTarget:self action:@selector(pageControlValueDidChanged) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:pageControl];
    }
    return self;
}

- (void)loadPageWithId:(NSUInteger)imageIndex onPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0:
            firstImageView.image = [imagesArray objectAtIndex:imageIndex];
            break;
            
        case 1:
            secondImageView.image = [imagesArray objectAtIndex:imageIndex];
            break;
            
        case 2:
            thirdImageView.image = [imagesArray objectAtIndex:imageIndex];
            break;
            
        default:
            break;
    }
}

// 根据数组当前index 获取下一个index
- (NSUInteger)getNextIndexOfArray:(NSArray *)array by:(NSUInteger)currentIndex
{
    NSUInteger nextIndex;
    if (currentIndex < array.count - 1)
        nextIndex = ++currentIndex;
    else
        nextIndex = 0;
    
    return nextIndex;
}

// 根据数组当前index 获取上一个index
- (NSUInteger)getPreviousIndexOfArray:(NSArray *)array by:(NSUInteger)currentIndex
{
    NSUInteger previousIndex;
    if (currentIndex > 0)
        previousIndex = --currentIndex;
    else
        previousIndex = array.count - 1;
    return previousIndex;
}

- (void)refreshScrollViewImages:(NSUInteger)currentIndex
{
    secondImageIndex = currentIndex;
    firstImageIndex = [self getPreviousIndexOfArray:imagesArray by:secondImageIndex];
    thirdImageIndex = [self getNextIndexOfArray:imagesArray by:secondImageIndex];
    [self loadPageWithId:firstImageIndex onPage:0];
    [self loadPageWithId:secondImageIndex onPage:1];
    [self loadPageWithId:thirdImageIndex onPage:2];
    
    self.pageControl.currentPage = secondImageIndex;
    [self.pageScrollView setContentOffset:CGPointMake(pageScrollView.bounds.size.width, 0)];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x;
    
    if (x > (scrollView.frame.size.width + scrollView.frame.size.width / 2))
        self.pageControl.currentPage = [self getNextIndexOfArray:imagesArray by:secondImageIndex];
    else if (x < scrollView.frame.size.width / 2)
        self.pageControl.currentPage = [self getPreviousIndexOfArray:imagesArray by:secondImageIndex];
    else
        self.pageControl.currentPage = secondImageIndex;
    
    // new page
    if (x >= (2 * scrollView.frame.size.width)) {
        [self refreshScrollViewImages:[self getNextIndexOfArray:imagesArray by:secondImageIndex]];
    }
    // previous page
    else if (x <= 0) {
        [self refreshScrollViewImages:[self getPreviousIndexOfArray:imagesArray by:secondImageIndex]];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (_needAutoCycle) {
        NSTimer *cycleScrollViewTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(autoCycleScrollView) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:cycleScrollViewTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)autoCycleScrollView
{
    CGPoint rightOffset = CGPointMake(pageScrollView.contentSize.width - pageScrollView.bounds.size.width, pageScrollView.contentOffset.y);
    [pageScrollView setContentOffset:rightOffset animated:YES];
}

- (void)pageControlValueDidChanged
{
    NSLog(@"1");
}

- (void)updateCurrentPageDisplay
{
    NSLog(@"2");
}

@end
