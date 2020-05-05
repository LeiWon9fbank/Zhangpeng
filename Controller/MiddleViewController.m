//
//  MiddleViewController.m
//  ZPSDK
//
//  Created by zhangpeng on 2020/4/29.
//  Copyright © 2020 zhangpeng. All rights reserved.
//

#import "MiddleViewController.h"

@interface MiddleViewController ()

@end

@implementation MiddleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)openAppWithUrl:(NSString *)openUrl{
    NSURL *backURL = [NSURL URLWithString:openUrl];
           //跳转回MyApp
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:backURL options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:backURL];
    }
}

@end
