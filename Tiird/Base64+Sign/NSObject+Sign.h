//
//  NSObject+Sign.h
//  SKB
//
//  Created by Lee on 2018/1/17.
//  Copyright © 2018年 洛阳捷融网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Sign)
/**
 *  签名
 */
-(NSString *)signWithDic:(NSMutableDictionary *)dic;
@end
