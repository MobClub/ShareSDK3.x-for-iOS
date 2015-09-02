//
//  AppDelegate.swift
//  ShareSDK简洁版-Swift
//
//  Created by lisk@uuzu.com on 15/7/31.
//  Copyright (c) 2015年 MOB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        /**
        *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
        *  在将生成的AppKey传入到此方法中。
        *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
        *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
        *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
        */
        ShareSDK.registerApp("iosv1101",
            activePlatforms : [SSDKPlatformType.TypeSinaWeibo.rawValue,
                               SSDKPlatformType.TypeTencentWeibo.rawValue,
                               SSDKPlatformType.TypeDouBan.rawValue,
                               SSDKPlatformType.TypeCopy.rawValue,
                               SSDKPlatformType.TypeFacebook.rawValue,
                               SSDKPlatformType.TypeTwitter.rawValue,
                               SSDKPlatformType.TypeMail.rawValue,
                               SSDKPlatformType.TypeSMS.rawValue,
                               SSDKPlatformType.TypeWechat.rawValue,
                               SSDKPlatformType.TypeQQ.rawValue],
            onImport: {(platform : SSDKPlatformType) -> Void in
                switch platform
                {
                    case SSDKPlatformType.TypeWechat:
                         ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                    case SSDKPlatformType.TypeQQ:
                         ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                    default:
                        break
                    }
                 },
            onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                switch platform
                {
                    case SSDKPlatformType.TypeSinaWeibo:
                        //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                         appInfo.SSDKSetupSinaWeiboByAppKey("568898243",
                                                  appSecret : "38a4f8204cc784f81f9f0daaf31e02e3",
                                                redirectUri : "http://www.sharesdk.cn",
                                                   authType : SSDKAuthTypeBoth)
                    break
                    
                    case SSDKPlatformType.TypeWechat:
                        //设置微信应用信息
                         appInfo.SSDKSetupWeChatByAppId("wx4868b35061f87885", appSecret: "64020361b8ec4c99936c0e3999a9f249")
                    break
                        
                    case SSDKPlatformType.TypeTencentWeibo:
                        //设置腾讯微博应用信息，其中authType设置为只用Web形式授权
                         appInfo.SSDKSetupTencentWeiboByAppKey("801307650",
                                                     appSecret : "ae36f4ee3946e1cbb98d6965b0b2ff5c",
                                                   redirectUri : "http://www.sharesdk.cn")
                    break
                        
                    case SSDKPlatformType.TypeFacebook:
                        //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                         appInfo.SSDKSetupFacebookByAppKey("107704292745179",
                                                 appSecret : "38053202e1a5fe26c80c753071f0b573",
                                                  authType : SSDKAuthTypeBoth)
                    break
                        
                    case SSDKPlatformType.TypeTwitter:
                        //设置Twitter应用信息
                         appInfo.SSDKSetupTwitterByConsumerKey("LRBM0H75rWrU9gNHvlEAA2aOy",
                                                consumerSecret : "gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G",
                                                   redirectUri : "http://mob.com")
                    break
                        
                    case SSDKPlatformType.TypeQQ:
                        //设置QQ应用信息
                         appInfo.SSDKSetupQQByAppId("100371282",
                                             appKey : "aed9b0303e3ed1e27bae87c33761161d",
                                           authType : SSDKAuthTypeWeb)
                    break
                    
                case SSDKPlatformType.TypeDouBan:
                        //设置豆瓣应用信息
                        appInfo.SSDKSetupDouBanByApiKey("02e2cbe5ca06de5908a863b15e149b0b", secret: "9f1e7b4f71304f2f", redirectUri: "http://www.sharesdk.cn")
                    break
                    default:
                        break
                        }
        })
        return true
    }
}

