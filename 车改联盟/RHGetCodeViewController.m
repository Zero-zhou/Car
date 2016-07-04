//
//  RHGetCodeViewController.m
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHGetCodeViewController.h"
#import "RHResetPasswordViewController.h"
@interface RHGetCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *confiCode;

@end

@implementation RHGetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didClickConfrimAction:(id)sender {
    RHResetPasswordViewController *reSetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RHResetPasswordViewController"];
    [self.navigationController pushViewController:reSetVC animated:YES];
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
