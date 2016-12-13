//
//  ViewController.m
//  SharingDemo
//
//  Created by fenghj on 15/6/29.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <MOBFoundation/MOBFoundation.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  是否开启摇一摇分享
 */
@property (nonatomic) BOOL enableShakeShare;

/**
 *  表格视图
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;

/**
 *  加载视图
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
    [self.view addSubview:self.tableView];
    
    //加载等待视图
    self.panelView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.panelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.panelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingView.frame = CGRectMake((self.view.frame.size.width - self.loadingView.frame.size.width) / 2, (self.view.frame.size.height - self.loadingView.frame.size.height) / 2, self.loadingView.frame.size.width, self.loadingView.frame.size.height);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.panelView addSubview:self.loadingView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 6)
    {
        return 3;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellId = @"CellId";
    static NSString *PlatCellId = @"PlatCellId";
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section)
    {
        case 0:
        {
            //简单分享
            cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
            }
            
            cell.textLabel.text = @"简单分享";
            cell.detailTextLabel.text = @"点击演示";
            break;
        }
        case 1:
        {
            //显示分享菜单
            cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
            }
            
            cell.textLabel.text = @"显示分享菜单";
            cell.detailTextLabel.text = @"点击演示";
            break;
        }
        case 2:
        {
            //显示内容编辑视图
            cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
            }
            
            cell.textLabel.text = @"显示分享内容编辑视图";
            cell.detailTextLabel.text = @"点击演示";
            break;
        }
        case 3:
        {
            //平台内容定制
            cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
            }
            
            cell.textLabel.text = @"平台内容定制";
            cell.detailTextLabel.text = @"点击演示";
            break;
        }
        case 4:
        {
            //截屏分享
            cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
            }
            
            cell.textLabel.text = @"截屏分享";
            cell.detailTextLabel.text = @"点击演示";
            break;
        }
        case 5:
        {
            //摇一摇分享
            cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
            }
            
            cell.textLabel.text = @"摇一摇分享";
            cell.detailTextLabel.text = @"点击开始";
            break;
        }
        case 6:
        {
            //一键分享
            switch (indexPath.row)
            {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:PlatCellId];
                    if (!cell)
                    {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlatCellId];
                        
                        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
                        [switchControl sizeToFit];
                        [switchControl addTarget:self action:@selector(switchChangeHandler:) forControlEvents:UIControlEventValueChanged];
                        cell.accessoryView = switchControl;
                    }
                    ((UISwitch *)cell.accessoryView).tag = 100;
                    ((UISwitch *)cell.accessoryView).on = [ShareSDK hasAuthorized:SSDKPlatformTypeSinaWeibo];
                    cell.textLabel.text = @"新浪微博";
                    break;
                case 1:
                    cell = [tableView dequeueReusableCellWithIdentifier:PlatCellId];
                    if (!cell)
                    {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlatCellId];
                        
                        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
                        [switchControl sizeToFit];
                        [switchControl addTarget:self action:@selector(switchChangeHandler:) forControlEvents:UIControlEventValueChanged];
                        cell.accessoryView = switchControl;
                    }
                    ((UISwitch *)cell.accessoryView).tag = 101;
                    ((UISwitch *)cell.accessoryView).on = [ShareSDK hasAuthorized:SSDKPlatformTypeTencentWeibo];
                    cell.textLabel.text = @"腾讯微博";
                    break;
                case 2:
                    cell = [tableView dequeueReusableCellWithIdentifier:CellId];
                    if (!cell)
                    {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
                    }
                    
                    cell.textLabel.text = @"点击进行分享";
                    break;
                default:
                    break;
            }
        }
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"";
        case 1:
            return @"";
        case 2:
            return @"";
        case 3:
            return @"";
        case 4:
            return @"";
        case 5:
            return @"";
        case 6:
            return @"一键分享";
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section)
    {
        case 0:
            [self simplyShare];
            break;
        case 1:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [self showShareActionSheet:cell];
            break;
        }
        case 2:
            [self showShareEditor];
            break;
        case 3:
            [self platShare];
            break;
        case 4:
            [self screenShare];
            break;
        case 5:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            self.enableShakeShare = !self.enableShakeShare;
            if (self.enableShakeShare)
            {
                cell.detailTextLabel.text = @"点击结束";
            }
            else
            {
                cell.detailTextLabel.text = @"点击开始";
            }
            [self shakeShare];
            
            break;
        }
        case 6:
        {
            if (indexPath.row == 2)
            {
                [self oneKeyShare];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark -

/**
 *  显示加载动画
 *
 *  @param flag YES 显示，NO 不显示
 */
- (void)showLoadingView:(BOOL)flag
{
    if (flag)
    {
        [self.view addSubview:self.panelView];
        [self.loadingView startAnimating];
    }
    else
    {
        [self.panelView removeFromSuperview];
    }
}

#pragma mark 简单分享

/**
 *  简单分享
 */
- (void)simplyShare
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak ViewController *theController = self;
    [self showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        
        [shareParams SSDKEnableUseClientShare];
        
        //进行分享
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             [theController showLoadingView:NO];
             [theController.tableView reloadData];
             
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
}

#pragma mark 显示分享菜单

/**
 *  显示分享菜单
 *
 *  @param view 容器视图
 */
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak ViewController *theController = self;
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:@[@"http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg"]
                                        url:[NSURL URLWithString:@"http://www.mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeText];

    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //添加一个自定义的平台（非必要）
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
                                                                                  label:@"自定义"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
                                                                                                                                        message:nil
                                                                                                                                       delegate:nil
                                                                                                                              cancelButtonTitle:@"确定"
                                                                                                                              otherButtonTitles:nil];
                                                                                    [alertView show];
                                                                                }];
    [activePlatforms addObject:item];
    
//设置分享菜单栏样式（非必要）
//        [SSUIShareActionSheetStyle setActionSheetBackgroundColor:[UIColor colorWithRed:249/255.0 green:0/255.0 blue:12/255.0 alpha:0.5]];
//        [SSUIShareActionSheetStyle setActionSheetColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
//        [SSUIShareActionSheetStyle setCancelButtonBackgroundColor:[UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0]];
//        [SSUIShareActionSheetStyle setCancelButtonLabelColor:[UIColor whiteColor]];
//        [SSUIShareActionSheetStyle setItemNameColor:[UIColor whiteColor]];
//        [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:10]];
//        [SSUIShareActionSheetStyle setCurrentPageIndicatorTintColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0]];
//        [SSUIShareActionSheetStyle setPageIndicatorTintColor:[UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1.0]];
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                           [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           //Facebook Messenger、WhatsApp等平台捕获不到分享成功或失败的状态，最合适的方式就是对这些平台区别对待
                           if (platformType == SSDKPlatformTypeFacebookMessenger)
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
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
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
                   
                   if (state != SSDKResponseStateBegin)
                   {
                       [theController showLoadingView:NO];
                       [theController.tableView reloadData];
                   }
                   
               }];
    
//另附：设置跳过分享编辑页面，直接分享的平台。
//        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
//                                                                         items:nil
//                                                                   shareParams:shareParams
//                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                                                           }];
//
//        //删除和添加平台示例
//        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
//        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
}

#pragma mark 内容编辑界面

/**
 *  显示分享编辑界面
 */
- (void)showShareEditor
{
    __weak ViewController *theController = self;
    
    //创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
        
        [ShareSDK showShareEditor:SSDKPlatformTypeSinaWeibo
               otherPlatformTypes:@[@(SSDKPlatformTypeTencentWeibo), @(SSDKPlatformTypeWechat)]
                      shareParams:shareParams
              onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
         {
                  
                  switch (state) {
                          
                      case SSDKResponseStateBegin:
                      {
                          [theController showLoadingView:YES];
                          break;
                      }
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
                  
                  if (state != SSDKResponseStateBegin)
                  {
                      [theController showLoadingView:NO];
                      [theController.tableView reloadData];
                  }
              }];
    }
}

#pragma mark 定制平台内容分享

/**
 *  定制平台分享内容分享
 */
- (void)platShare
{
    /**
     * 在定制平台内容分享中，除了设置共有的分享参数外，还可以为特定的社交平台进行内容定制，
     * 如：其他平台分享的内容为“分享内容”，但新浪微博需要在原有的“分享内容”文字后面加入一条链接，则可以如下做法：
     **/
    __weak ViewController *theController = self;
    [theController showLoadingView:YES];
    
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    
    if (imageArray) {
        
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeImage];
        
        [shareParams SSDKSetupSinaWeiboShareParamsByText:@"分享内容 http://mob.com"
                                                   title:@"分享标题"
                                                   image:[UIImage imageNamed:@"shareImg.png"]
                                                     url:nil
                                                latitude:0
                                               longitude:0
                                                objectID:nil
                                                    type:SSDKContentTypeImage];
        
        
        //进行分享
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
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
             
             [theController showLoadingView:NO];
             [theController.tableView reloadData];
             
         }];
    }
}

#pragma mark 屏幕截图分享

/**
 *  屏幕截图分享
 */
- (void)screenShare
{
    /**
     * 使用ShareSDKExtension插件可以实现屏幕截图分享，对于原生界面和OpenGL的游戏界面同样适用
     * 通过使用SSEShareHelper可以调用屏幕截图分享方法，在方法的第一个参数里面可以取得截图图片和分享处理入口，只要构造分享内容后，将要分享的内容和平台传入分享处理入口即可。
     *
     * 小技巧：
     * 当取得屏幕截图后，如果shareHandler入口不满足分享需求（如截取屏幕后需要弹出分享菜单而不是直接分享），可以不调用shareHandler进行分享，而是在block中写入自定义的分享操作。
     * 这样的话截屏分享接口实质只充当获取屏幕截图的功能。
     **/
    
    __weak ViewController *theController = self;
    [theController showLoadingView:YES];
    
    [SSEShareHelper screenCaptureShare:^(SSDKImage *image, SSEShareHandler shareHandler) {
        
        if (!image)
        {
            //如果无法取得屏幕截图则使用默认图片
            image = [[SSDKImage alloc] initWithImage:[UIImage imageNamed:@"shareImg.png"] format:SSDKImageFormatJpeg settings:nil];
        }
        
        //构造分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"使用ShareSDK分享，更便捷，更方便。"
                                         images:@[image]
                                            url:nil
                                          title:nil
                                           type:SSDKContentTypeImage];
        
        //回调分享
        if (shareHandler)
        {
            shareHandler (SSDKPlatformTypeSinaWeibo, shareParams);
        }
    }
                        onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
       
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
        
        [theController showLoadingView:NO];
        [theController.tableView reloadData];
        
    }];
}

#pragma mark 摇一摇分享

/**
 *  摇一摇分享
 */
- (void)shakeShare
{
    if (self.enableShakeShare)
    {
        /**
         * 使用ShareSDKExtension插件可以实现摇一摇分享
         * 通过使用SSEShareHelper可以调用开启/结束摇一摇分享方法，在方法的onWillShareHandler参数中可以处理摇一摇后的分享处理操作。
         *
         * 小技巧：
         * 当取得摇一摇事件通知后，如果shareHandler入口不满足分享需求（如需要弹出分享菜单而不是直接分享），可以不调用shareHandler进行分享，而是在block中写入自定义的分享操作。
         * 这样的话摇一摇分享接口实质只充当捕获摇一摇通知的功能。
         **/
        __weak ViewController *theController = self;
        
        //开启摇一摇分享功能
        [SSEShareHelper beginShakeShare:nil
                              onEndSake:nil
                     onWillShareHandler:^(SSEShareHandler shareHandler)
        {
            
            NSLog(@"======开始分享");
            //构造分享参数
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            
            NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
            
            if (imageArray)
            {
                [shareParams SSDKSetupShareParamsByText:@"摇着摇着就可以分享出去了，使用ShareSDK分享就是便捷方便。"
                                                 images:imageArray
                                                    url:nil
                                                  title:nil
                                                   type:SSDKContentTypeImage];
                //显示等待界面
                [theController showLoadingView:YES];
                
                //回调分享
                if (shareHandler)
                {
                    shareHandler (SSDKPlatformTypeSinaWeibo, shareParams);
                }
            }
        }
                         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
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
            
            [theController showLoadingView:NO];
            [theController.tableView reloadData];
            
        }];
    }
    else
    {
        //关闭摇一摇分享功能
        [SSEShareHelper endShakeShare];
    }
}

#pragma mark 一键分享

/**
 *  一键分享
 */
- (void)oneKeyShare
{
    /**
     * 使用ShareSDKExtension插件可以实现一键分享到多个平台。
     *
     * 注：
     * 1、在分享之前必须先保证平台的分享不是使用客户端进行。
     * 2、分享平台必须要先确保已经授权，否则会分享失败。
     *
     **/
    
    __weak ViewController *theController = self;
    [theController showLoadingView:YES];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    
    if (imageArray)
    {
        
        //构造分享参数
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"我在使用ShareSDK的一键分享。"
                                         images:imageArray
                                            url:nil
                                          title:nil
                                           type:SSDKContentTypeImage];
        
        [SSEShareHelper oneKeyShare:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeTencentWeibo)]
                         parameters:shareParams
                     onStateChanged:^(SSDKPlatformType platformType, SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                         
                         NSString *platformName = nil;
                         switch (platformType)
                         {
                             case SSDKPlatformTypeSinaWeibo:
                                 platformName = @"新浪微博";
                                 break;
                             case SSDKPlatformTypeTencentWeibo:
                                 platformName = @"腾讯微博";
                                 break;
                             default:
                                 break;
                         }
                         
                         switch (state) {
                             case SSDKResponseStateSuccess:
                             {
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@分享成功", platformName]
                                                                                     message:nil
                                                                                    delegate:nil
                                                                           cancelButtonTitle:@"确定"
                                                                           otherButtonTitles:nil];
                                 [alertView show];
                                 break;
                             }
                             case SSDKResponseStateFail:
                             {
                                 if (error.code == 205)
                                 {
                                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@用户尚未授权, 授权后再试!", platformName]
                                                                                         message:nil
                                                                                        delegate:nil
                                                                               cancelButtonTitle:@"确定"
                                                                               otherButtonTitles:nil];
                                     [alertView show];
                                 }
                                 else
                                 {
                                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@分享失败", platformName]
                                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                                        delegate:nil
                                                                               cancelButtonTitle:@"确定"
                                                                               otherButtonTitles:nil];
                                     [alertView show];
                                 }
                                 break;
                             }
                             case SSDKResponseStateCancel:
                             {
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@分享已取消", platformName]
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
                         
                         if (end)
                         {
                             [theController showLoadingView:NO];
                             [theController.tableView reloadData];
                         }
                     }];
    }
}

- (void)switchChangeHandler:(UISwitch *)sender
{
    __weak ViewController *theController = self;
    switch (sender.tag)
    {
        case 100:
        {
            //新浪微博
            if (sender.on)
            {
                //授权
                [ShareSDK authorize:SSDKPlatformTypeSinaWeibo
                           settings:nil
                     onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                    
                    [theController.tableView reloadData];
                    
                }];
            }
            else
            {
                //取消授权
                [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
            }
            break;
        }
        case 101:
        {
            //腾讯微博
            if (sender.on)
            {
                //授权
                [ShareSDK authorize:SSDKPlatformTypeTencentWeibo
                           settings:nil
                     onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                    
                    [theController.tableView reloadData];
                    
                }];
            }
            else
            {
                //取消授权
                [ShareSDK cancelAuthorize:SSDKPlatformTypeTencentWeibo];
            }
            break;
        }
        default:
            break;
    }
}

@end
