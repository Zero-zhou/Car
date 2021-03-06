//
//  RHMainViewController.m
//  车改联盟
//
//  Created by zero on 16/6/19.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHMainViewController.h"
#import "RHLoginViewController.h"
#import "AppDelegate.h"
#import "RHAdScrollview.h"
@interface RHMainViewController ()<RHBannerViewDelegate>

@end

@implementation RHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backImage.image = [UIImage imageNamed:@"loginBaseBackImg"];
    [self.view addSubview:backImage];
    [self.view sendSubviewToBack:backImage];

    AppDelegate *tempAppdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tempAppdelegate.mainNavigationController.navigationBar.tintColor = [UIColor clearColor];
    tempAppdelegate.mainNavigationController.navigationBar.translucent = YES;
    tempAppdelegate.mainNavigationController.navigationBar.alpha = 0;
    
    RHAdScrollview *adView = [[RHAdScrollview alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30) scrollDirection:LKBannerViewScrollDirection_Landscape imagesArray:nil titlesArray:@[@"我化尘埃飞扬",@"追寻赤裸回翔",@"我欲乘风破浪",@"踏破黄沙海洋"]];
    adView.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:1.000 alpha:1.000];
    [adView setPageControlStyle:LKBannerViewPageStyle_None];
    [adView startRolling];
    adView.delegate = self;
    [self.view addSubview:adView];
    //[tempAppdelegate.mainNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bannerView:(RHAdScrollview *)bannerView didSelectIndex:(NSInteger)index withURL:(NSString *)imageURL{
    NSLog(@"%ld %@",index,imageURL);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
        RHLoginViewController *loginVC = [UIStoryboard storyboardWithName:@"LoginSB" bundle:[NSBundle mainBundle]].instantiateInitialViewController;
        [self presentViewController:loginVC animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
