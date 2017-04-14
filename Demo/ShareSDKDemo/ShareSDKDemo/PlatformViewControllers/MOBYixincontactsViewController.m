//
//  MOBMessengerViewController.m
//  ShareSDKDemo
//
//  Created by youzu on 17/3/7.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MOBYixincontactsViewController.h"

@interface MOBYixincontactsViewController ()

@end

@implementation MOBYixincontactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    platformType = SSDKPlatformSubTypeYiXinSession;
    self.title = @"易信好友";
    authTypeArray = @[@"授权"];
    authSelectorNameArray = @[@"authAct"];
    shareTypeArray = @[@"文字",@"图片",@"链接",@"APP",@"音频",@"视频"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareLink",@"shareAPP",@"shareAudio",@"shareVideo"];
    otherTypeArray = @[@"是否安装客户端"];
    otherSelectorNameArray = @[@"isInstallAPP"];
}

/**
 授权
 */
- (void)authAct
{
    [super authAct];
}

-(void)isInstallAPP
{
    [super isInstallAPP];
}

/**
 分享文字
 */
- (void)shareText
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
    //平台定制
//    [parameters SSDKSetupQQParamsByText:@"Share SDK"
//                                  title:nil
//                                    url:nil
//                          audioFlashURL:nil
//                          videoFlashURL:nil
//                             thumbImage:nil
//                                 images:nil
//                                   type:SSDKContentTypeText
//                     forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    [self shareWithParameters:parameters];
}

/**
 分享图片
 */
- (void)shareImage
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    //平台定制
//    [parameters SSDKSetupQQParamsByText:@"Share SDK"
//                                  title:nil
//                                    url:nil
//                          audioFlashURL:nil
//                          videoFlashURL:nil
//                             thumbImage:nil
//                                 images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
//                                   type:SSDKContentTypeImage
//                     forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    [self shareWithParameters:parameters];
}

- (void)shareLink
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:@"Share SDK Link Desc"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:[NSURL URLWithString:@"https://www.mob.com"]
                                     title:@"Share SDK"
                                      type:SSDKContentTypeWebPage];
    //平台定制
//    [parameters SSDKSetupQQParamsByText:@"Share SDK Link Desc"
//                                  title:@"Share SDK"
//                                    url:[NSURL URLWithString:@"https://www.mob.com"]
//                          audioFlashURL:nil
//                          videoFlashURL:nil
//                             thumbImage:nil
//                                 images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
//                                   type:SSDKContentTypeWebPage
//                     forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
    [self shareWithParameters:parameters];
}

- (void)shareAPP
{
    
}

- (void)shareAudio
{
    
}

- (void)shareVideo
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
