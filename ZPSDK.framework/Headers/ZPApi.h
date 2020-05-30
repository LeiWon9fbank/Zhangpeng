//
//  ZPApi.h
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZPBaseRespones;
@class ZPBaseRequest;

NS_ASSUME_NONNULL_BEGIN

@protocol ZPApiDelegate <NSObject>

- (void)zpOnRequ:(ZPBaseRequest *)requ;

- (void)zpOnResp:(ZPBaseRespones *)resp;

@end


@interface ZPApi : NSObject
/*! @brief WXApi的成员函数，向微信终端程序注册第三方应用。
 *
 * 需要在每次启动第三方应用程序时调用。
 * @attention 请保证在主线程中调用此函数
 * @param appid 微信开发者ID
 * @param universalLink 微信开发者Universal Link
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)registerApp:(NSString *)appid withAppSecret:(NSString *)appSecret universalLink:(NSString *)universalLink;

/*! @brief 处理旧版微信通过URL启动App时传递的数据
 *
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 微信启动第三方应用时传递过来的URL
 * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)handleOpenURL:(NSURL *)url delegate:(nullable id<ZPApiDelegate>)delegate;


/*! @brief 处理微信通过Universal Link启动App时传递的数据
 *
 * 需要在 application:continueUserActivity:restorationHandler:中调用。
 * @param userActivity 微信启动第三方应用时系统API传递过来的userActivity
 * @param delegate  WXApiDelegate对象，用来接收微信触发的消息。
 * @return 成功返回YES，失败返回NO。
 */
+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity delegate:(nullable id<ZPApiDelegate>)delegate;


/*! @brief 检查微信是否已被用户安装
 *
 * @return 微信已安装返回YES，未安装返回NO。
 */
+ (BOOL)isZPAppInstalled;



/*! @brief 判断当前微信的版本是否支持OpenApi
 *
 * @return 支持返回YES，不支持返回NO。
 */
+ (BOOL)isWXAppSupportApi;



/*! @brief 获取微信的itunes安装地址
 *
 * @return 微信的安装地址字符串。
 */
+ (NSString *)getWXAppInstallUrl;



/*! @brief 获取当前微信SDK的版本号
 *
 * @return 返回当前微信SDK的版本号
 */
+ (NSString *)getApiVersion;

/*! @brief 发送请求到微信，等待微信返回onResp
 *
 * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
 * SendAuthReq、SendMessageToWXReq、PayReq等。
 * @param req 具体的发送请求。
 * @param completion 调用结果回调block
 */
+ (void)sendReq:(ZPBaseRequest *)req completion:(void (^ __nullable)(BOOL success))completion;

/*! @brief 收到微信onReq的请求，发送对应的应答给微信，并切换到微信界面
 *
 * 函数调用后，会切换到微信的界面。第三方应用程序收到微信onReq的请求，异步处理该请求，完成后必须调用该函数。可能发送的相应有
 * GetMessageFromWXResp、ShowMessageFromWXResp等。
 * @param resp 具体的应答内容
 * @param completion 调用结果回调block
 */
+ (void)sendResp:(ZPBaseRespones*)resp completion:(void (^ __nullable)(BOOL success))completion;


@end

NS_ASSUME_NONNULL_END
