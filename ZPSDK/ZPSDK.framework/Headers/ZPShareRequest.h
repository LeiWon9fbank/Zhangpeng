//
//  ZPShareRequest.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/29.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "ZPBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZPShareRequest : ZPBaseRequest

@property (nonatomic, copy) NSString *imgUrl;//图片地址

@property (nonatomic, copy) NSString *text;//文本消息

@property (nonatomic, assign) BOOL bText;//是否是文本，如果不是文本类，必须传imgUrl

@property (nonatomic, copy, nullable) NSString *toUserOpenId;

@end

NS_ASSUME_NONNULL_END
