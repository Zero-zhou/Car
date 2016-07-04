//
//  AppDelegate.h
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNavigationController;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;

@end

