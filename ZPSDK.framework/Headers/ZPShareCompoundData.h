//
//  ZPShareCompoundData.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/5/29.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPShareCompoundData : NSObject

@property (copy, nonatomic) NSString *sdkShareContent;//内容

@property (copy, nonatomic) NSString *sdkShareIsLink;//是否存在click，0-N，1-Y

@property (copy, nonatomic) NSString *sdkShareLinkType;//打开方式，0-Web,1-chat

@property (copy, nonatomic) NSString *sdkShareIsLinkUrl;//需要打开的url

- (instancetype)initWithData:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
