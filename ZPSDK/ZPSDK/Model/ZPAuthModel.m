//
//  ZPAuthModel.m
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/30.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "ZPAuthModel.h"
#import "Network.h"
@implementation ZPAuthModel

+ (void)getRequestUrl:(NSString *)url complete:(NetworkSuccessBlock)complete failure:(NetworkFailureBlock)failure{
    [[Network sharedManager] POST:NetworkFlagHomeBanner paramaters:@{} complete:^(id  _Nonnull responseObject, NSInteger code, NSString * _Nonnull message) {
        NSLog(@"res,%@",responseObject);
        if (complete) {
            complete(responseObject,code,message);
        }
    }];
}

@end
