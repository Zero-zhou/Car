//
//  RHRegisterViewController.m
//  车改联盟
//
//  Created by zero on 16/6/18.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "RHRegisterViewController.h"

@interface RHRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addPhotoBtn;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addPhotoBtn.layer.borderWidth = 5;
    self.addPhotoBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didClickRegisterAction:(id)sender {
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
