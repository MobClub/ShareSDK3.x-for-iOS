//
//  ViewController.m
//  ShareSDKDemo
//
//  Created by youzu on 17/3/6.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ViewController ()
{
    IBOutlet UITableView *tabeleView;
    NSArray *_platforemArray;
    NSArray *_overseasPlatforemArray;
    NSArray *_systemPlatforemArray;
    NSBundle *_uiBundle;
    BOOL showMorePlatforem;
    BOOL showOverseasMorePlatforem;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _platforemArray = @[
                        @(SSDKPlatformSubTypeQQFriend),
                        @(SSDKPlatformSubTypeQZone),
                        @(SSDKPlatformSubTypeWechatSession),
                        @(SSDKPlatformSubTypeWechatTimeline),
                        @(SSDKPlatformSubTypeWechatFav),
                        @(SSDKPlatformTypeSinaWeibo),
                        @(SSDKPlatformTypeMeiPai),
                        ];
    _overseasPlatforemArray = @[
                                @(SSDKPlatformTypeFacebook),
                                @(SSDKPlatformTypeFacebookMessenger),
                                @(SSDKPlatformTypeTwitter),
                                @(SSDKPlatformTypeYouTube),
                                @(SSDKPlatformTypeInstagram),
                                @(SSDKPlatformTypeLine),
                                ];
    _systemPlatforemArray = nil;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ShareSDKUI" ofType:@"bundle"];
    _uiBundle = [NSBundle bundleWithPath:bundlePath];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return _platforemArray.count;
        case 1:
            return _overseasPlatforemArray.count;
        default:
            return  0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseCell"];
    }
    id obj = nil;
    switch (indexPath.section) {
        case 0:
            obj = _platforemArray[indexPath.row];
            break;
        case 1:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
        case 2:
            obj = _systemPlatforemArray[indexPath.row];
            break;
    }
    if([obj isKindOfClass:[NSString class]])
    {
        NSString *titel = obj;
        cell.textLabel.text = titel;
        cell.imageView.image = nil;
        if((showMorePlatforem && indexPath.section == 0) || (showOverseasMorePlatforem && indexPath.section == 1))
        {
            cell.textLabel.textAlignment = NSTextAlignmentRight;
        }
        else
        {
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
    else if([obj isKindOfClass:[NSNumber class]])
    {
        //title
        NSInteger platformType = [obj integerValue];
        NSString *platformTypeName = [NSString stringWithFormat:@"ShareType_%zi",platformType];
        cell.textLabel.text = NSLocalizedStringWithDefaultValue(platformTypeName, @"ShareSDKUI_Localizable", _uiBundle, platformTypeName, nil);
        //icon
        NSString *iconImageName = [NSString stringWithFormat:@"Icon_simple/sns_icon_%ld.png",(long)platformType];
        UIImage *icon = [UIImage imageWithContentsOfFile:[_uiBundle pathForResource:(iconImageName) ofType:nil]];
        cell.imageView.image = icon;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return @"  国内平台";
        }
        case 1:
        {
            return @"  海外平台";
        }
        default:
            return nil;
    }
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = _platforemArray[indexPath.row];
    if([obj isKindOfClass:[NSString class]])
    {
        return 50;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id obj = nil;
    switch (indexPath.section) {
        case 0:
            obj = _platforemArray[indexPath.row];
            break;
        case 1:
            obj = _overseasPlatforemArray[indexPath.row];
            break;
    }
    NSInteger platformType = [obj integerValue];
    NSString *platformTypeName = [NSString stringWithFormat:@"ShareType_%zi",platformType];
    NSString *platformName = NSLocalizedStringWithDefaultValue(platformTypeName, @"ShareSDKUI_Localizable", _uiBundle, platformTypeName, nil);
    platformName = [platformName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *viewControllerName = [NSString stringWithFormat:@"MOB%@ViewController",platformName];
    Class viewControllerClass = NSClassFromString(viewControllerName);
    if (viewControllerClass)
    {
        UIViewController *viewController = [[viewControllerClass alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
