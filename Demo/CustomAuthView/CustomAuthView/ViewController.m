//
//  ViewController.m
//  CustomAuthView
//
//  Created by fenghj on 15/7/1.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "ViewController.h"
#import "AuthViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ShareSDK+Base.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //自定义授权视图方式1
    UIButton *customAuthViewButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    customAuthViewButton1.backgroundColor = [UIColor grayColor];
    [customAuthViewButton1 setTitle:@"自定义授权视图样式 - 1" forState:UIControlStateNormal];
    [customAuthViewButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    customAuthViewButton1.frame = CGRectMake(0.0, 20, self.view.frame.size.width, 50);
    customAuthViewButton1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:customAuthViewButton1];
    [customAuthViewButton1 addTarget:self action:@selector(customAuthViewButton1ClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    //自定义授权视图方式2
    UIButton *customAuthViewButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    customAuthViewButton2.backgroundColor = [UIColor grayColor];
    [customAuthViewButton2 setTitle:@"自定义授权视图样式 - 2" forState:UIControlStateNormal];
    [customAuthViewButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    customAuthViewButton2.frame = CGRectMake(0.0, customAuthViewButton1.frame.origin.y + customAuthViewButton1.frame.size.height + 10, self.view.frame.size.width, 50);
    customAuthViewButton2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:customAuthViewButton2];
    [customAuthViewButton2 addTarget:self action:@selector(customAuthViewButton2ClickHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customAuthViewButton1ClickHandler:(id)sender
{
    /**
     *  方式一：在原有的授权视图基础上进行一些简单的调整，如：导航栏颜色、背景、标题等等。这些ShareSDK提供的SSDKAuthViewStyle类来进行快捷的样式调整。
     */
    [SSDKAuthViewStyle setNavigationBarBackgroundColor:[UIColor blueColor]];
    [SSDKAuthViewStyle setTitle:@"自定义授权视图 - 1"];
    [SSDKAuthViewStyle setTitleColor:[UIColor yellowColor]];
    
    [ShareSDK authorize:SSDKPlatformTypeSinaWeibo
               settings:nil
         onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
    {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateCancel:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权已取消"
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

- (void)customAuthViewButton2ClickHandler:(id)sender
{
    /**
     *  方式二：ShareSDK+Base类目中提供了一个authorize方法的另外一个版本，可以允许在弹出授权视图时实现更高级别的自定义。
     */
    __weak ViewController *theController = self;
    [ShareSDK authorize:SSDKPlatformTypeSinaWeibo
               settings:nil
          onViewDisplay:^(UIView<ISSDKAuthView> *view)
    {
              
              //在此回调中进行授权视图自定义
              AuthViewController *vc = [[AuthViewController alloc] initWithAuthView:view];
              UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
              [theController presentModalViewController:nvc animated:YES];
              
          }
         onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权成功"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权失败"
                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"授权已取消"
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
