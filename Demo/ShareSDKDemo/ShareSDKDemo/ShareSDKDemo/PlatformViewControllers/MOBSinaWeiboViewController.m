//
//  MOBMessengerViewController.m
//  ShareSDKDemo
//
//  Created by youzu on 17/3/7.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MOBSinaWeiboViewController.h"

@interface MOBSinaWeiboViewController ()

@end

@implementation MOBSinaWeiboViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    platformType = SSDKPlatformTypeSinaWeibo;
    self.title = @"新浪微博";
    shareIconArray = @[@"textIcon",@"textAndImageIcon",@"webURLIcon",@"textIcon",@"textAndImageIcon",];
    shareTypeArray = @[@"文字 SDK",@"文字+图片 SDK",@"链接 SDK",@"文字 api",@"文字+图片 api"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareLink",@"shareTextByAPI",@"shareImageByAPI"];
}

- (void)shareText
{
    //v4.0.1 不在区分网页与客户端 有客户端则有限调用客户端进行分享 无客户端则调用SDK自带分享页面
    //此页面不需要设置 安全域名 并可以分享话题 如果希望使用api进行分享则参考 shareTextByAPI shareImageByAPI
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
    //平台定制
    //    [parameters SSDKSetupSinaWeiboShareParamsByText:@"Share SDK http://www.mob.com/"
    //                                              title:nil
    //                                              image:nil
    //                                                url:nil
    //                                           latitude:0
    //                                          longitude:0
    //                                           objectID:nil
    //                                               type:SSDKContentTypeText];
    [self shareWithParameters:parameters];
}

- (void)shareImage
{
    //v4.0.1 不在区分网页与客户端 有客户端则有限调用客户端进行分享 无客户端则调用SDK自带分享页面
    //此页面不需要设置 安全域名 并可以分享话题 如果希望使用api进行分享则参考 shareTextByAPI shareImageByAPI
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    //平台定制
    //    [parameters SSDKSetupSinaWeiboShareParamsByText:@"Share SDK"
    //                                              title:nil
    //                                              image:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
    //                                                url:nil
    //                                           latitude:0
    //                                          longitude:0
    //                                           objectID:nil
    //                                               type:SSDKContentTypeImage];
    [self shareWithParameters:parameters];
}

- (void)shareLink
{
    //v4.0.1 不在区分网页与客户端 有客户端则有限调用客户端进行分享 无客户端则调用SDK自带分享页面
    //此页面不需要设置 安全域名 并可以分享话题 如果希望使用api进行分享则参考 shareTextByAPI shareImageByAPI
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters SSDKSetupShareParamsByText:@"Share SDK Link Desc"
                                    images:[UIImage imageNamed:@"COD13.jpg"]
                                       url:[NSURL URLWithString:@"http://www.mob.com"]
                                     title:@"MOB"
                                      type:SSDKContentTypeWebPage];
    //平台定制
    //    [parameters SSDKSetupSinaWeiboShareParamsByText:@"Share SDK Link Desc"
    //                                              title:@"Share SDK"
    //                                              image:[[NSBundle mainBundle] pathForResource:@"shareImg" ofType:@"png"]
    //                                                url:[NSURL URLWithString:@"https://www.mob.com"]
    //                                           latitude:0
    //                                          longitude:0
    //                                           objectID:nil
    //                                               type:SSDKContentTypeWebPage];
    
    [self shareWithParameters:parameters];
}


- (void)shareTextByAPI
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //text需要附 安全域
    [parameters SSDKSetupShareParamsByText:@"Share SDK http://www.mob.com"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
    [parameters SSDKEnableSinaWeiboAPIShare];
    //平台定制
    //    [parameters SSDKSetupSinaWeiboShareParamsByText:@"Share SDK http://www.mob.com/"
    //                                              title:nil
    //                                              image:nil
    //                                                url:nil
    //                                           latitude:nil
    //                                          longitude:nil
    //                                           objectID:nil
    //                                               type:SSDKContentTypeText];
    [self shareWithParameters:parameters];
}

- (void)shareImageByAPI
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //text需要附 安全域
    [parameters SSDKSetupShareParamsByText:@"Share SDK http://www.mob.com"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    [parameters SSDKEnableSinaWeiboAPIShare];
    //平台定制
    //    [parameters SSDKSetupSinaWeiboShareParamsByText:nil
    //                                              title:nil
    //                                              image:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
    //                                                url:nil
    //                                           latitude:nil
    //                                          longitude:nil
    //                                           objectID:nil
    //                                               type:SSDKContentTypeImage];
    [self shareWithParameters:parameters];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
