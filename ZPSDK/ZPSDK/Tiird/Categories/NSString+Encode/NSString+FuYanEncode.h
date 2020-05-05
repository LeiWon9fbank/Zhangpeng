//
//  NSString+Encode.h
//  AIFuYan
//
//  Created by hfxy on 2019/10/22.
//  Copyright © 2019 hfxy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FuYanEncode)

#pragma mark - Encode

///  字符串交叉插入脏数据
/// @param key    插入的 KEY
- (NSString *)crossInsertKey:(NSString *)key;

/// 替换掉 base64 中的 +, =, / 符号
- (NSString *)replaceParamatersIngroCharacters;

#pragma mark - Decode

/// 移除数脏数据
/// @param key 脏数据 KEY
- (NSString *)removeInsertKey:(NSString *)key;

/// 还原 base64 中的, +, =, / 符号
- (NSString *)restoreParamatersIngroCharacters;

/// 字符串解密
/// @param key 加密 key
- (NSString *)decodeWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
