//
//  RHGuideViewController.m
//  车改联盟
//
//  Created by zero on 16/6/29.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHGuideViewController.h"
#import "AppDelegate.h"
#define RH_SCREEN_BOUNDS [UIScreen mainScreen].bounds

@interface RHGuideViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *guideScrollview;
@property(nonatomic,strong) UIPageControl *guidePagecontrol;

@end

@implementation RHGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.guideScrollview = [[UIScrollView alloc]init];
    self.guideScrollview.frame = self.view.bounds;
    
    self.guideScrollview.contentSize = CGSizeMake(5*self.view.frame.size.width, 0);
    self.guideScrollview.bounces = NO;
    self.guideScrollview.pagingEnabled = YES;
    self.guideScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.guideScrollview];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *contentImageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        contentImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"文件%d.jpg",i + 1]];
        [self.guideScrollview addSubview:contentImageV];
        if (i == 5 - 1) {
            [self setUpLastImageView:contentImageV];
        }
    }
    self.guideScrollview.delegate = self;
    
    self.guidePagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height- 50, self.view.frame.size.width-40, 30)];
    self.guidePagecontrol.numberOfPages = 5;
    self.guidePagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.guidePagecontrol.userInteractionEnabled = NO;
    [self.view addSubview:self.guidePagecontrol];
    
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.guidePagecontrol.currentPage = self.guideScrollview.contentOffset.x / self.view.frame.size.width;
    
}

- (void)setUpLastImageView:(UIImageView *)imageView{
    imageView.userInteractionEnabled = YES;
    
    UIButton *startLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    startLoginBtn.frame = CGRectMake(50, self.view.frame.size.height - 90, self.view.frame.size.width - 100, 35);
    startLoginBtn.backgroundColor = [UIColor whiteColor];
    [startLoginBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    startLoginBtn.layer.cornerRadius = 5;
    startLoginBtn.clipsToBounds = YES;
    [startLoginBtn setTitle:@"开启程序" forState:UIControlStateNormal];
    [startLoginBtn addTarget:self action:@selector(didClickStartBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startLoginBtn];
}

- (void)didClickStartBtn{
    
    AppDelegate *tempDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
    tempDelegate.window.rootViewController = tempDelegate.LeftSlideVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
