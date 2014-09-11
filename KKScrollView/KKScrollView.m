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
@property (nonatomic, assign) NSUInteger currentImageIndex;
@property (nonatomic, assign) NSUInteger nextImageIndex;
@property (nonatomic, assign) NSUInteger previousImageIndex;

@end

@implementation KKScrollView

@synthesize scrollView, pageControl, leftImageView, middleImageView, rightImageView, imagesArray, currentImageIndex, nextImageIndex, previousImageIndex;

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
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(pageWidth * kkScrollViewPageNumber, pageHeight);
        [self addSubview:scrollView];
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, pageHeight)];
        self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageWidth, 0, pageWidth, pageHeight)];
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageWidth * 2, 0, pageWidth, pageHeight)];
        
        [scrollView addSubview:leftImageView];
        [scrollView addSubview:middleImageView];
        [scrollView addSubview:rightImageView];
        
        currentImageIndex = 0;
        nextImageIndex = currentImageIndex + 1;
        previousImageIndex = imagesArray.count - 1;
        [self loadPageWithId:previousImageIndex onPage:0];
        [self loadPageWithId:currentImageIndex onPage:1];
        [self loadPageWithId:nextImageIndex onPage:2];
        
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
        
        _needAutoCycle = NO;
        _timeInterval = 1.0;
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.bounds.size.height - 20, scrollView.bounds.size.width, 20)];
        pageControl.numberOfPages = imagesArray.count;
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        pageControl.defersCurrentPageDisplay = YES;
        [pageControl addTarget:self action:@selector(pageControlValueDidChanged) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:pageControl];
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView
{
    if(scrollView.contentOffset.x > scrollView.frame.size.width)
    {
        // We are moving forward. Load the current doc data on the first page.
        [self loadPageWithId:currentImageIndex onPage:0];
        
        // Add one to the currentIndex or reset to 0 if we have reached the end.
        currentImageIndex = (currentImageIndex >=  imagesArray.count-1) ? 0 : currentImageIndex + 1;
        [self loadPageWithId:currentImageIndex onPage:1];
        
        // Load content on the last page. This is either from the next item in the array
        // or the first if we have reached the end.
        nextImageIndex = (currentImageIndex >= [imagesArray count]-1) ? 0 : currentImageIndex + 1;
        
        [self loadPageWithId:nextImageIndex onPage:2];
    }
    if(scrollView.contentOffset.x < scrollView.frame.size.width) {
        // We are moving backward. Load the current doc data on the last page.
        [self loadPageWithId:currentImageIndex onPage:2];
        
        // Subtract one from the currentIndex or go to the end if we have reached the beginning.
        currentImageIndex = (currentImageIndex == 0) ? [imagesArray count]-1 : currentImageIndex - 1;
        [self loadPageWithId:currentImageIndex onPage:1];
        
        // Load content on the first page. This is either from the prev item in the array
        // or the last if we have reached the beginning.
        previousImageIndex = (currentImageIndex == 0) ? [imagesArray count]-1 : currentImageIndex - 1;
        
        [self loadPageWithId:previousImageIndex onPage:0];
    }
    pageControl.currentPage = currentImageIndex;
    [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
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
    CGPoint contentOffSet = scrollView.contentOffset;
    contentOffSet.x = scrollView.bounds.size.width * 2;
    
    [scrollView setContentOffset:contentOffSet animated:YES];
    [self scrollViewDidEndDecelerating:scrollView];
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
