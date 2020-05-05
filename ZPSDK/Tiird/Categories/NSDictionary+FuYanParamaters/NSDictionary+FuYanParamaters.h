//
//  NSDictionary+FuYanParamaters.h
//  AIFuYan
//
//  Created by hfxy on 2019/10/22.
//  Copyright © 2019 hfxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (FuYanParamaters)

/// 通过参数计算签名
/// @param key 签名 salt
- (NSString *)signWithKey:(NSString *)key;


/// 对参数进行 解密
/// @param encodeKey 解密 key
- (NSDictionary *)resultDecodeWithKey:(NSString *)encodeKey;

@end

@interface NSMutableDictionary (FuYanParamaters)

#pragma mark - Encode

/// 对参数进行加密
/// @param encodeKey 加密 key
- (void)parametersEncodeWithKey:(NSString *)encodeKey;


#pragma mark - Decode

/// 对参数进行 解密
/// @param encodeKey 解密 key
- (void)parametersDecodeWithKey:(NSString *)encodeKey;

@end

NS_ASSUME_NONNULL_END
