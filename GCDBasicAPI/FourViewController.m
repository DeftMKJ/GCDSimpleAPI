//
//  FourViewController.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "FourViewController.h"
#import "ManagerHelper.h"
#import "FishHelper.h"
#import "SecondMSingleton.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@,%@",[ManagerHelper shareManager],[[ManagerHelper alloc] init]);
    
    NSLog(@"%@,%@",[FishHelper shareManager],[[FishHelper alloc] init]);
    
    NSLog(@"%@,%@",[SecondMSingleton shareInstance],[[SecondMSingleton alloc] init]);
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
