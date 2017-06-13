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
    authTypeArray = @[@"授权"];
    authSelectorNameArray = @[@"authAct"];
    shareTypeArray = @[@"文字 应用内",@"文字+图片 应用内",@"文字 应用内高级接口",@"文字+图片 应用内高级接口",@"文字 APP",@"文字+图片 APP",@"链接 APP"];
    selectorNameArray = @[@"shareText",@"shareImage",@"shareTextAdvanced",@"shareImageAdvanced",@"shareTextToAPP",@"shareImageToAPP",@"shareLinkToAPP"];
    
}

/**
 授权
 */
- (void)authAct
{
    [super authAct];
}

/**
 分享文字
 */
- (void)shareText
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置 文字中必须有绑定域下的URL链接
    //绑定域在新浪开放平台“我的应用 － 应用信息 － 基本应用信息编辑 － 安全域名”里设置。
    [parameters SSDKSetupShareParamsByText:@"Share SDK http://www.mob.com/"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
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

/**
 分享图片
 */
- (void)shareImage
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置 文字中必须有绑定域下的URL链接
    //绑定域在新浪开放平台“我的应用 － 应用信息 － 基本应用信息编辑 － 安全域名”里设置。
    [parameters SSDKSetupShareParamsByText:@"http://www.mob.com/"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    //平台定制
//    [parameters SSDKSetupSinaWeiboShareParamsByText:@"http://www.mob.com/"
//                                              title:nil
//                                              image:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
//                                                url:nil
//                                           latitude:nil
//                                          longitude:nil
//                                           objectID:nil
//                                               type:SSDKContentTypeImage];
    [self shareWithParameters:parameters];
}

- (void)shareTextAdvanced
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    //2017年6月30日后需申请高级权限
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
    [parameters SSDKEnableAdvancedInterfaceShare];
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

- (void)shareImageAdvanced
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    //2017年6月30日后需申请高级权限
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    [parameters SSDKEnableAdvancedInterfaceShare];
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

- (void)shareTextToAPP
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:nil
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeText];
    [parameters SSDKEnableUseClientShare];
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

- (void)shareImageToAPP
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters SSDKSetupShareParamsByText:@"Share SDK"
                                    images:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    [parameters SSDKEnableUseClientShare];
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

- (void)shareLinkToAPP
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    [parameters SSDKSetupShareParamsByText:@"Share SDK Link Desc"
                                    images:[UIImage imageNamed:@"COD13.jpg"]
                                       url:[NSURL URLWithString:@"http://www.mob.com"]
                                     title:@"MOB"
                                      type:SSDKContentTypeWebPage];
    [parameters SSDKEnableUseClientShare];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
