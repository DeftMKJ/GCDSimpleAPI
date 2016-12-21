//
//  SecondMSingleton.m
//  GCDBasicAPI
//
//  Created by MKJING on 2016/12/21.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "SecondMSingleton.h"

@interface SecondMSingleton () <NSCopying>

@end


@implementation SecondMSingleton

static id obj;

+ (instancetype)shareInstance
{
    @synchronized (self) {
        if (!obj) {
            obj = [[self alloc] init];
        }
    }
    return obj;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (!obj) {
            obj = [super allocWithZone:zone];
        }
    }
    return obj;
}

- (id)copyWithZone:(NSZone *)zone
{
    return obj;
}



@end
