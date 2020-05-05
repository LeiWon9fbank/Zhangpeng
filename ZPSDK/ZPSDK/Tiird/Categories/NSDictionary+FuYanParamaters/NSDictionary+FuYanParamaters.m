//
//  NSDictionary+FuYanParamaters.m
//  AIFuYan
//
//  Created by hfxy on 2019/10/22.
//  Copyright © 2019 hfxy. All rights reserved.
//

#import "NSDictionary+FuYanParamaters.h"
#import "NSString+Base64.h"
#import "NSString+FuYanEncode.h"
#import "NSObject+Sign.h"
#import "NSString+extend.h"
@implementation NSDictionary (FuYanParamaters)

/// 计算参数的签名
/// @param key 签名使用的 salt
- (NSString *)signWithKey:(NSString *)key {
    NSMutableDictionary *res = [self mutableCopy];
//    // 1. 对 key 排序
//    NSArray <NSString *>*sortedKeys = [res.allKeys sortedArrayUsingSelector:@selector(compare:)];
//    // 2. 按顺序拼接 key=value 并加入数组
//    NSMutableArray *values = [NSMutableArray new];
//    for (NSString *key in sortedKeys) {
//        [values addObject:[NSString stringWithFormat:@"%@=%@", key, self[key]]];
//    }
//    [values addObject:[NSString stringWithFormat:@"key=%@", key]];
//    // 3. 用 & 把数组转换为字符串
//    NSString *string = [values componentsJoinedByString:@"&"];
//    // 4. 2 次 md5 运算
//    NSString *sign = [[string md5] md5String];
//    // 5. 转为大写
//    return [sign uppercaseString];
    
    return [self signWithDic:res];
}

/// 对参数进行 解密
/// @param encodeKey 解密 key
- (NSDictionary *)resultDecodeWithKey:(NSString *)encodeKey {
    NSMutableDictionary *temp = [self mutableCopy];
    [temp parametersDecodeWithKey:encodeKey];
    return temp;
}

@end


@implementation NSMutableDictionary (FuYanParamaters)

/// 对参数进行加密
/// @param encodeKey 加密 key
- (void)parametersEncodeWithKey:(NSString *)encodeKey {
    for (NSString *key in self.allKeys) {
        NSString *value = self[key];
        // 过滤掉空参数
        if (value.length == 0) {
            continue;
        }
        value = [value base64EncodedString];
        value = [value crossInsertKey:encodeKey];
        self[key] = [value replaceParamatersIngroCharacters];
    }
}

/// 对参数进行 解密
/// @param encodeKey 解密 key
- (void)parametersDecodeWithKey:(NSString *)encodeKey {
    for (NSString *key in self.allKeys) {
        NSString *value = self[key];
        if (value.length == 0) {
            continue;
        }
        value = [value removeInsertKey:encodeKey];
        value = [value restoreParamatersIngroCharacters];
        self[key] = [NSString base64EncodingWithString:value];
    }
}

@end
