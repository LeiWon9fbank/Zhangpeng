//
//  NSString+Base64.m
//  FXZK
//
//  Created by Lee on 2018/1/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "NSString+Base64.h"

#import <CommonCrypto/CommonDigest.h>

#define JRKey @"jierong123"
#define ReplaceString_1 @"oo0oo0"     // "=" 替换成字符串 "oo0oo0"
#define ReplaceString_2 @"0o0o00"     // "+" 替换成字符串 "0o0o00"
#define ReplaceString_3 @"o0oo0o"     // "/" 替换成字符串 "o0oo0o"

#define ENCODE_KEY @"hfxy123"                           // 参数加密 key
#define SIGN_KEY   @"szhfxy20191021developgo886997yan"  // 签名 key
@implementation NSString (Base64)


//参数加密规则：
/*
 1、使用  base64 对数据进行编码;
 2、再将转码过后的字符串转换为数组;
 3、计算出数据的数组的长度;
 4、把秘钥拆分为数组;
 5、把秘钥和数据重新组合；
 6、把重组后数组元素组合成字符串;
 7、把加密生成的字符串中的“=、+、/ 替换成指定的字符串 'oo0oo0','0o0o00','o0oo0o'
 */
- (NSString *)base64EncodedString;
{

    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
//    NSLog(@"%@ --base64编码后-- %@", self, base64Str);
    
    NSMutableArray *base64Arr = [NSMutableArray new];
    for (int i = 0; i < [base64Str length]; i++) {
        
        NSString *str = [base64Str substringWithRange:NSMakeRange(i, 1)];
        NSString *addStr = nil;
//        //  倍数
//        int multiple = i / JRKey.length;
//        //  隔位插入key（所有字母后都插入）
//        addStr = [JyRKe substringWithRange:NSMakeRange(i - multiple * JRKey.length, 1)];
        
        //
        if (i < ENCODE_KEY.length) {
            addStr = [ENCODE_KEY substringWithRange:NSMakeRange(i, 1)];
        }else{
            addStr = @"";
        }
        
        [base64Arr addObject:[str stringByAppendingString:addStr]];
    }
    
    //  数组转字符串
    NSString *arrayStr = [base64Arr componentsJoinedByString:@""];
//    NSLog(@"数组转字符串 = %@", arrayStr);
    //  替换 =、+、/
    arrayStr = [arrayStr stringByReplacingOccurrencesOfString:@"=" withString:ReplaceString_1];
    arrayStr = [arrayStr stringByReplacingOccurrencesOfString:@"+" withString:ReplaceString_2];
    arrayStr = [arrayStr stringByReplacingOccurrencesOfString:@"/" withString:ReplaceString_3];
    
//    NSLog(@"替换'='、'+'、'/' 后字符串 = %@", arrayStr);
    
//    [self signWithDic:[[NSMutableDictionary alloc] initWithDictionary:@{@"uid":@"123456", @"cid":@"999",@"empty":@""}]];
    return arrayStr;
}

//  加密步骤倒过来进行
- (NSString *)base64DecodedString
{
    NSString *base64Str = self;
    //  加密方法反向进行
    base64Str = [base64Str stringByReplacingOccurrencesOfString:ReplaceString_1 withString:@"="];
    base64Str = [base64Str stringByReplacingOccurrencesOfString:ReplaceString_2 withString:@"+"];
    base64Str = [base64Str stringByReplacingOccurrencesOfString:ReplaceString_3 withString:@"/"];
    
    //  字符串转数组
     NSMutableArray *strArr = [NSMutableArray new];
    for (int i = 0; i < [base64Str length]; i++) {
        
        NSString *str = [base64Str substringWithRange:NSMakeRange(i, 1)];
        
        if ( i < [ENCODE_KEY length]*2) {
            if(i % 2 == 0){
                //能被2整除
                [strArr addObject:str];
            }
            else{
                //下标从0开始，不能被2整除则是插入JRKey地方
            }
        }else{
            [strArr addObject:str];
        }
        

    }
    
    //  数组转字符串
    NSString *arrayStr = [strArr componentsJoinedByString:@""];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:arrayStr options:0];
    NSString *originalStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

    
    return originalStr;
}


////签名规则：（原数据签名）
///*
// 1、将参数数组按照参数名ASCII码从小到大排序
// 2、剔除参数值为空的参数
// 3、 整合新的参数数组
// 4、使用 & 符号连接参数
// 5、拼接key
// 6、 key是在商户平台API安全里自己设置的
// 7、将字符串进行MD5加密
// 8、将所有字符转换为大写
// */
//-(NSString *)signWithDic:(NSMutableDictionary *)dic{
//
////    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"123456",@"uid", nil];
//
//    //  当前时间戳
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
////    [dic setObject:timeSp forKey:@"sign"];
//    [dic setValue:timeSp forKey:@"time"];
////    NSLog(@"时间戳 = %@", dic);
//
//    /*请求参数按照参数名ASCII码从小到大排序*/
//
////    NSArray *keys = [dic allKeys];
//    NSArray *keys = [dic allKeys];
//    NSMutableArray *tempKeys = [NSMutableArray new];
//    //  剔除参数值为空的参数 (先剔除再排序)
//    for (NSString *keyStr in keys) {
//        //  keyStr对应dic字典中value值为null或=@""时，不填入排序数组tempKeys
//        if ([[dic objectForKey:keyStr] isEqual:[NSNull null]] || [[dic objectForKey:keyStr] isEqualToString:@""]) {
////            [keys removeObject:keyStr];
//        }
//        else{
//            [tempKeys addObject:keyStr];
//        }
//    }
//    //  按字母顺序排序
//    NSArray *sortedArray = [tempKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//
//        return [obj1 compare:obj2 options:NSNumericSearch];
//
//    }];
//
//
//
//    NSString *returnStr = @"";
//
//    //拼接字符串
//
//    for (int i = 0;i < sortedArray.count; i++){
//
//        NSString *category = sortedArray[i];
//
//        if (i==0) {
//
//            returnStr = [NSString stringWithFormat:@"%@=%@", category, dic[category]];
//
//        }else{
//
//            returnStr = [NSString stringWithFormat:@"%@&%@=%@",returnStr, category, dic[category]];
//
//        }
//
//    }
//
//    /*拼接上key得到stringSignTemp*/
//    returnStr = [NSString stringWithFormat:@"%@&key=%@", returnStr, JRKey];
//
//    NSLog(@"签名string = %@", returnStr);
//    /*md5加密*/
//    returnStr = [self bigmd5:returnStr];
//
//    return returnStr;
//}
//
////md5 32位加密 （大写）
//
//- (NSString *)bigmd5:(NSString *)str {
//
//    const char *cStr = [str UTF8String];
//
//    unsigned char result[16];
//
//    CC_MD5( cStr, strlen(cStr), result);
//
//    return [NSString stringWithFormat:
//
//            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//
//            result[0], result[1], result[2], result[3],
//
//            result[4], result[5], result[6], result[7],
//
//            result[8], result[9], result[10], result[11],
//
//            result[12], result[13], result[14], result[15]
//
//            ];
//
//}
//
////md5 32位 加密 （小写）
//
//+ (NSString *)md5:(NSString *)str {
//
//    const char *cStr = [str UTF8String];
//
//    unsigned char result[32];
//
//    CC_MD5( cStr, strlen(cStr), result );
//
//    return [NSString stringWithFormat:
//
//            @"xxxxxxxxxxxxxxxx",
//
//            result[0],result[1],result[2],result[3],
//
//            result[4],result[5],result[6],result[7],
//
//            result[8],result[9],result[10],result[11],
//
//            result[12],result[13],result[14],result[15],
//
//            result[16], result[17],result[18], result[19],
//
//            result[20], result[21],result[22], result[23],
//
//            result[24], result[25],result[26], result[27],
//
//            result[28], result[29],result[30], result[31]];
//
//}
//
////产生16位随机数
//
//+ (NSString *)generateFradomCharacter
//
//{
//
//    static int kNumber = 16;
//
//    NSString *sourceStr = @"abcdefghijklmnopqrstuvwxyz0123456789";
//
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//
//    for (int i = 0; i < kNumber; i++)
//
//    {
//
//        unsigned index = arc4random() % [sourceStr length];
//
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//
//        [resultStr appendString:oneStr];
//
//    }
//
//    return resultStr;
//
//}


@end
