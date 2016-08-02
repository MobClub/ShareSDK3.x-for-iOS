//
//  ViewController.m
//  IntegrationDemo
//
//  Created by fenghj on 15/6/29.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建一个分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.backgroundColor = [UIColor grayColor];
    [shareButton setTitle:@"直接分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0.0, 20, self.view.frame.size.width, 50);
    shareButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [shareButton addTarget:self action:@selector(shareButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    UIButton *showAction = [UIButton buttonWithType:UIButtonTypeCustom];
    showAction.backgroundColor = [UIColor grayColor];
    [showAction setTitle:@"使用ShareSDK提供的分享UI分享" forState:UIControlStateNormal];
    [showAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    showAction.frame = CGRectMake(0.0, 90, self.view.frame.size.width, 50);
    showAction.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [showAction addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showAction];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"以下开关可改变ShareSDK提供的UI的风格";
    label.frame = CGRectMake(0.0, 160, self.view.frame.size.width, 50);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:label];
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0.0, 210, self.view.frame.size.width, 50)];
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchView];
}

-(void)switchAction:(UISwitch*)sender
{
    if(sender.isOn)
    {
        //更换分享菜单栏风格
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    }
    else
    {
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSystem];
    }
    
    //自定义分享菜单栏（非必要）
//    [SSUIShareActionSheetStyle setStatusBarStyle:UIStatusBarStyleLightContent];
//    [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:137/255.0 green:142/255.0 blue:150/255.0 alpha:0.8]];
//    [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
//    [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
//    [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
//    [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
//    [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
//    [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
//    [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
//    [SSUIShareActionSheetStyle setSupportedInterfaceOrientation:UIInterfaceOrientationMaskPortrait];
    
    //自定义支持的屏幕方向
//    [ShareSDK setSupportedInterfaceOrientation:UIInterfaceOrientationMaskPortrait];
}

- (void)showActionSheet:(id)sender
{
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    if (imageArray)
    {
        [shareParams SSDKSetupShareParamsByText:@"分享内容 @value(url)"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
    }
    
    //2、分享
    [ShareSDK showShareActionSheet:sender
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state)
                   {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@", error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}

/**
 *  分享按钮点击事件
 *
 *  @param sender 事件对象
 */
- (void)shareButtonClickHandler:(id)sender
{
    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    if (imageArray)
    {
        [shareParams SSDKSetupShareParamsByText:@"分享内容 @value(url)"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
    }
    
    //2、分享
    [ShareSDK share:SSDKPlatformTypeSinaWeibo
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
    {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             default:
                 break;
         }
     }];
}

@end
