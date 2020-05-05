//
//  ZPAuthRespones.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/30.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <ZPSDK/ZPSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPAuthRespones : ZPBaseRespones

@property (copy, nonatomic) NSString *code;

@end

NS_ASSUME_NONNULL_END
