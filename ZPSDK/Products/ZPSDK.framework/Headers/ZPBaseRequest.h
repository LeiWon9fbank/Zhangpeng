//
//  ZPBaseRequest.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBaseRequest : NSObject

/** 请求类型 */
@property (nonatomic, assign) int type;
/** 由用户微信号和AppID组成的唯一标识，需要校验微信用户是否换号登录时填写*/
@property (nonatomic, copy) NSString *openID;

@end

NS_ASSUME_NONNULL_END
