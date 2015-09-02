//
//  SSDKAuthViewStyle.h
//  ShareSDK
//
//  Created by fenghj on 15/4/13.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  授权视图样式
 */
@interface SSDKAuthViewStyle : NSObject

/**
 *  设置导航栏背景
 *
 *  @param image 背景图片
 */
+ (void)setNavigationBarBackgroundImage:(UIImage *)image;

/**
 *  设置导航栏颜色
 *
 *  @param color 背景颜色
 */
+ (void)setNavigationBarBackgroundColor:(UIColor *)color;

/**
 *  设置标题
 *
 *  @param title 标题
 */
+ (void)setTitle:(NSString *)title;

/**
 *  设置标题文本颜色
 *
 *  @param color 颜色
 */
+ (void)setTitleColor:(UIColor *)color;

/**
 *  设置取消按钮标签
 *
 *  @param label 取消按钮标签
 */
+ (void)setCancelButtonLabel:(NSString *)label;

/**
 *  设置取消按钮标签文本颜色
 *
 *  @param color 颜色
 */
+ (void)setCancelButtonLabelColor:(UIColor *)color;

/**
 *  设置取消按钮图片
 *
 *  @param image 图片
 */
+ (void)setCancelButtonImage:(UIImage *)image;

/**
 *  设置状态栏样式
 *
 *  @param style 样式
 */
+ (void)setStatusBarStyle:(UIStatusBarStyle)style;

@end
