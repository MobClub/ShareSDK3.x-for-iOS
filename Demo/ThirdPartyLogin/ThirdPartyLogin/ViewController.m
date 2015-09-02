//
//  ViewController.m
//  ThirdPartyLogin
//
//  Created by fenghj on 15/6/30.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "ViewController.h"
#import "UserInfo.h"
#import "AccountViewController.h"
#import <MOBFoundation/MOBFoundation.h>
#import <MOBFoundation/MOBFImageService.h>
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface ViewController () <AccountViewControllerDelegate>

/**
 *  提示文字标签
 */
@property (nonatomic, strong) UILabel *tipsLabel;

/**
 *  头像视图
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 *  昵称标签
 */
@property (nonatomic, strong) UILabel *nicknameLabel;

/**
 *  关于标签
 */
@property (nonatomic, strong) UILabel *aboutMeLabel;

@end

@implementation ViewController

- (instancetype)init
{
    if (self = [super init])
    {
        //设置用户类型为UserInfo，这样可以将自定义的用户信息类与第三方登录进行绑定
        [SSEThirdPartyLoginHelper setUserClass:[UserInfo class]];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账号"
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(accountItemClickHandler:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([MOBFDevice versionCompare:@"7.0"] >= 0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
    
    //提示
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tipsLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.tipsLabel];
    
    //头像
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 120, 120)];
    self.avatarImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.avatarImageView];
    
    //昵称
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nicknameLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.nicknameLabel];
    
    //关于
    self.aboutMeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.aboutMeLabel.font = [UIFont systemFontOfSize:16];
    self.aboutMeLabel.numberOfLines = 0;
    [self.view addSubview:self.aboutMeLabel];
    
    //刷新用户信息
    [self refreshUserInfo];
}

- (void)accountItemClickHandler:(id)sender
{
    AccountViewController *vc = [[AccountViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentModalViewController:nvc animated:YES];
}

/**
 *  刷新用户信息
 */
- (void)refreshUserInfo
{
    UserInfo *currentUser = (UserInfo *)[SSEThirdPartyLoginHelper currentUser];
    if (currentUser)
    {
        self.avatarImageView.hidden = NO;
        self.nicknameLabel.hidden = NO;
        self.tipsLabel.hidden = YES;
        
        self.nicknameLabel.text = currentUser.nickname;
        [self.nicknameLabel sizeToFit];
        self.nicknameLabel.frame = CGRectMake(self.avatarImageView.frame.size.width + self.avatarImageView.frame.origin.x + 10,
                                              self.avatarImageView.frame.origin.y,
                                              CGRectGetWidth(self.nicknameLabel.frame),
                                              CGRectGetHeight(self.nicknameLabel.frame));
        
        if (currentUser.avatar)
        {
            NSString *observer = [self description];
            __weak ViewController *theController = self;
            [[MOBFImageService sharedInstance] getImageWithURL:[NSURL URLWithString:currentUser.avatar]
                                                      observer:observer
                                                     onLoading:nil
                                                      onResult:^(NSData *imageData) {
                                                          
                                                          theController.avatarImageView.image = [[UIImage alloc] initWithData:imageData];
                                                          [[MOBFImageService sharedInstance] removeObserver:observer];
                                                          
                                                      }
                                                        onFail:nil];
        }
        
        self.aboutMeLabel.text = currentUser.aboutMe;
        self.aboutMeLabel.frame = [self.aboutMeLabel textRectForBounds:CGRectMake(self.avatarImageView.frame.origin.x, self.avatarImageView.frame.origin.y + self.avatarImageView.frame.size.height, self.view.frame.size.width - 40, MAXFLOAT) limitedToNumberOfLines:0];
    }
    else
    {
        self.avatarImageView.hidden = YES;
        self.nicknameLabel.hidden = YES;
        self.tipsLabel.hidden = NO;
        
        self.tipsLabel.text = @"用户尚未登录";
        self.tipsLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self.tipsLabel sizeToFit];
        self.tipsLabel.frame = CGRectMake((self.view.frame.size.width - self.tipsLabel.frame.size.width) / 2,
                                          (self.view.frame.size.height - self.tipsLabel.frame.size.height) / 2,
                                          CGRectGetWidth(self.tipsLabel.frame),
                                          CGRectGetHeight(self.tipsLabel.frame));
    }
}

#pragma mark - AccountViewControllerDelegate

- (void)accountViewDidClosed:(AccountViewController *)controller
{
    [self refreshUserInfo];
}

@end
