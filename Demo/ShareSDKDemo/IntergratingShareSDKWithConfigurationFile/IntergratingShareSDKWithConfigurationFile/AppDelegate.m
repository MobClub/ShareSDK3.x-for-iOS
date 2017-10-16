//
//  AppDelegate.m
//  IntergratingShareSDKWithConfigurationFile
//
//  Created by 刘靖煌 on 16/7/29.
//  Copyright © 2016年 mob.com. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDKConnector/ShareSDKConnector.h>

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
//以下是新浪微博SDK的依赖库：
//ImageIO.framework
//libsqlite3.dylib
//AdSupport.framework

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//人人SDK头文件
#import <RennSDK/RennSDK.h>

//Kakao SDK头文件
#import <KakaoOpenSDK/KakaoOpenSDK.h>

//支付宝SDK
#import "APOpenAPI.h"

//易信SDK头文件
#import "YXApi.h"

//Facebook Messenger SDK
#import <FBSDKMessengerShareKit/FBSDKMessengerSharer.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //这个Demo配置了ShareSDK.xml文件，可以不调用ShareSDK的初始化方法，自动进行初始化。
    
    //对于QQ、微信、支付宝好友、易信、KaKao、Facebook Messenger等需要依赖原生SDK的平台，仍需要以下代码。
    [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
    [ShareSDKConnector connectAliSocial:[APOpenAPI class]];
    [ShareSDKConnector connectYiXin:[YXApi class]];
    [ShareSDKConnector connectKaKao:[KOSession class]];
    [ShareSDKConnector connectFacebookMessenger:[FBSDKMessengerSharer class]];
    
    //如需要使用新浪微博客户端分享、人人网SSO等，仍需要以下代码。
    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
    [ShareSDKConnector connectRenren:[RennClient class]];
    
    return YES;
}

@end
