//
//  ThreeViewController.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) UIImage *image1;
@property (nonatomic,strong) UIImage *image2;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self group];
}
/*
 *  线程组  实现多个请求完成之后同时刷新UI的问题
 */

- (void)group
{
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.mkj.hh", DISPATCH_QUEUE_CONCURRENT);
    // 线程组
    dispatch_group_t group = dispatch_group_create();
    // 任务1加入组
    dispatch_group_async(group, queue, ^{
       
        NSURL *url = [NSURL URLWithString:@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQxex7CvJ0pArQ8NHwXMaZ8fSt3ALAZBlljTQVlDsh6AIegeMjWWMoSVtej"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.image1 = [UIImage imageWithData:data];
    });
    
    // 任务2加入组
    dispatch_group_async(group, queue, ^{
        // 这里可以一样是耗时的网络请求，暂时处理成本地的
        self.image2 = [UIImage imageNamed:@"Play"];
    });
    // 任务完成之后统一通知
    dispatch_group_notify(group, queue, ^{
       
        // 这里的queue如果是mainQueue的话就可以直接回到主线程操作需要的UI
        // 现在还是在并发队列里面  进行图片合成  还是放在子线程
        UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width));
        [self.image1 drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
        [self.image2 drawInRect:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width/2, 30, 40)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        
    });
}


/*
 *  延时执行
 */
 - (void)delay
{
    // 方法1
    NSLog(@"开始了");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"我才开始");
    });
    // 方法2
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:NO];
}

- (void)run
{
    NSLog(@"run");
}



/*
 *  apply 无序快速遍历，可以用于文件移动等需求
 */

- (void)apply
{
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%ld,%@",index,[NSThread currentThread]);
    });
//    2016-12-21 10:04:01.487 GCDBasicAPI[1485:63041] 0,<NSThread: 0x600000069940>{number = 1, name = main}
//    2016-12-21 10:04:01.487 GCDBasicAPI[1485:63172] 2,<NSThread: 0x60800007a940>{number = 7, name = (null)}
//    2016-12-21 10:04:01.487 GCDBasicAPI[1485:63845] 1,<NSThread: 0x60800007a8c0>{number = 6, name = (null)}
//    2016-12-21 10:04:01.487 GCDBasicAPI[1485:63873] 3,<NSThread: 0x60800007ab00>{number = 8, name = (null)}
//    2016-12-21 10:04:01.487 GCDBasicAPI[1485:63041] 4,<NSThread: 0x600000069940>{number = 1, name = main}
//    2016-12-21 10:04:01.488 GCDBasicAPI[1485:63172] 5,<NSThread: 0x60800007a940>{number = 7, name = (null)}
//    2016-12-21 10:04:01.488 GCDBasicAPI[1485:63845] 6,<NSThread: 0x60800007a8c0>{number = 6, name = (null)}
//    2016-12-21 10:04:01.488 GCDBasicAPI[1485:63873] 7,<NSThread: 0x60800007ab00>{number = 8, name = (null)}
//    2016-12-21 10:04:01.488 GCDBasicAPI[1485:63041] 8,<NSThread: 0x600000069940>{number = 1, name = main}
//    2016-12-21 10:04:01.488 GCDBasicAPI[1485:63172] 9,<NSThread: 0x60800007a940>{number = 7, name = (null)}
}

/*
 *  barrier函数可以阻塞任务，执行到他这里，要等之前的任务执行完才能执行之后的任务
 */
- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("com.mkj.hehe", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"--------1,%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 10; i ++)
        {
           NSLog(@"--------2%ld,%@",i,[NSThread currentThread]);
        }
        
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"--------3,%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"--------4,%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"--------5,%@",[NSThread currentThread]);
    });
//    2016-12-21 09:58:09.231 GCDBasicAPI[1392:57437] --------1,<NSThread: 0x60000007f400>{number = 5, name = (null)}
//    2016-12-21 09:58:09.231 GCDBasicAPI[1392:57807] --------20,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.232 GCDBasicAPI[1392:57807] --------21,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.233 GCDBasicAPI[1392:57807] --------22,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.233 GCDBasicAPI[1392:57807] --------23,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.233 GCDBasicAPI[1392:57807] --------24,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.233 GCDBasicAPI[1392:57807] --------25,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.233 GCDBasicAPI[1392:57807] --------26,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.234 GCDBasicAPI[1392:57807] --------27,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.234 GCDBasicAPI[1392:57807] --------28,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.234 GCDBasicAPI[1392:57807] --------29,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.234 GCDBasicAPI[1392:57807] --------3,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.235 GCDBasicAPI[1392:57807] --------4,<NSThread: 0x60000007e780>{number = 7, name = (null)}
//    2016-12-21 09:58:09.235 GCDBasicAPI[1392:57437] --------5,<NSThread: 0x60000007f400>{number = 5, name = (null)}
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
