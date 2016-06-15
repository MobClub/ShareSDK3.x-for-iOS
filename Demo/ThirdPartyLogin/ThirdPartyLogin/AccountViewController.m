//
//  AccountViewController.m
//  ThirdPartyLogin
//
//  Created by fenghj on 15/7/1.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "AccountViewController.h"
#import "UserInfo.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface AccountViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;

/**
 *  用户列表
 */
@property (nonatomic, strong) NSMutableArray *users;

@end

@implementation AccountViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.users = [NSMutableArray array];
        
        //将已授权用户加入列表
        [[SSEThirdPartyLoginHelper users] enumerateKeysAndObjectsUsingBlock:^(id key, SSEBaseUser *obj, BOOL *stop) {
            [self.users addObject:obj];
        }];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(cancelButtonClickHandler:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(addAccountClickHandler:)];
    }
    
    return self;
}

- (void)dealloc
{
    if ([self.delegate respondsToSelector:@selector(accountViewDidClosed:)])
    {
        [self.delegate accountViewDidClosed:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.editing = YES;
    }
    
    if (indexPath.row < self.users.count)
    {
        UserInfo *userInfo = self.users [indexPath.row];
        cell.textLabel.text = userInfo.nickname;
        
        if ([userInfo.linkId isEqualToString:[SSEThirdPartyLoginHelper currentUser].linkId])
        {
            //为当前用户
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            //非当前用户
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row < self.users.count)
        {
            //注销用户
            [SSEThirdPartyLoginHelper logout:self.users[indexPath.row]];
            [self.users removeObjectAtIndex:indexPath.row];
            
            NSMutableArray *visibleRow = [[tableView indexPathsForVisibleRows] mutableCopy];
            [visibleRow removeObject:indexPath];
            
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadRowsAtIndexPaths:visibleRow withRowAnimation:UITableViewRowAnimationFade];
            [tableView endUpdates];
        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < self.users.count)
    {
        UserInfo *userInfo = self.users [indexPath.row];
        if (![userInfo.linkId isEqualToString:[SSEThirdPartyLoginHelper currentUser].linkId])
        {
            //切换用户
            [SSEThirdPartyLoginHelper changeUser:userInfo];
            
            //更新单元格
            [tableView reloadRowsAtIndexPaths:tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationFade];
            
            //关闭视图
            [self dismissModalViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Private

/**
 *  取消按钮点击
 *
 *  @param sender 事件对象
 */
- (void)cancelButtonClickHandler:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

/**
 *  添加帐号点击
 *
 *  @param sender 事件对象
 */
- (void)addAccountClickHandler:(id)sender
{
    __weak AccountViewController *theController = self;
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        //判断是否已经在用户列表中，避免用户使用同一账号进行重复登录
                                        if (![theController.users containsObject:user])
                                        {
                                            [theController.users addObject:user];
                                        }
                                        
                                        //刷新表格
                                        [theController.tableView reloadData];
                                    }
                                    
                                }];
    
}

@end
