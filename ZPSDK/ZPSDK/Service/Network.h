//
//  Network.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NetworkFlag) {
    // Sign In
    NetworkFlagLogin                = 910102,      // 登录
    NetworkFlagAuther                = 910201,      // auther
    NetworkFlagAutoLogin            = 910102,      // 分享消息接口
    NetworkFlagHomeBanner           = 9101011,     // 首页 banner

};

typedef void(^NetworkResultBlock)(id responseObject, NSError *error);

@interface Network : NSObject

+ (Network *)sharedManager;

- (void)POST:(NetworkFlag)flag paramaters:(NSDictionary *)paramaters complete:(void(^)(id responseObject,NSInteger code, NSString *message))complete;

#pragma mark - POST
-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url complete:(void(^)(id responseObject,NSInteger code, NSString *message))complete;
@end

NS_ASSUME_NONNULL_END
