//
//  ZPAuthReuest.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/29.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "ZPBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZPAuthReuest : ZPBaseRequest

@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *appsecret;
@property (nonatomic, copy) NSString *appbundleid;
@property (nonatomic, copy) NSString *apptype;
@end

NS_ASSUME_NONNULL_END
