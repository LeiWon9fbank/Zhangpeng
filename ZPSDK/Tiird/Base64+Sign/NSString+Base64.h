//
//  NSString+Base64.h
//  FXZK
//
//  Created by Lee on 2018/1/12.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;

/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;


///**
// *  签名
// */
//-(NSString *)signWithDic:(NSMutableDictionary *)dic;

@end
