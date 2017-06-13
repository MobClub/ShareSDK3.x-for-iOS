//
//  MobMoreViewController.m
//  ShareSDKDemo
//
//  Created by youzu on 17/3/24.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MobMoreViewController.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "MOBLoadingViewController.h"
#import <ShareSDK/SSDKVideoUploadCenter.h>

@interface MobMoreViewController ()
{
    NSArray *titelArray;
    NSArray *selectorNameArray;
    
    MOBLoadingViewController *loadingViewController;
    SSDKHttpServiceModel *httpServiceModel;
}

@end

@implementation MobMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"分享菜单";
    titelArray = @[@"分享菜单 Auto",@"分享菜单 视频"];
    selectorNameArray = @[@"shareMenu",@"shareMenuVideo"];
}


/**
 分享菜单
 */
- (void)shareMenu
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[@"http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg"];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    //设置微博使用高级接口
    //2017年6月30日后需申请高级权限
    [shareParams SSDKEnableAdvancedInterfaceShare];
    //设置显示平台 只能分享视频的YouTube MeiPai 不显示
    NSArray *items = @[
                      @(SSDKPlatformTypeFacebook),
                      @(SSDKPlatformTypeFacebookMessenger),
                      @(SSDKPlatformTypeInstagram),
                      @(SSDKPlatformTypeTwitter),
                      @(SSDKPlatformTypeLine),
                      @(SSDKPlatformTypeQQ),
                      @(SSDKPlatformTypeWechat),
                      @(SSDKPlatformTypeSinaWeibo)
                      ];
    
    [ShareSDK showShareActionSheet:self.view
                             items:items
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           //设置UI等操作
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Instagram、Line等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeInstagram)
                           {
                               break;
                           }
                           
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
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
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
 分享菜单 视频
 */
- (void)shareMenuVideo
{
    
    //设置显示平台 不支持视频分享的 新浪微博 不加入 朋友圈官方暂不支持视频分享 qq好友不支持分享视频
    
    //Facebook 相册视频 客户端分享 , 本地视频 使用应用内分享
    //FacebookMessager 支持 本地视频 和 相册视频 客户端分享
    //Instagram 支持 本地视频 和 相册视频 客户端分享
    //Twitter 支持 本地视频 应用内分享
    //YouTube 支持 本地视频 应用内分享
    //QZone 只支持相册视频 客户端分享
    //微信好友&收藏 只支持本地文件 客户端分享
    //美拍 支持 本地视频 和 相册视频 客户端分享
    NSArray *items = @[
                       @(SSDKPlatformTypeFacebook),
                       @(SSDKPlatformTypeFacebookMessenger),
                       @(SSDKPlatformTypeInstagram),
                       @(SSDKPlatformTypeTwitter),
                       @(SSDKPlatformTypeYouTube),
                       @(SSDKPlatformSubTypeQZone),
                       @(SSDKPlatformSubTypeWechatSession),
                       @(SSDKPlatformSubTypeWechatFav),
                       @(SSDKPlatformTypeMeiPai),
                       ];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //优先使用平台客户端分享
    [shareParams SSDKEnableUseClientShare];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"];
    [shareParams SSDKSetupShareParamsByText:@"Share SDK"
                                     images:nil
                                        url:[NSURL fileURLWithPath:filePath]
                                      title:nil
                                       type:SSDKContentTypeVideo];
    //设置微信好友的视频分享
    [shareParams SSDKSetupWeChatParamsByText:@"share SDK"
                                      title:@"file"
                                        url:nil
                                 thumbImage:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                      image:nil
                               musicFileURL:nil
                                    extInfo:nil
                                   fileData:nil
                               emoticonData:nil
                        sourceFileExtension:@"mp4"
                             sourceFileData:[[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"]
                                       type:SSDKContentTypeFile
                         forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    //设置微信收藏的视频分享
    [shareParams SSDKSetupWeChatParamsByText:@"share SDK"
                                       title:@"file"
                                         url:nil
                                  thumbImage:[[NSBundle mainBundle] pathForResource:@"COD13" ofType:@"jpg"]
                                       image:nil
                                musicFileURL:nil
                                     extInfo:nil
                                    fileData:nil
                                emoticonData:nil
                         sourceFileExtension:@"mp4"
                              sourceFileData:[[NSBundle mainBundle] pathForResource:@"cat" ofType:@"mp4"]
                                        type:SSDKContentTypeFile
                          forPlatformSubType:SSDKPlatformSubTypeWechatFav];
    //设置保存视频并获取相册地址 并设置QQ视频分享
    NSURL *url = [NSURL URLWithString:filePath];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak __typeof__ (self) weakSelf = self;
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
        [shareParams SSDKSetupQQParamsByText:nil
                                      title:nil
                                        url:assetURL
                              audioFlashURL:nil
                              videoFlashURL:nil
                                 thumbImage:nil
                                     images:nil
                                       type:SSDKContentTypeVideo
                         forPlatformSubType:SSDKPlatformSubTypeQZone];
        [weakSelf shareWithParameters:shareParams items:items filePath:filePath];
    }];
}

- (void)shareWithParameters:(NSMutableDictionary *)shareParams items:(NSArray *)items filePath:(NSString *)filePath
{
    __weak __typeof__ (self) weakSelf = self;
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:self.view
                             items:items
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBeginUPLoad:
                       {
                           httpServiceModel = [[SSDKVideoUploadCenter shareInstance]
                                               uploadProgressWithPlatformType:platformType
                                               fileURL:[NSURL URLWithString:filePath]
                                               tag:nil
                                               progressEvent:^(int64_t totalBytes, int64_t loadedBytes) {
                                                   if(loadingViewController != nil)
                                                   {
                                                       CGFloat temp =  loadedBytes*1.0/totalBytes;
                                                       if(temp > 0.95)
                                                       {
                                                           temp = 0.95; //上传完后还需要的发布
                                                       }
                                                       if(temp > loadingViewController.progressView.progress )
                                                       {
                                                           [loadingViewController.progressView setProgress:temp animated:YES];
                                                       }
                                                   }
                                               }];
                           [weakSelf showLoading];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Instagram、FacebookMessage等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeInstagram || platformType == SSDKPlatformTypeFacebookMessenger)
                           {
                               break;
                           }
                           
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
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
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
                   if(state != SSDKResponseStateBeginUPLoad)
                   {
                       if(state == SSDKResponseStateSuccess || state == SSDKResponseStateFail)
                       {
                           if(loadingViewController!= nil)
                           {
                               [loadingViewController.progressView setProgress:1 animated:YES];
                               [loadingViewController closeAct:nil];
                           }
                       }
                   }
               }];
    //设置 点击就分享
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeFacebook)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeYouTube)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeTwitter)];
}


/**
 进度UI
 */
-(void)showLoading
{
    if(loadingViewController == nil)
    {
        loadingViewController = [[MOBLoadingViewController alloc] initWithNibName:@"MOBLoadingViewController" bundle:nil];
        loadingViewController.view.frame = [UIScreen mainScreen].bounds;
    }
    loadingViewController.httpServiceModel = httpServiceModel;
    [self.navigationController.view addSubview:loadingViewController.view];
    loadingViewController.view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        loadingViewController.view.alpha = 1;
    }];
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseCell"];
    }
    cell.textLabel.text = titelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row < selectorNameArray.count)
    {
        NSString *selectorName = selectorNameArray[indexPath.row];
        [self funcWithSelectorName:selectorName];
    }
}

- (void)funcWithSelectorName:(NSString *)selectorName
{
    SEL sel = NSSelectorFromString(selectorName);
    if([self respondsToSelector:sel])
    {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL) = (void *)imp;
        func(self, sel);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
