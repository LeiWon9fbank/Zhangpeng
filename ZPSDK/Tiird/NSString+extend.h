//
//  NSString+extend.h
//  Wonenglicai
//
//  Created by 辛鹏贺 on 16/8/5.
//  Copyright © 2016年 Xiaobai Future. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (extend)

/**
 *  三种加密方式：MD5、AES、BASE64
 */
- (NSString *)md5;

//- (NSString *)AESByEncodingString;

+ (NSString *)base64EncodingWithData:(NSString *)str;
+ (NSData *)base64EncodingWithString:(NSString *)sourceString;

/**
 *  判断字符串是否==nil或者为[self length]==0
 *
 *  @return bool值
 */
- (BOOL)isLegal;

/**
 *  判断字符串去除空格符和回车符后，是否==nil或者为[self length]==0
 *
 *  @return bool值
 */
- (BOOL)isLegalTrimmingWhitespace:(BOOL)isTrim;

/**
 *  指定range字符转换成*
 *
 *  @return bool值
 */
- (NSString *)changeCharToStarWithRange:(NSRange)range;

/**
 *  去除字符串中的空格和换行
 *
 *  @return 变换后的字符串
 */
- (NSString *)triming;

/**
 *  判断字符串 中文字符 字母 数字 以及下划线
 *
 *  @return bool值
 */
- (BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore;

- (double)getTextHeightWithFont:(UIFont *)font width:(CGFloat)width;
- (double)getTextWidthWithFont:(UIFont *)font height:(CGFloat)height;

//判断是否为整形：
- (BOOL)isPureInt:(NSString *)string;

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string;

/**
 *  验证姓名是否合法
 *
 *  @param name 姓名
 *
 *  @return YES or NO
 */
+ (BOOL)vertifyName:(NSString *)name;

/**
 *  验证昵称是否合法
 *
 *  @param nickName 昵称
 *
 *  @return YES or NO
 */
+ (BOOL)vertifyNickName:(NSString *)nickName;

/**
 *  验证身份证是否合法
 *
 *  @param idcard 身份证
 *
 *  @return YES or NO
 */
+ (BOOL)verifyIdentity:(NSString*)identityCard;

/**
 *  验证银行卡号是否合法
 *
 *  @param bankNumber 银行卡号
 *
 *  @return YES or NO
 */
+ (BOOL)vertifyBankNumber:(NSString *)bankNumber;

/**
 *  验证手机号是否合法
 *
 *  @param mobile 手机号
 *
 *  @return YES or NO
 */
+ (BOOL)verifyMobile:(NSString *)mobile;

/**
 *  验证邮箱是否合法
 *
 *  @param email 邮箱
 *
 *  @return YES or NO
 */
+ (BOOL)verifyEmail:(NSString *)email;

/*
 *  资产格式化 保留两位小数
 */
+ (NSString *)assetsFormatting:(NSString *)asset;

//判断字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;


@end
