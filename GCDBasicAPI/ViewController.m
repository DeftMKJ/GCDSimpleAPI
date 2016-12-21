//
//  ViewController.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *names = @[@"GCD同步异步串行并发基本函数",@"最基本的线程通信",@"Barrier,Apply,After,Group其他常用函数",@"实现单例的两种方法"];
    CGFloat height = floor(([UIScreen mainScreen].bounds.size.height - 64) / 7);
    for (NSInteger i = 0; i < 4; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:names[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:random() % 255 / 255.0 green:random() % 255 / 255.0 blue:random() % 255 / 255.0 alpha:1]];
        button.tag = 1000+i;
        button.frame = CGRectMake(0, 64 + i * height, [UIScreen mainScreen].bounds.size.width, height);
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)touchButton:(UIButton *)button
{
    switch (button.tag - 1000) {
        case 0:
        {
            FirstViewController *fv = [[FirstViewController alloc] init];
            [self.navigationController pushViewController:fv animated:YES];
        }
            break;
        case 1:
        {
            SecondViewController *sv = [[SecondViewController alloc] init];
            [self.navigationController pushViewController:sv animated:YES];
        }
            break;
        case 2:
        {
            ThreeViewController *tv = [[ThreeViewController alloc] init];
            [self.navigationController pushViewController:tv animated:YES];
        }
            break;
        case 3:
        {
            FourViewController *fourv = [[FourViewController alloc] init];
            [self.navigationController pushViewController:fourv animated:YES];
        }
            break;
//        case 4:
//        {
//            FiveViewController *fiveV = [[FiveViewController alloc] init];
//            [self.navigationController pushViewController:fiveV animated:YES];
//        }
//            break;
//        case 5:
//        {
//            SixViewController *sixV = [[SixViewController alloc] init];
//            [self.navigationController pushViewController:sixV animated:YES];
//        }
//            break;
//        case 6:
//        {
//            SevenViewController *sevenV = [[SevenViewController alloc] init];
//            [self.navigationController pushViewController:sevenV animated:YES];
//        }
//            break;
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
