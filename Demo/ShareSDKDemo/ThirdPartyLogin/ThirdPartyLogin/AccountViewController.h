//
//  AccountViewController.h
//  ThirdPartyLogin
//
//  Created by fenghj on 15/7/1.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountViewController;

@protocol AccountViewControllerDelegate <NSObject>

/**
 *  视图关闭
 *
 *  @param controller 控制器
 */
- (void)accountViewDidClosed:(AccountViewController *)controller;

@end

/**
 *  账号视图控制器
 */
@interface AccountViewController : UIViewController

/**
 *  委托对象
 */
@property (nonatomic, weak) id<AccountViewControllerDelegate> delegate;

@end
