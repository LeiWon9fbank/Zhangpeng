//
//  ZPShareImageData.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/5/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <ZPSDK/ZPSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPShareImageData : ZPBaseRequest

@property (strong, nonatomic) NSString *imageData;//分享过来的图片

@property (strong, nonatomic) NSString *imageUrl;//分享过来的图片地址

@property (nonatomic, assign) BOOL bUrl;//是否是imgUrl


@end

NS_ASSUME_NONNULL_END
