//
//  NSString+Encode.m
//  AIFuYan
//
//  Created by hfxy on 2019/10/22.
//  Copyright © 2019 hfxy. All rights reserved.
//

#import "NSString+FuYanEncode.h"
#import "NSString+Base64.h"

@implementation NSString (FuYanEncode)

///  字符串交叉插入 KEY
/// @param key    插入的 KEY
- (NSString *)crossInsertKey:(NSString *)key {
    NSMutableString * res = [NSMutableString string];
    NSInteger idx = 0;
    while (idx < self.length) {
        if (idx < self.length) {
            [res appendString:[self substringWithRange:NSMakeRange(idx, 1)]];
        }
        if (idx < key.length) {
            [res appendString:[key substringWithRange:NSMakeRange(idx, 1)]];
        }
        idx++;
    }
    
    return res;
}

/// 替换掉 base64 中的 +, =, / 符号
- (NSString *)replaceParamatersIngroCharacters {
    NSString *value = self;
    value = [value stringByReplacingOccurrencesOfString:@"+" withString:@"0o0o00"];
    value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"oo0oo0"];
    value = [value stringByReplacingOccurrencesOfString:@"/" withString:@"o0oo0o"];
    return value;
}

#pragma mark - Decode

/// 移除数脏数据
/// @param key 脏数据 KEY
- (NSString *)removeInsertKey:(NSString *)key {
    if (self.length == 0 || key.length == 0) { return self; }
    // 转为 C 字符数组方便比较和处理
    // self.length + 1 目的是为 '\0' 预留一位
    char *characters = malloc(sizeof(char) * (self.length + 1));
    memcpy(characters, self.UTF8String, self.length);
    characters[self.length] = '\0';
    // key 的 C 字符数组
    const char *keyCharahcters = key.UTF8String;
    NSInteger idx = 0;
    while (idx < key.length) {
        // 1. 源字符数组奇数位跳跃比对
        // 2. key 字符数组, 逐个比对
        NSInteger index = idx * 2 + 1;
        if (index < self.length) {
            if (characters[index] == keyCharahcters[idx]) {
                // 如果是 key 里面的字符, 则替换为填充字符, 在最终同意进行清楚
                characters[index] = '$';
            }
        }
        idx++;
    }
    NSString *temp = [NSString stringWithUTF8String:characters];
    free(characters);
    // 清除占位字符
    return [temp stringByReplacingOccurrencesOfString:@"$" withString:@""];
}

/// 还原 base64 中的, +, =, / 符号
- (NSString *)restoreParamatersIngroCharacters {
    NSString *value = self;
    value = [value stringByReplacingOccurrencesOfString:@"0o0o00" withString:@"+"];
    value = [value stringByReplacingOccurrencesOfString:@"oo0oo0" withString:@"="];
    value = [value stringByReplacingOccurrencesOfString:@"o0oo0o" withString:@"/"];
    return value;
}

/// 字符串解密
/// @param key 加密 key
- (NSString *)decodeWithKey:(NSString *)key {
    NSString *value = self;
    value = [value removeInsertKey:key];
    value = [value restoreParamatersIngroCharacters];
    return [value base64EncodedString];
}

@end
