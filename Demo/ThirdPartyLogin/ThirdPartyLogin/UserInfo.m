//
//  UserInfo.m
//  ThirdPartyLogin
//
//  Created by fenghj on 15/7/1.
//  Copyright (c) 2015年 mob. All rights reserved.
//

#import "UserInfo.h"
#import <ShareSDK/ShareSDK.h>

static NSString *const NicknameKey = @"nickname";
static NSString *const AvatarKey   = @"avatar";
static NSString *const AboutMeKey  = @"aboutme";

@implementation UserInfo

/**
 *  重写更新信息方法，目的将社交平台的部分信息同步到用户信息中。
 *
 *  @param data 社交用户信息数据
 */
- (void)updateInfo:(SSDKUser *)data
{
    self.avatar = data.icon;
    self.nickname = data.nickname;
    self.aboutMe = data.aboutMe;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    if (self.avatar)
    {
        [aCoder encodeObject:self.avatar forKey:AvatarKey];
    }
    
    if (self.nickname)
    {
        [aCoder encodeObject:self.nickname forKey:NicknameKey];
    }
    
    if (self.aboutMe)
    {
        [aCoder encodeObject:self.aboutMe forKey:AboutMeKey];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.avatar = [aDecoder decodeObjectForKey:AvatarKey];
        self.nickname = [aDecoder decodeObjectForKey:NicknameKey];
        self.aboutMe = [aDecoder decodeObjectForKey:AboutMeKey];
    }
    
    return self;
}

@end
