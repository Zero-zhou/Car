//
//  RHAdScrollview.h
//  车改联盟
//
//  Created by zero on 16/7/4.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RHScrollviewType) {
    RHScrollviewType_images,
    RHScrollviewType_titles
};

typedef NS_ENUM(NSInteger, RHBannerViewScrollDirection)
{
    /// 水平滚动
    LKBannerViewScrollDirection_Landscape,
    /// 垂直滚动
    LKBannerViewScrollDirection_Portait
};

///Page Control 位置
typedef NS_ENUM(NSInteger, RHBannerViewPageStyle)
{
    LKBannerViewPageStyle_None,
    LKBannerViewPageStyle_Left,
    LKBannerViewPageStyle_Right,
    LKBannerViewPageStyle_Middle
};

@protocol  RHBannerViewDelegate;
@interface RHAdScrollview : UIView

@property(nonatomic, assign) RHScrollviewType scrollviewType;

// 存放所有需要滚动的内容
@property (nonatomic, strong) NSArray *contentArray;
// scrollView滚动的方向
@property (nonatomic, assign) RHBannerViewScrollDirection scrollDirection;
// 每条显示时间
@property (nonatomic, assign) NSTimeInterval rollingDelayTime;
@property (nonatomic, weak) id <RHBannerViewDelegate> delegate;

///请使用该函数初始化
- (id)initWithFrame:(CGRect)frame scrollDirection:(RHBannerViewScrollDirection)direction imagesArray:(NSArray *)images titlesArray:(NSArray *)titles;

///重新设置 imageUrls
- (void)reloadBannerWithURLs:(NSArray *)contentUrls;
///设置 Banner 圆角显示
- (void)setSquare:(NSInteger)asquare;
///设置 Banner 样式，默认PageControl居中
- (void)setPageControlStyle:(RHBannerViewPageStyle)pageStyle;
///设置是否显示关闭按钮，默认不显示
- (void)showClose:(BOOL)show;

///开起自动滚动 ， 默认不开始自动滚动，请手动开启
- (void)startRolling;
- (void)stopRolling;


@end

@protocol RHBannerViewDelegate <NSObject>

@optional
///点击图片
- (void)bannerView:(RHAdScrollview *)bannerView didSelectIndex:(NSInteger)index withURL:(NSString *)imageURL;
///点击关闭按钮
- (void)bannerViewdidClosed:(RHAdScrollview *)bannerView;

@end

