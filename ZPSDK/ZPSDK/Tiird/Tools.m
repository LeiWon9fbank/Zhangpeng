//
//  Tools.m
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/29.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (BOOL)isBlankString:(NSString *)string {
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
