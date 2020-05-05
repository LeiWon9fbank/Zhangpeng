//
//  ZPApi.m
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "ZPApi.h"
#import "ZPBaseRequest.h"
#import "ZPBaseRespones.h"
#import "MiddleViewController.h"
#import "ZPAuthReuest.h"
#import "ZPShareRequest.h"
#import "Tools.h"
#import "ZPAuthModel.h"
#import "Network.h"
#import "ZPAuthRespones.h"
@interface ZPApi ()<ZPApiDelegate>

@property (nonatomic, weak) id<ZPApiDelegate> delegate;

@end

@implementation ZPApi

//第一步拉起微信，调用微信的sendReq方法发送一个请求，请求的内容，第三方只需要填写请求和回调的状态，和这个请求的作用域
//微信SDK的sendReq方法被调用后，首先判断是否本机安装有微信SDK（即尝试打开weixin://）,如果没有提示尚未安装，直接return，如果有，则进行下一步，检查当前App是否向SDK后台注册过AppId等信息，如果没注册过，返回失败，如果注册过，直接拉起微信App，可通过universalLink,也可以通过URLType，带参数传给微信，进入微信的授权页，微信根据被启动时传过来的oauth/share判断是授权还是分享
//接下来的步骤在微信App中完成，收到参数以后，微信App的授权页首先根据参数去后台获取当前登录账户的所有信息并展示出来，提示用户是否允许获取相关信息，点拒绝，则授权失败，通过universalLink回到第三方App中，如果点同意，则由后台生成code，拿到code后微信App通过AppId,打开第三方App，并传aouth/code="";
//第三方App在- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options;中将收到微信回到App的请求和参数，再通过微信的handleOpenUrl方法打开微信返回的url地址，此时将代理绑定到self上
//微信SDK方面，收到三方App调用handleOpenUrl以后，把响应代理的方法绑定并返回给三方App，带传值Code
//第三方App在微信SDK的代理方法中将收到的code发送给自己的服务端，至此SDK授权功能结束，接下来的流程由自己的服务端去获取token和用户信息，拿到用户信息后再返回给第三方App提示登录成功和失败

/*-----------------------------*/
//微信分享
//构建微信分享结构体，消息可分为文本、多媒体，指定多想，消息类型

//消息构建完成后，通过sendReq方法发送请求，接下来由SDK托管
//SDK的send方法被调起以后，校验是否安装有微信，如果没有安装，不能打开app，如果能打开，进入App，接下来的过程由微信App托管
//微信App被打开后，通过host判断是否是分享，如果是分享，校验是否有权限，有权限，则把传进来的会话内容解析，然后打开最近会话列表，用户选择会话后把消息发送进去，提示发送成功弹窗，询问返回三方App还是留在微信，如果选择返回三方App，则回调到三方App方法中，由三方自己取值成功和失败进行提示

+ (BOOL)registerApp:(NSString *)appid universalLink:(NSString *)universalLink{
    //appid和universallink存入后台，获取到其他数据也存入后台，用于身份校验使用
    //返回成功于失败，只有返回成功，才可以调取
    //把App信息上传给服务端
    NSDictionary *infoDictionary= [[NSBundle mainBundle] infoDictionary];

    // app名称

    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    NSLog(@"手机app_Name: %@",app_Name);

    // app版本

    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"手机app_Version : %@",app_Version);

    // app build版本

    NSString* app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"手机app_build  : %@",app_build);


    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@",userPhoneName);

    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];

    NSLog(@"设备名称: %@",deviceName);

    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];

    NSLog(@"手机系统版本: %@",phoneVersion);

    //手机型号

    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel);
    return YES;
}

+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity delegate:(id<ZPApiDelegate>)delegate{
    //回调给其他appcode和掌朋的，拿到code后打开掌朋，
    return YES;
}

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<ZPApiDelegate>)delegate{
    //目前来看此方法是为了校验是否授权成功或分享成功，三方App拿到返回的url以后打开这个方法，SDK通过携带参数向后台请求，根据结果返回不通的resp;第三方App接受了代理，可以拿到代理传的值
    
    if (delegate) {
        ZPAuthRespones *authResp = [[ZPAuthRespones alloc]init];
        authResp.code = @"12345678";
        [delegate zpOnResp:authResp];
    }
    return YES;
}


+ (void)sendReq:(ZPBaseRequest *)req completion:(void (^)(BOOL))completion{
    NSLog(@"准备调起app");
    
    if (req.type == 0) {//授权登录
        [ZPAuthModel getRequestUrl:@"https://www.baidu.com" complete:^(id  _Nonnull responseObject, NSInteger code, NSString * _Nonnull message) {
            NSLog(@"code:%ld--->res:%@--->message%@",code,responseObject,message);
            if (code == 1) {
                ZPAuthReuest *authReq = (ZPAuthReuest *)req;
                
                //    校验合法性，鉴权，进入app
                NSString *backURLString = [NSString stringWithFormat:@"zhangpeng://zpauth?scope=%@&state=%@",authReq.scope,authReq.state];
                MiddleViewController *vc = [[MiddleViewController alloc]init];
                [vc openAppWithUrl:backURLString];
            }
        } failure:^(id  _Nonnull responseObject, NSInteger code, NSString * _Nonnull message) {
            if (completion) {
                completion(NO);
            }
        }];
        
    }else if (req.type == 1){//分享
        [ZPAuthModel getRequestUrl:@"https://www.baidu.com" complete:^(id  _Nonnull responseObject, NSInteger code, NSString * _Nonnull message) {
            NSLog(@"code:%ld--->res:%@--->message%@",code,responseObject,message);
            if (code == 1) {
                ZPShareRequest *shareReq = (ZPShareRequest *)req;
                NSString *backURLString2;
                
                if (shareReq.bText) {
                    if ([Tools isBlankString:shareReq.text]) {
                        if (completion) {
                            completion(NO);
                        }
                    }
                }else{
                    if ([Tools isBlankString:shareReq.imgUrl]) {
                        if (completion) {
                            completion(NO);
                        }
                    }
                }
                
                if (shareReq.bText) {//文本信息，不管img
                    backURLString2 = [NSString stringWithFormat:@"zhangpeng://zpshare?text=%@&bText=1",[shareReq.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
                }else{//非文本信息，就是图片地址，不管text
                    backURLString2 = [NSString stringWithFormat:@"zhangpeng://zpshare?imgUrl=%@&bText=0",[shareReq.imgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
                }
                
                MiddleViewController *vc = [[MiddleViewController alloc]init];
                [vc openAppWithUrl:backURLString2];
            }
        } failure:^(id  _Nonnull responseObject, NSInteger code, NSString * _Nonnull message) {
            if (completion) {
                completion(NO);
            }
        }];
    }


    if (completion) {
        completion(NO);
    }
}

+ (void)sendResp:(ZPBaseRespones *)resp completion:(void (^)(BOOL))completion{
   
    if (completion) {
        completion(YES);
    }
}
@end
