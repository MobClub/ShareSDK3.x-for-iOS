//
//  ViewController.m
//  IntergratingShareSDKWithConfigurationFile
//
//  Created by 刘靖煌 on 16/7/29.
//  Copyright © 2016年 mob.com. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *configFileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    configFileButton.backgroundColor = [UIColor grayColor];
    [configFileButton setTitle:@"根据配置文件分享" forState:UIControlStateNormal];
    [configFileButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    configFileButton.frame = CGRectMake(0.0, 20, self.view.frame.size.width, 50);
    configFileButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [configFileButton addTarget:self action:@selector(shareByContentName) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:configFileButton];
    
    UIButton *customFieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customFieldButton.backgroundColor = [UIColor grayColor];
    [customFieldButton setTitle:@"根据配置文件分享(可选-自定义字段)" forState:UIControlStateNormal];
    [customFieldButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    customFieldButton.frame = CGRectMake(0.0, 100, self.view.frame.size.width, 50);
    customFieldButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [customFieldButton addTarget:self action:@selector(shareByContentNameWithCustomField) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customFieldButton];
}

- (void)shareByContentName
{
    //根据项目中的配置文件ShareContent.xml的配置内容进行分享(本分享方法不含任何UI)
    
    //分享的内容会按照传入的contentName搜索对应的ShareContent.xml中的<Content>节点之name属性
    //使用以下接口请注意:
    //1.比需在项目中存在ShareContent.xml 文件，且符合xml文件格式, <Content>节点之name 属性填上您的标识
    //2.在下面接口的首个参数传入对应的<Content>节点的name
    
    [ShareSDK shareWithContentName:@"mob"
                          platform:SSDKPlatformTypeSinaWeibo
                      customFields:nil
                    onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                        
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

- (void)shareByContentNameWithCustomField
{
    //根据项目中的配置文件ShareContent.xml的配置内容进行分享(本分享方法不含任何UI)
    
    //分享的内容会按照传入的contentName搜索对应的ShareContent.xml中的<Content>节点之name属性
    //使用以下接口请注意:
    
    //1.比需在项目中存在ShareContent.xml 文件，且符合xml文件格式, <Content>节点之name 属性填上您的标识
    
    //2.在下面接口的首个参数传入对应的<Content>节点的name
    
    //3.(可选)通过自定义一本字典,并定义其key和value。其中value的值为你在ShareContent.xml文件中<Content>节点中以"{}"括起来的内容。
    //例如 :NSDictionary *customFields = @{@"imgUrl" : imgPath};
    //那么 节点中某个地方就应该使用 "{imgUrl}",两边字段一旦吻合,imgPath 就会替代 "{imgUrl}"中的内容(大括号也会被取代)
    //通过此种方式，就可以实现任意自定义字段的替换;你也可以随时动态改变传如的customFields 字典，来实现动态的分享内容的改变。
    
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"jpg"];
    
    if (imgPath)
    {
        NSDictionary *customFields = @{@"imgUrl" : imgPath};
        
        [ShareSDK shareWithContentName:@"sharesdk"
                              platform:SSDKPlatformTypeSinaWeibo
                          customFields:customFields
                        onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                            
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
}


@end
