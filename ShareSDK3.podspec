Pod::Spec.new do |s|
  s.name             = 'ShareSDK3'
  s.version          = "3.2.0"
  s.summary          = 'ShareSDK is the most comprehensive Social SDK in the world,which share easily with 40+ platforms.'
  s.license          = 'MIT'
  s.author           = { "Jinghuang Liu" => "liujinghuang@icloud.com" }

  s.homepage         = 'http://www.mob.com'
  s.source           = { :git => "https://github.com/ShareSDKPlatform/ShareSDK.git", :tag => s.version.to_s }
  s.platform         = :ios
  s.ios.deployment_target = "6.0"
  s.frameworks       = 'UIKit', 'JavaScriptCore'
  s.libraries        = 'icucore', 'z.1.2.5', 'stdc++'

  s.default_subspecs    = 'ShareSDK'
  s.vendored_frameworks = 'ShareSDK/ShareSDK.framework'

  # 核心模块
    s.subspec 'ShareSDK' do |sp|
        sp.vendored_frameworks = 'ShareSDK/Support/Required/ShareSDKConnector.framework', 'ShareSDK/Support/Optional/ShareSDKExtension.framework'
        sp.libraries = 'icucore', 'z', 'stdc++'
        sp.resources = 'ShareSDK/Support/Required/ShareSDK.bundle'
    end

    # ShareSDK提供的UI
    s.subspec 'ShareSDKUI' do |sp|
        sp.vendored_frameworks = 'ShareSDK/Support/Optional/ShareSDKUI.framework'
        sp.resources = 'ShareSDK/Support/Optional/ShareSDKUI.bundle'
    end

    # 各个平台的SDK
    s.subspec 'ShareSDKPlatforms' do |sp|
        sp.default_subspecs = 'QQ', 'SinaWeibo', 'WeChat', 'RenRen', 'Yixin', 'Messenger'

        # QQ
        sp.subspec 'QQ' do |ssp|
            ssp.vendored_frameworks = 'ShareSDK/Support/PlatformSDK/QQSDK/TencentOpenAPI.framework'
            ssp.resource = 'ShareSDK/Support/PlatformSDK/QQSDK/TencentOpenApi_IOS_Bundle.bundle'
            ssp.libraries = 'sqlite3'
        end

        # SinaWeibo
        sp.subspec 'SinaWeibo' do |ssp|
            ssp.vendored_libraries = "ShareSDK/Support/PlatformSDK/SinaWeiboSDK/*.a"
            ssp.resource = 'ShareSDK/Support/PlatformSDK/SinaWeiboSDK/WeiboSDK.bundle'
            ssp.frameworks = 'ImageIO'
            ssp.libraries = 'sqlite3'
            ssp.source_files = "ShareSDK/Support/PlatformSDK/SinaWeiboSDK/*.{h,m}"
            ssp.public_header_files = "ShareSDK/Support/PlatformSDK/SinaWeiboSDK/*.h"
        end

        # WeChat
        sp.subspec 'WeChat' do |ssp|
            ssp.vendored_libraries = "ShareSDK/Support/PlatformSDK/WeChatSDK/*.a"
            ssp.source_files = "ShareSDK/Support/PlatformSDK/WeChatSDK/*.{h,m}"
            ssp.public_header_files = "ShareSDK/Support/PlatformSDK/WeChatSDK/*.h"
            ssp.libraries = 'sqlite3'
        end

        # RenRen
        sp.subspec 'RenRen' do |ssp|
            ssp.vendored_frameworks = 'ShareSDK/Support/PlatformSDK/RenRenSDK/RennSDK.framework'
            ssp.resource = 'ShareSDK/Support/PlatformSDK/RenRenSDK/RennSDK.bundle'
        end

        # 支付宝（AliPaySocial）
        sp.subspec 'AliPaySocial' do |ssp|
            ssp.vendored_libraries = 'ShareSDK/Support/PlatformSDK/APSocialSDK/*.a'
            ssp.source_files = "ShareSDK/Support/PlatformSDK/APSocialSDK/*.{h,m}"
            ssp.public_header_files = "ShareSDK/Support/PlatformSDK/APSocialSDK/*.h"
        end

        # Kakao
        sp.subspec 'Kakao' do |ssp|
            ssp.vendored_frameworks = 'ShareSDK/Support/PlatformSDK/KaKaoSDK/KakaoOpenSDK.framework'
        end

        # Yixin
        sp.subspec 'Yixin' do |ssp|
            ssp.vendored_libraries = "ShareSDK/Support/PlatformSDK/YiXinSDK/*.a"
            ssp.source_files = "ShareSDK/Support/PlatformSDK/YiXinSDK/*.{h,m}"
            ssp.public_header_files = "ShareSDK/Support/PlatformSDK/YiXinSDK/*.h"
        end

        # Messenger
        sp.subspec 'Messenger' do |ssp|
            ssp.vendored_frameworks = 'ShareSDK/Support/PlatformSDK/FacebookMessengerSDK/FBSDKMessengerShareKit.framework'
        end

    end
end
