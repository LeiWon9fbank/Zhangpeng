//
//  ZPBaseRespones.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPBaseRespones : NSObject

/*! @brief 该类为微信终端SDK所有响应类的基类
 *
 */
/** 错误码 */
@property (nonatomic, assign) int errCode;
/** 错误提示字符串 */
@property (nonatomic, copy) NSString *errStr;
/** 响应类型 */
@property (nonatomic, assign) int type;

@end

NS_ASSUME_NONNULL_END
