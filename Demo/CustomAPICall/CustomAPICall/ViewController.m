//
//  ViewController.m
//  CustomAPICall
//
//  Created by fenghj on 15/7/1.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK+Base.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor grayColor];
    btn.frame = CGRectMake(0.0, 50, self.view.frame.size.width, 65);
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [btn setTitle:@"自定义接口调用" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(customAPICallButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customAPICallButtonClickHandler:(id)sender
{
    /**
     *  当需要非ShareSDK提供支持的接口（即除授权、分享、获取用户信息、好友列表、添加好友）时,需要调用ShareSDK的callApi方法进行API调用。
     *  首先需要取得API的调用地址，以及需要提交的请求的方式。以新浪微博为例，假如要获取用户微博列表，则需要先到http://open.weibo.com/wiki/2/statuses/user_timeline中查看该接口的地址以及其他信息。
     *  然后在根据这些要求填入callApi方法中。
     *  注：该方法位于ShareSDK+Base类目中，因此，在调用前需要先导入ShareSDK+Base.h头文件。
     */
    
    //下面示例用于演示如何获取个人的微博列表数据
    [ShareSDK callApi:SSDKPlatformTypeSinaWeibo                                     //指定是哪个平台的API请求
                  url:@"https://api.weibo.com/2/statuses/user_timeline.json"        //API的请求地址
               method:SSDKHttpMethodGet                                             //对应API文档上的HTTP请求方式
           parameters:nil                                                           //对应API文档上的请求参数
          onAuthorize:^(SSDKAuthorizeStateChangedHandler authorizeStateChangedHandler) {
              
              //当尚未授权或者授权过期时会回调此方法
              [ShareSDK authorize:SSDKPlatformTypeSinaWeibo
                         settings:nil
                   onStateChanged:authorizeStateChangedHandler];
              
          }
       onStateChanged:^(SSDKResponseState state, id data, NSError *error) {
           
           switch (state)
           {
               case SSDKResponseStateSuccess:
               {
                   NSLog(@"成功获取用户资料！模拟器下UIAlertView可能显示不出获取回来的数据，真机不会出现这种情况。");
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"调用API返回"
                                                                       message:[NSString stringWithFormat:@"%@", data]
                                                                      delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                             otherButtonTitles:nil];
                   [alertView show];
                   break;
               }
               case SSDKResponseStateFail:
               {
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"调用API失败"
                                                                       message:[NSString stringWithFormat:@"%@", error]
                                                                      delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                             otherButtonTitles:nil];
                   [alertView show];
                   break;
               }
               case SSDKResponseStateCancel:
               {
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"调用API已取消"
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
