//
//  NSString+extend.m
//  Wonenglicai
//
//  Created by 辛鹏贺 on 16/8/5.
//  Copyright © 2016年 Xiaobai Future. All rights reserved.
//

#import "NSString+extend.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (extend)

// ***base64加密***
+ (NSString *)base64EncodingWithData:(NSString *)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;//如果sourceString则返回nil，不进行加密。
    }
    NSString *baseStr = [data base64EncodedStringWithOptions:
                         NSDataBase64Encoding64CharacterLineLength];
    return baseStr;
}

// ***base64解密***
+ (NSData *)base64EncodingWithString:(NSString *)sourceString{
    if (!sourceString) {
        return nil;//如果sourceString则返回nil，不进行解密。
    }
    NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return resultData;
}

- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)isLegal{
    return [self isLegalTrimmingWhitespace:YES];
}

- (BOOL)isLegalTrimmingWhitespace:(BOOL)isTrim{
    if (self == nil || [self length]== 0) {
        return NO;
    }
    if (isTrim) {
        if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return NO;
        }
    }
    
    return YES;
}

- (double)getTextHeightWithFont:(UIFont *)font width:(CGFloat)width{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return ceil(rect.size.height);
#else
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    return ceil(size.height);
#endif
}

- (double)getTextWidthWithFont:(UIFont *)font height:(CGFloat)height{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return ceil(rect.size.width);
#else
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(MAXFLOAT, height)];
    return ceil(size.width);
#endif
}

-(NSString *)changeChar{
    NSString *str = self;
    for (NSInteger i = 1; i < (NSInteger)self.length-1; i++) {
        str = [str stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    return str;
}
- (NSString *)changeCharToStarWithRange:(NSRange)range {
    NSString *str = self;
    NSInteger max = ( (NSMaxRange(range)>self.length) ? self.length : NSMaxRange(range));
    for (int i=(int)range.location; i<max; i++) {
        str = [str stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    return str;
}


-(NSString *)triming{
    NSString *str = nil;
    str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return str;
}

-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore{
    int len=(int)self.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[self characterAtIndex:i];
        if( !isalnum(a) )
            return NO;
    }
    return YES;
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)vertifyName:(NSString *)name{
    if (![name isLegal]) {
        return NO;
    }
//    NSString * regex  = [[GlobalModel shareInstance].shareSource getValWithKey:@"zz_realname"];
//    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if( ![pred evaluateWithObject:name] ){
//        return false;
//    }
    
    return YES;
}

+ (BOOL)vertifyNickName:(NSString *)nickName{
    if (![nickName isLegal]) {
        return NO;
    }
//    NSString * regex  = [[GlobalModel shareInstance].shareSource getValWithKey:@"zz_nickname"];
//    @try {
//        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        if( ![pred evaluateWithObject:nickName] ){
//            return false;
//        }
//    } @catch (NSException *exception) {
//        
//        NSLog(@"exception%@",exception);
//    }
    
    return YES;
}

/* 验证身份证号18位跟15位 */
+ (BOOL)verifyIdentity:(NSString*)identityCard{
    
    if (identityCard.length == 15) {
        //|  地址  |   年    |   月    |   日    |
        NSString *regex = @"^(\\d{6})([3-9][0-9][01][0-9][0-3])(\\d{4})$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        return [identityCardPredicate evaluateWithObject:identityCard];
    }
    
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"] || [idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
    
    
    return YES;
}

+ (BOOL)vertifyBankNumber:(NSString *)bankNumber{
    if (![bankNumber isLegal]) {
        return NO;
    }
    
    //后台去校验，客户端判断90%多几率正确
    if (bankNumber.length > 11 && bankNumber.length < 20) {
        return YES;
    }
    
    return NO;
//    NSString * regex  = @"^([0-9]{16}|[0-9]{19})$";
//    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    if( ![pred evaluateWithObject:bankNumber] ){
//        return false;
//    }
//    
//    return YES;
}

static int wi[] = { 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 };
static int vi[] = { 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 };
+ (NSString *)getVerify:(NSString *)eightcardid{
    int remaining = 0;
    int ai[18];
    if (eightcardid.length == 18) {
        NSRange range;
        range.location = 0;
        range.length = 17;
        eightcardid = [eightcardid substringWithRange:range];
    }
    if (eightcardid.length == 17) {
        int sum = 0;
        for (int i = 0; i < 17; i++) {
            //				String k = eightcardid.substring(i, i + 1);
            char k = [eightcardid characterAtIndex:i];
            ai[i] = (int)(k - '0');
        }
        for (int i = 0; i < 17; i++) {
            sum = sum + wi[i] * ai[i];
        }
        remaining = sum % 11;
    }
    return remaining == 2 ? @"X" : [NSString stringWithFormat:@"%d",vi[remaining]];
}

+ (BOOL)verifyMobile:(NSString *)mobile{
    
    return NO;
//    NSString *express = [[GlobalModel shareInstance].shareSource getValWithKey:@"zz_sjh"];
//    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF matches %@", express];
//    return [pred evaluateWithObject:mobile];
}

+ (BOOL)verifyEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)assetsFormatting:(NSString *)asset{
    if ([asset isLegal]) {
        
        return [NSString stringWithFormat:@"%.2f",[asset doubleValue]];
    }
    
    return @"--";
}

-(BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
     
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
        
    }
    return NO;
}

@end
