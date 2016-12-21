//
//  ManagerHelper.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ManagerHelper.h"

@interface ManagerHelper () <NSCopying>

@end

// 这里为什么要用static 能保证只能本文件访问,如果去掉，那么外部external就能访问，强行为nil的话那么这个就根本不是单例了


@implementation ManagerHelper

MKJSinletonM

@end
