//
//  MOBMessengerViewController.h
//  ShareSDKDemo
//
//  Created by youzu on 17/3/7.
//  Copyright © 2017年 mob. All rights reserved.
//

#import "MOBPlatformViewController.h"

@interface MOBLineViewController : MOBPlatformViewController

@end

/*
 <key>LSApplicationQueriesSchemes</key>
	<array>
     <string>lineauth</string>
     <string>line</string>
     <string>line3rdp.$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	</array>
 
 info.plist中需加入
 
 <key>LineSDKConfig</key>
	<dict>
 <key>ChannelID</key>
 <string>your channelID</string>
	</dict>
*/
