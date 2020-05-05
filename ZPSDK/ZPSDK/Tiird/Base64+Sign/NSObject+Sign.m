//
//  NSObject+Sign.m
//  SKB
//
//  Created by Lee on 2018/1/17.
//  Copyright © 2018年 洛阳捷融网络科技有限公司. All rights reserved.
//

#import "NSObject+Sign.h"

#import <CommonCrypto/CommonDigest.h>

#define JRKey @"jierong123"                             //加密秘钥
#define JRMD5 @"overcome5difficulties2move1forward"     //签名私钥

#define ENCODE_KEY @"hfxy123"                           // 参数加密 key
#define SIGN_KEY   @"szhfxy20191021developgo886997yan"  // 签名 key

@implementation NSObject (Sign)

//签名规则：（原数据签名）
/*
 1、将参数数组按照参数名ASCII码从小到大排序
 2、剔除参数值为空的参数
 3、 整合新的参数数组
 4、使用 & 符号连接参数
 5、拼接key
 6、 key是在商户平台API安全里自己设置的
 7、将字符串进行MD5加密
 8、将所有字符转换为大写
 */
-(NSString *)signWithDic:(NSMutableDictionary *)dic{
    
    
//    //  当前时间戳 (网络请求方法中已添加过时间戳，避免重复添加)
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    //    [dic setObject:timeSp forKey:@"sign"];
//    [dic setValue:timeSp forKey:@"time"];
//    NSLog(@"当前时间戳 = %@", timeSp);
    
    /*请求参数按照参数名ASCII码从小到大排序*/
    
    //    NSArray *keys = [dic allKeys];
    NSArray *keys = [dic allKeys];
    NSMutableArray *tempKeys = [NSMutableArray new];
    //  剔除参数值为空的参数 (先剔除再排序)
    for (NSString *keyStr in keys) {
        //  keyStr对应dic字典中value值为null或=@""时，不填入排序数组tempKeys
        if ([[dic objectForKey:keyStr] isEqual:[NSNull null]] || [[dic objectForKey:keyStr] isEqualToString:@""]) {
            //            [keys removeObject:keyStr];
        }
        else{
            [tempKeys addObject:keyStr];
        }
    }
    //  按字母顺序排序
    NSArray *sortedArray = [tempKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    
    
    NSString *returnStr = @"";
    
    //拼接字符串
    
    for (int i = 0;i < sortedArray.count; i++){
        
        NSString *category = sortedArray[i];
        
        if (i==0) {
            
            returnStr = [NSString stringWithFormat:@"%@=%@", category, dic[category]];
            
        }else{
            
            returnStr = [NSString stringWithFormat:@"%@&%@=%@",returnStr, category, dic[category]];
            
        }
        
    }
    
    /*拼接上key得到stringSignTemp*/
    returnStr = [NSString stringWithFormat:@"%@&key=%@", returnStr, SIGN_KEY];
    
//    NSLog(@"签名string = %@", returnStr);
    /*md5加密  2次*/
    NSString *str1 = [self getMd5_32Bit_String:returnStr];
    NSString *str2 = [NSString stringWithFormat:@"%@", [self bigmd5:str1]];
    return str2;
}

//32位MD5加密方式
- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

//md5 32位加密 （大写）
- (NSString *)bigmd5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
    
}

//md5 32位 加密 （小写）

+ (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[32];
    
    CC_MD5( cStr, strlen(cStr), result );
    
    return [NSString stringWithFormat:
            
            @"xxxxxxxxxxxxxxxx",
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}

//产生16位随机数

+ (NSString *)generateFradomCharacter

{
    
    static int kNumber = 16;
    
    NSString *sourceStr = @"abcdefghijklmnopqrstuvwxyz0123456789";
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    for (int i = 0; i < kNumber; i++)
        
    {
        
        unsigned index = arc4random() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
        
    }
    
    return resultStr;
    
}


@end
