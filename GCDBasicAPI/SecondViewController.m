//
//  SecondViewController.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 不阻塞当前线程，后台拉取图片资源
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRCfHVwGXGvrpCBplQieSKsLgfBULL8ZZXSzosPFdoZsvjDlqnOrKK_w58"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"获取资源%@",[NSThread currentThread]);
        // 下载完之后回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            NSLog(@"加载资源%@",[NSThread currentThread]);
        });
    });
    
    //    2016-12-21 09:43:51.675 GCDBasicAPI[1237:45972] 获取资源<NSThread: 0x6000002742c0>{number = 3, name = (null)}
    //    2016-12-21 09:43:51.676 GCDBasicAPI[1237:45929] 加载资源<NSThread: 0x60000007b680>{number = 1, name = main}
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
