//
//  Network.m
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/28.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "Network.h"
#import "AFNetworking.h"
#import "NSString+Base64.h"
#import "NSObject+Sign.h"
#import "NSDictionary+FuYanParamaters.h"
#define TIMEOUT 90.0f

#define HOST @"https://aiskin.91jierong.com"    // 生产环境
#define PATH @"public/index.php/verify/verify/verify"

#define ENCODE_KEY @"hfxy123"                           // 参数加密 key
#define SIGN_KEY   @"szhfxy20191021developgo886997yan"  // 签名 key

@implementation Network
+ (Network *)sharedManager{
    static Network *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}

//更新AFN后 AFHTTPRequestOperationManager --> AFHTTPSessionManager (详见参阅http://www.jianshu.com/p/047463a7ce9b )
-(AFHTTPSessionManager *)baseHtppRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    
 
//    // 设置超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 30.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //header 设置
    
    //    [manager.requestSerializer setValue:K_PASS_IP forHTTPHeaderField:@"Host"];
    //    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    //    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //    [manager.requestSerializer setValue:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    //    [manager.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    //    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" forHTTPHeaderField:@"User-Agent"];
    
    AFJSONResponseSerializer *responseSerializer=[AFJSONResponseSerializer serializer];
    AFHTTPRequestSerializer *resquertSerializer=[AFHTTPRequestSerializer serializer];
    [manager setRequestSerializer:resquertSerializer];
    [manager setResponseSerializer:responseSerializer];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json" , nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/javascript",@"application/json",@"text/json", @"text/javascript", nil];
    
    return manager;
}

-(void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url complete:(void(^)(id responseObject,NSInteger code, NSString *message))complete
{
    AFHTTPSessionManager *manager = [self baseHtppRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject){
//        successBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        failureBlock(errorStr);
//    }];
    [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        
        NSString *message = responseObject[@"msg"];
        
        complete(responseObject, 1,message);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (complete) {
            complete(nil, 999999 ,error.localizedDescription);
        }

    }];
}

- (void)POST:(NetworkFlag)flag paramaters:(NSDictionary *)paramaters complete:(void(^)(id responseObject, NSInteger code, NSString *message))complete {
    NSDictionary *params = [self makeParamaters:paramaters flag:flag];

    NSLog(@"Sign: %@", params);
    NSString *urlStr = [[NSString stringWithFormat:@"%@/%@", HOST, PATH] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//    NSString *URL = [[NSString stringWithFormat:@"%@/%@", HOST, PATH] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    NSString *URL = [[NSString stringWithFormat:@"%@/%@", HOST, PATH] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSLog(@"<------>%@---------->%lu",params,(unsigned long)flag);
    
    
#if DEBUG
//    NSMutableDictionary *md = [params mutableCopy];
//    [md parametersDecodeWithKey:ENCODE_KEY];
//    NSLog(@"Decode: %@", md);
#endif
    
#if USE_JSON
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
//    [[[AFHTTPSessionManager manager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (complete) {
//            complete(responseObject, error);
//        }
//    }] resume];
#else
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [self baseHtppRequest];

//    manager.responseSerializer.acceptableContentTypes = ({
//        NSMutableSet *types = [manager.responseSerializer.acceptableContentTypes mutableCopy];
//        [types addObject:@"text/html"];
//        types;
//    });
     
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"Resp: %@", responseObject);
        if (complete) {
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            NSInteger flag = [[[params valueForKey:@"flag"] base64DecodedString] integerValue];
            NSString *message = responseObject[@"msg"];
            
            if (code == 1) {

                NSLog(@"当前调用接口 ->%ld  ，返回信息 = %@  , 解密参数=%@",(long)flag, message, flag == 910101 ? responseObject : [self decodeResult:responseObject]);
                @try {
                    if (flag == 910101) {
                        complete(@"验证码已发送至手机，请注意查收", code,message);
                    }else if (flag == 910121){
                        complete([responseObject[@"data"] base64DecodedString], code,message);

                    }else{
                        complete([self decodeResult:responseObject],code, message);
                    }

                } @catch (NSException *exception) {
                    complete(responseObject,code ,exception.reason);
                }
            }else{
                complete(responseObject, code ,message);
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Error: %@", error);
        if (complete) {
            complete(nil, error.code ,error.localizedDescription);
        }
    }];
#endif
}

//  字典转json格式字符串：
//  NSJSONWritingPrettyPrinted  是有换位符的。
//  如果NSJSONWritingPrettyPrinted 是nil 的话 返回的数据是没有 换位符的
- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/// 对请求结果 data 字段 解密 & 解析
/// @param responseObject 请求结果字典
- (id)decodeResult:(NSDictionary *)responseObject {
    NSString *dataString = [responseObject[@"data"] base64DecodedString];
    NSData *JSONData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil]; //NSJSONReadingMutableLeaves
    
    if ([responseDic isKindOfClass:[NSArray class]]) {
        return [self nullArr:(NSArray *)responseDic];
    }else if ([responseDic isKindOfClass:[NSDictionary class]]){
        return [self nullDic:responseDic];
    }else{
         return responseDic;
    }
}

/// 处理参数
/// @param params 输入参数
- (NSDictionary *)makeParamaters:(NSDictionary *)params flag:(NetworkFlag)flag {
    // 1. 补全公共参数
    NSMutableDictionary *temp = [self commonParamaters:params flag:flag];
    // 2. 计算 sign
    NSString *sign = [temp signWithKey:SIGN_KEY];
    // 3. 参数加密
//    [temp parametersEncodeWithKey:ENCODE_KEY];
    
    // 4. 加入 sign
    [temp setValue:sign forKey:@"sign"];
    
    NSArray *keysArray = [temp allKeys];
    for (int i = 0; i < keysArray.count; i++) {
        NSString *key = keysArray[i];
        NSString *value = temp[key];
        if ([key isEqualToString:@"sign"]) {

        }else{
            [temp setValue:[value base64EncodedString] forKey:key];
        }
    }
    return temp;
}

/// 补充公共参数
/// @param params 输入参数
- (NSMutableDictionary *)commonParamaters:(NSDictionary *)params flag:(NetworkFlag)flag {
    NSMutableDictionary *temp = [params mutableCopy];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    NSString *version = @"1";
    
    if (flag == 910188) {
        [temp setValuesForKeysWithDictionary:@{
            @"flag"    : [NSString stringWithFormat:@"%ld", flag],
            @"time"    : timestamp,
            @"version" : version
        }];
    }else if(flag == 910180){
        [temp setValuesForKeysWithDictionary:@{
            @"flag"    : [NSString stringWithFormat:@"%ld", flag],
            @"time"    : timestamp,
            @"version" : @"2"
        }];
    }else{
        [temp setValuesForKeysWithDictionary:@{
            @"flag"    : [NSString stringWithFormat:@"%ld", flag],
            @"time"    : timestamp,
            @"version" : version
        }];
    }
    
    
    return temp;
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
- (id)changeType:(id)myObj{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}

//将NSDictionary中的Null类型的项目转化成@""
- (NSDictionary *)nullDic:(NSDictionary *)myDic{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
- (NSArray *)nullArr:(NSArray *)myArr{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}


//将NSString类型的原路返回

- (NSString *)stringToString:(NSString *)string{
    return string;
}

//将Null类型的项目转化成@""
- (NSString *)nullToString{
    return @"";
}
@end
