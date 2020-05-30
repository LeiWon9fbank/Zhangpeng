//
//  ZPShareCompound.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/5/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <ZPSDK/ZPSDK.h>

@class ZPShareCompoundData;
NS_ASSUME_NONNULL_BEGIN

@interface ZPShareCompound : ZPBaseRequest


@property (strong, nonatomic) NSArray <ZPShareCompoundData *> *compoundList;//此处数据模型必须按照标准给

@end

NS_ASSUME_NONNULL_END
