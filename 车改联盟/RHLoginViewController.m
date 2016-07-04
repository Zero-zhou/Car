//
//  RHLoginViewController.m
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHLoginViewController.h"
#import "RHRegisterViewController.h"
#import "RHGetCodeViewController.h"
@interface RHLoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *forgetpassLab;
@property (weak, nonatomic) IBOutlet UIButton *keepLoginBtn;
@end

@implementation RHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(7, 30, 35, 35);
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setImage:[UIImage imageNamed:@"night_icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
   // [self.keepLoginBtn setImage:[UIImage imageNamed:@"keepState"] forState:UIControlStateSelected];

       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (IBAction)didClickKeepAction:(id)sender {
    self.keepLoginBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"keepState"]];
}

- (IBAction)didClickForgetPassword:(id)sender {
    RHGetCodeViewController *getCodeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RHGetCodeViewController"];
    [self.navigationController pushViewController:getCodeVC animated:YES];
}

- (IBAction)didClickLoginAction:(id)sender {
    RHRegisterViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RHRegisterViewController"];
    [self.navigationController pushViewController:registerVC animated:YES];
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
