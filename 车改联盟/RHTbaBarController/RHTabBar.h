//
//  RHTabBar.h
//  CYLTabBarController
//
//  Created by zero on 16/6/11.
//  Copyright © 2016年 微博@iOS程序犭袁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHTabBar : UITabBar

/*!
 * 让 `SwappableImageView` 垂直居中时，所需要的默认偏移量。
 * @attention 该值将在设置 top 和 bottom 时被同时使用，具体的操作等价于如下行为：
 * `viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);`
 */
@property (nonatomic, assign, readonly) CGFloat swappableImageViewDefaultOffset;

@end
