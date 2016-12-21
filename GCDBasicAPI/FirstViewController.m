//
//  FirstViewController.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"first";
    self.view.backgroundColor = [UIColor redColor];
}

/*
 *  同步和异步是具备开线程的能力，同步并发和同步串行都不开线程，阻塞当前线程，在当前线程一个个执行
 *  异步串行是开多一条线程，不阻塞，在开出来的那条线程顺序进行
 *  异步并发根据任务是否开多条线程，不阻塞，在并发队列里面并发执行
 */


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self asynchSerial];
}

/*
 *  异步串行   --->       不阻塞当前线程，会开多一条线程，在这个线程中是串行执行的
 */
- (void)asynchSerial
{
    // 全局并发队列
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 自定义并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("COM.MKJ.COM", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue1, ^{
        NSLog(@"------1,%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"------2,%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"------3,%@",[NSThread currentThread]);
    });
    NSLog(@"asynchSerial------end");
//    2016-12-21 09:34:16.222 GCDBasicAPI[1137:38266] asynchSerial------end
//    2016-12-21 09:34:16.222 GCDBasicAPI[1137:38300] ------1,<NSThread: 0x60000007a640>{number = 3, name = (null)}
//    2016-12-21 09:34:16.223 GCDBasicAPI[1137:38300] ------2,<NSThread: 0x60000007a640>{number = 3, name = (null)}
//    2016-12-21 09:34:16.223 GCDBasicAPI[1137:38300] ------3,<NSThread: 0x60000007a640>{number = 3, name = (null)}
    
}


/*
 *  同步串行   --->       阻塞当前线程，不开多条线程，在当前线程执行，顺序执行
 */
- (void)synchSerial
{
    // 全局并发队列
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 自定义并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("COM.MKJ.COM", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue1, ^{
        NSLog(@"------1,%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue1, ^{
        NSLog(@"------2,%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue1, ^{
        NSLog(@"------3,%@",[NSThread currentThread]);
    });
    NSLog(@"synchSerial------end");
//    2016-12-21 09:32:25.878 GCDBasicAPI[1117:36348] ------1,<NSThread: 0x600000075700>{number = 1, name = main}
//    2016-12-21 09:32:25.878 GCDBasicAPI[1117:36348] ------2,<NSThread: 0x600000075700>{number = 1, name = main}
//    2016-12-21 09:32:25.879 GCDBasicAPI[1117:36348] ------3,<NSThread: 0x600000075700>{number = 1, name = main}
//    2016-12-21 09:32:25.879 GCDBasicAPI[1117:36348] synchSerial------end
    
}




/*
 *  同步并发   --->       阻塞当前线程，不开多条线程，在当前线程执行，顺序执行
 */
- (void)synchConcurrent
{
    // 全局并发队列
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 自定义并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("COM.MKJ.COM", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue1, ^{
        NSLog(@"------1,%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue1, ^{
        NSLog(@"------2,%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue1, ^{
        NSLog(@"------3,%@",[NSThread currentThread]);
    });
    NSLog(@"synchConcurrent------end");
//    2016-12-21 09:29:47.575 GCDBasicAPI[1071:33607] ------1,<NSThread: 0x60000006b900>{number = 1, name = main}
//    2016-12-21 09:29:47.575 GCDBasicAPI[1071:33607] ------2,<NSThread: 0x60000006b900>{number = 1, name = main}
//    2016-12-21 09:29:47.576 GCDBasicAPI[1071:33607] ------3,<NSThread: 0x60000006b900>{number = 1, name = main}
//    2016-12-21 09:29:47.576 GCDBasicAPI[1071:33607] synchConcurrent------end
    
}


/*
 *  异步并发   --->       不阻塞当前线程，可以开多条线程，并发执行，顺序不一定
 */
- (void)asynchConcurrent
{
    // 全局并发队列
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 自定义并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("COM.MKJ.COM", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue1, ^{
        NSLog(@"------1,%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"------2,%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue1, ^{
        NSLog(@"------3,%@",[NSThread currentThread]);
    });
    NSLog(@"asynchConcurrent------end");
//    2016-12-21 09:28:23.895 GCDBasicAPI[1050:32223] asynchConcurrent------end
//    2016-12-21 09:28:23.895 GCDBasicAPI[1050:32292] ------1,<NSThread: 0x60800026e180>{number = 3, name = (null)}
//    2016-12-21 09:28:23.895 GCDBasicAPI[1050:32293] ------3,<NSThread: 0x60800026fbc0>{number = 5, name = (null)}
//    2016-12-21 09:28:23.895 GCDBasicAPI[1050:32295] ------2,<NSThread: 0x60000026e0c0>{number = 4, name = (null)}

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
