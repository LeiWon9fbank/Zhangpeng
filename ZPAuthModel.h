//
//  ZPAuthModel.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/30.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^NetworkSuccessBlock)(id  _Nonnull responseObject, NSInteger code, NSString *message);

typedef void(^NetworkFailureBlock)(id  _Nonnull responseObject, NSInteger code, NSString *message);

@interface ZPAuthModel : NSObject

+ (void)getRequestUrl:(NSString *)url complete:(NetworkSuccessBlock)complete failure:(NetworkFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
