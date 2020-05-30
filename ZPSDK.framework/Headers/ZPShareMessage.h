//
//  ZPShareMessage.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/5/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <ZPSDK/ZPSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPShareMessage : ZPBaseRequest

@property (nonatomic, copy) NSString *content;//文本消息,url通为文本信息

@end

NS_ASSUME_NONNULL_END
