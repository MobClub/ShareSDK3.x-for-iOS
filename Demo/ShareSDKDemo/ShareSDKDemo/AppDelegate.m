//
//  AppDelegate.m
//  ShareSDKDemo
//
//  Created by youzu on 17/3/6.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "YXApi.h"
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

#import <LineSDK/LineSDK.h>

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <MPShareSDK/MPShareSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


NSString *const shareSDKAppKey = @"1a131fa890c30";

//shareSDK 注册方法
- (void)_registerShare
{
    //平台注册
    NSArray *platforems = @[
                            @(SSDKPlatformTypeFacebook),
                            @(SSDKPlatformTypeFacebookMessenger),
                            @(SSDKPlatformTypeInstagram),
                            @(SSDKPlatformTypeTwitter),
                            @(SSDKPlatformTypeLine),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeYouTube),
                            @(SSDKPlatformTypeMeiPai),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeSinaWeibo)
                            ];
    [ShareSDK registerApp:shareSDKAppKey
          activePlatforms:platforems
                 onImport:^(SSDKPlatformType platformType) {
                     switch (platformType) {
                         case SSDKPlatformTypeFacebookMessenger:
                             //使用官方SDK时需加载此方法 如去SDK则不用写
                             [ShareSDKConnector connectFacebookMessenger: [FBSDKMessengerSharer class]];
                             break;
                         case SSDKPlatformTypeQQ:
                             [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeLine:
                             //不使用line登录可以不用设置
                             [ShareSDKConnector connectLine:[LineSDKLogin class]];
                             break;
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:nil];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         case SSDKPlatformTypeMeiPai:
                             [ShareSDKConnector connectMeiPai:[MPShareSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:@"100371282"
                                           appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                         authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeFacebook:
                  //设置 替换默认授权权限
//                  [appInfo SSDKSetAuthSettings:@[
//                                                 @"public_profile",//默认(无需审核)
//                                                 @"user_friends",//好友列表(无需审核)
//                                                 @"email",//邮箱(无需审核)
//                                                 @"user_about_me",//用户个人说明(需审核)
//                                                 @"publish_actions",//应用内分享 必要权限(需审核)
//                                                 @"user_videos"//应用内视频分享 必要权限(需审核)
//                                                 ]];
                      [appInfo SSDKSetupFacebookByApiKey:@"107704292745179"
                                               appSecret:nil
                                             displayName:@"shareSDK"
                                                authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeTwitter:
                      [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy"
                                              consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G"
                                                 redirectUri:@"http://mob.com"];
                      break;
                  case SSDKPlatformTypeTumblr:
                      [appInfo SSDKSetupTumblrByConsumerKey:@"2QUXqO9fcgGdtGG1FcvML6ZunIQzAEL8xY6hIaxdJnDti2DYwM"
                                             consumerSecret:@"3Rt0sPFj7u2g39mEVB3IBpOzKnM3JnTtxX2bao2JKk4VV1gtNo"
                                                callbackUrl:@"tumblrauthexample://tumblr-authorize"];
                      break;
                  case SSDKPlatformTypeWechat:
//                      //微信登陆使用此appID
//                      [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      //微信小程序使用此appID
                      [appInfo SSDKSetupWeChatByAppId:@"wxd930ea5d5a258f4f"
                                            appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                      break;
                  case SSDKPlatformTypeYouTube:
                      [appInfo SSDKSetupYouTubeByClientId:@"906418427202-jinnbqal1niq4s8isbg2ofsqc5ddkcgr.apps.googleusercontent.com"
                                             clientSecret:@""
                                              redirectUri:@"http://localhost"];
                      break;
                  case SSDKPlatformTypeMeiPai:
                      [appInfo SSDKSetupMeiPaiByAppKey:@"1089867596"];
                      break;
                  case SSDKPlatformTypeInstagram:
                      [appInfo SSDKSetupInstagramByClientID:@"ff68e3216b4f4f989121aa1c2962d058"
                                               clientSecret:@"1b2e82f110264869b3505c3fe34e31a1"
                                                redirectUri:@"http://sharesdk.cn"];
                      break;
                  case SSDKPlatformTypeSinaWeibo:
                  //增加默认权限 关注官方微博
//                   [appInfo SSDKSetAuthSettings:@[@"follow_app_official_microblog"]];
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                              redirectUri:@"http://www.sharesdk.cn"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                  default:
                      break;
              }
          }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self _registerShare];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
