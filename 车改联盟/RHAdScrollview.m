//
//  RHAdScrollview.m
//  车改联盟
//
//  Created by zero on 16/7/4.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHAdScrollview.h"

#define Banner_StartTag     1000
#define Banner_RollingDelayTime 4

@interface RHAdScrollview ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) BOOL enableRolling;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger curPageIndex;

- (void)refreshScrollView;

- (NSInteger)getPageIndex:(NSInteger)index;
- (NSArray *)getDisplayImagesWithPageIndex:(NSInteger)pageIndex;


@end

@implementation RHAdScrollview

- (id)initWithFrame:(CGRect)frame scrollDirection:(LKBannerViewScrollDirection)direction images:(NSArray *)images{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //****************** Property *********
        self.imagesArray = [[NSArray alloc] initWithArray:images];
        self.scrollDirection = direction;
        self.totalPage = self.imagesArray.count;
        self.curPageIndex = 0;
        _rollingDelayTime = Banner_RollingDelayTime;
        //****************** Scroll View *********
        self.scrollView.scrollEnabled = self.totalPage != 1;
        // 在水平方向滚动
        if(self.scrollDirection == LKBannerViewScrollDirection_Landscape)
        {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3,
                                                     self.scrollView.frame.size.height);
        }
        // 在垂直方向滚动
        else if(self.scrollDirection == LKBannerViewScrollDirection_Portait)
        {
            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,
                                                     self.scrollView.frame.size.height * 3);
        }
        //向 Scroll View 添加 Image View
        for (NSInteger i = 0; i < 3; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.tag = Banner_StartTag+i;
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [imageView addGestureRecognizer:singleTap];
            
            // 水平滚动
            if(self.scrollDirection == LKBannerViewScrollDirection_Landscape)
            {
                imageView.frame = CGRectOffset(imageView.frame, self.scrollView.frame.size.width * i, 0);
            }
            // 垂直滚动
            else if(self.scrollDirection == LKBannerViewScrollDirection_Portait)
            {
                imageView.frame = CGRectOffset(imageView.frame, 0, self.scrollView.frame.size.height * i);
            }
            
            [self.scrollView addSubview:imageView];
        }
        [self addSubview:self.scrollView];
        
        //****************** Page Control *********
        [self setPageControlStyle:LKBannerViewPageStyle_Middle];
        self.pageControl.numberOfPages = self.totalPage;
        self.pageControl.currentPage = self.curPageIndex;
        [self addSubview:self.pageControl];
        
        [self refreshScrollView];
    }
    
    return self;
}

- (void)reloadBannerWithURLs:(NSArray *)imageUrls{
    self.imagesArray = [[NSArray alloc] initWithArray:imageUrls];
    self.totalPage = self.imagesArray.count;
    self.curPageIndex = 0;
    
    self.pageControl.numberOfPages = self.totalPage;
    self.pageControl.currentPage = self.curPageIndex;
    
    self.scrollView.scrollEnabled = self.totalPage != 1;
    
    [self refreshScrollView];
}

- (void)setSquare:(NSInteger)asquare{
    if (self.scrollView)
    {
        self.scrollView.layer.cornerRadius = asquare;
        if (asquare == 0)
        {
            self.scrollView.layer.masksToBounds = NO;
        }
        else
        {
            self.scrollView.layer.masksToBounds = YES;
        }
    }
}

- (void)setPageControlStyle:(LKBannerViewPageStyle)pageStyle{
    if (pageStyle == LKBannerViewPageStyle_Left)
    {
        [self.pageControl setFrame:CGRectMake(5, self.bounds.size.height-15, 60, 15)];
    }
    else if (pageStyle == LKBannerViewPageStyle_Right)
    {
        [self.pageControl setFrame:CGRectMake(self.bounds.size.width-5-60, self.bounds.size.height-15, 60, 15)];
    }
    else if (pageStyle == LKBannerViewPageStyle_Middle)
    {
        [self.pageControl setFrame:CGRectMake((self.bounds.size.width-60)/2, self.bounds.size.height-15, 60, 15)];
    }
    else if (pageStyle == LKBannerViewPageStyle_None)
    {
        [self.pageControl setHidden:YES];
    }
}

- (void)showClose:(BOOL)show{
    self.closeBtn.hidden = !show;
}

#pragma mark Rolling
- (void)startRolling{
    if (self.imagesArray.count <= 1) {
        return;
    }
    
    [self stopRolling];
    self.enableRolling = YES;
    [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:self.rollingDelayTime];
    
}
- (void)stopRolling{
    self.enableRolling = NO;
    //取消已加入的延迟线程
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(rollingScrollAction) object:nil];
}

- (void)rollingScrollAction
{
    [UIView animateWithDuration:0.25 animations:^{
        // 水平滚动
        if(self.scrollDirection == LKBannerViewScrollDirection_Landscape)
        {
            self.scrollView.contentOffset = CGPointMake(1.99*self.scrollView.frame.size.width, 0);
        }
        // 垂直滚动
        else if(self.scrollDirection == LKBannerViewScrollDirection_Portait)
        {
            self.scrollView.contentOffset = CGPointMake(0, 1.99*self.scrollView.frame.size.height);
        }
    } completion:^(BOOL finished) {
        self.curPageIndex = [self getPageIndex:self.curPageIndex+1];
        [self refreshScrollView];
        
        if (self.enableRolling)
        {
            [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:self.rollingDelayTime];
        }
    }];
}

#pragma mark - Event
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectImageView:withURL:)])
    {
        [self.delegate bannerView:self didSelectImageView:self.curPageIndex withURL:[self.imagesArray objectAtIndex:self.curPageIndex]];
    }
}
- (void)closeBanner
{
    [self stopRolling];
    
    if ([self.delegate respondsToSelector:@selector(bannerViewdidClosed:)])
    {
        [self.delegate bannerViewdidClosed:self];
    }
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    NSInteger x = aScrollView.contentOffset.x;
    NSInteger y = aScrollView.contentOffset.y;
    //NSLog(@"did  x=%d  y=%d", x, y);
    
    //取消已加入的延迟线程
    if (self.enableRolling)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(rollingScrollAction) object:nil];
    }
    
    // 水平滚动
    if(self.scrollDirection == LKBannerViewScrollDirection_Landscape)
    {
        // 往下翻一张
        if (x >= 2 * self.scrollView.frame.size.width)
        {
            self.curPageIndex = [self getPageIndex:self.curPageIndex+1];
            [self refreshScrollView];
        }
        
        if (x <= 0)
        {
            self.curPageIndex = [self getPageIndex:self.curPageIndex-1];
            [self refreshScrollView];
        }
    }
    // 垂直滚动
    else if(self.scrollDirection == LKBannerViewScrollDirection_Portait)
    {
        // 往下翻一张
        if (y >= 2 * self.scrollView.frame.size.height)
        {
            self.curPageIndex = [self getPageIndex:self.curPageIndex+1];
            [self refreshScrollView];
        }
        
        if (y <= 0)
        {
            self.curPageIndex = [self getPageIndex:self.curPageIndex-1];
            [self refreshScrollView];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    // 水平滚动
    if (self.scrollDirection == LKBannerViewScrollDirection_Landscape)
    {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    // 垂直滚动
    else if (self.scrollDirection == LKBannerViewScrollDirection_Portait)
    {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }
    
    if (self.enableRolling)
    {
        [self performSelector:@selector(rollingScrollAction) withObject:nil afterDelay:self.rollingDelayTime];
    }
}


#pragma mark - Private Method
- (NSInteger)getPageIndex:(NSInteger)index{
    if (index<0){
        index = self.totalPage - 1;
    }
    if (index == self.totalPage)
    {
        index = 0;
    }
    return index;
}

- (NSArray *)getDisplayImagesWithPageIndex:(NSInteger)pageIndex{
    
    NSInteger preIndex = [self getPageIndex:self.curPageIndex-1];
    NSInteger nextIndex = [self getPageIndex:self.curPageIndex+1];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    
    if (self.imagesArray.count > preIndex) {
        [images addObject:self.imagesArray[preIndex]];
    }
    if (self.imagesArray.count > self.curPageIndex) {
        [images addObject:self.imagesArray[self.curPageIndex]];
    }
    if (self.imagesArray.count > nextIndex) {
        [images addObject:self.imagesArray[nextIndex]];
    }
    
    return images;
}

- (void)refreshScrollView{
    NSArray *curImageUrls = [self getDisplayImagesWithPageIndex:self.curPageIndex];
    
    for (NSInteger i = 0; i < 3; i++)
    {
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:Banner_StartTag+i];
        NSString *url = curImageUrls.count > i ? curImageUrls[i] : nil;
        if (imageView && [imageView isKindOfClass:[UIImageView class]] && url)
        {
            //[imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        }
    }
    
    // 水平滚动
    if (self.scrollDirection == LKBannerViewScrollDirection_Landscape)
    {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    // 垂直滚动
    else if (self.scrollDirection == LKBannerViewScrollDirection_Portait)
    {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }
    
    self.pageControl.currentPage = self.curPageIndex;
}


#pragma mark - Init Property
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectNull];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}
- (UIButton *)closeBtn{
    if (!_closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setFrame:CGRectMake(self.bounds.size.width-40, 0, 40, 40)];
        [_closeBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [_closeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_closeBtn addTarget:self action:@selector(closeBanner) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:[UIImage imageNamed:@"banner_close"] forState:UIControlStateNormal];
        [self addSubview:_closeBtn];
    }
    return _closeBtn;
}


@end
