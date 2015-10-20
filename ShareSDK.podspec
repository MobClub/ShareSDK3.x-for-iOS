Pod::Spec.new do |s|
  s.name             = 'ShareSDK'
  s.version          = "3.1.1"
  s.summary          = 'ShareSDK is the most comprehensive Social SDK in the world,which share easily with 40+ platforms.'
  s.license          = 'Copyright © 2012-2015 mob.com'
  s.author           = { "Jinghuang Liu" => "liujinghuang@icloud.com" }

  s.homepage         = 'http://www.mob.com'
  s.source           = { :git => "https://github.com/ShareSDKPlatform/ShareSDK.git", :tag => s.version.to_s }
  s.platform         = :ios
  s.ios.deployment_target = "6.0"
  s.frameworks       = 'UIKit', 'JavaScriptCore'
  s.libraries        = 'icucore', 'z.1.2.5', 'stdc++'

  s.default_subspecs    = 'libraries'
  s.vendored_frameworks = 'libraries/ShareSDK.framework'

  # 核心模块
    s.subspec 'libraries' do |sp|
        sp.vendored_frameworks = 'libraries/ShareSDKConnector.framework', 'libraries/ShareSDKExtension.framework', 'libraries/MOBFoundation.framework'
        sp.libraries = 'icucore', 'z', 'stdc++'
        sp.resources = 'ShareSDK.bundle'
    end

    # ShareSDK提供的UI
    s.subspec 'ShareSDKUI' do |sp|
        sp.vendored_frameworks = 'libraries/ShareSDKUI.framework'
        sp.resources = 'libraries/ShareSDKUI.bundle'
    end

    # 各个平台的SDK
    s.subspec 'ShareSDKPlatforms' do |sp|
        sp.default_subspecs = 'GooglePlus', 'QQ', 'SinaWeibo', 'WeChat', 'RenRen'
    
        # GooglePlus
        sp.subspec 'GooglePlus' do |ssp|
            ssp.vendored_frameworks = 'libraries/extends/GooglePlusSDK/GoogleOpenSource.framework', 'libraries/extends/GooglePlusSDK/GooglePlus.framework'
            ssp.resource = 'libraries/extends/GooglePlusSDK/GooglePlus.bundle'
            ssp.frameworks = 'CoreMotion', 'CoreLocation', 'MediaPlayer', 'AssetsLibrary', 'AddressBook'
        end

        # QQ
        sp.subspec 'QQ' do |ssp|
            ssp.vendored_frameworks = 'libraries/extends/QQSDK/TencentOpenAPI.framework'
            ssp.resource = 'libraries/extends/QQSDK/TencentOpenApi_IOS_Bundle.bundle'
            ssp.libraries = 'sqlite3'
        end

        # SinaWeibo
        sp.subspec 'SinaWeibo' do |ssp|
            ssp.vendored_libraries = "libraries/extends/SinaWeiboSDK/*.a"
            ssp.resource = 'libraries/extends/SinaWeiboSDK/WeiboSDK.bundle'
            ssp.frameworks = 'ImageIO', 'AdSupport'
            ssp.libraries = 'sqlite3'
            ssp.source_files = "libraries/extends/SinaWeiboSDK/*.{h,m}"
            ssp.public_header_files = "libraries/extends/SinaWeiboSDK/*.h"
        end

        # WeChat
        sp.subspec 'WeChat' do |ssp|
            ssp.vendored_libraries = "libraries/extends/WeChatSDK/*.a"
            ssp.source_files = "libraries/extends/WeChatSDK/*.{h,m}"
            ssp.public_header_files = "libraries/extends/WeChatSDK/*.h"
            ssp.libraries = 'sqlite3'
        end

        # RenRen
        sp.subspec 'RenRen' do |ssp|
            ssp.vendored_frameworks = 'libraries/extends/RenRenSDK/RennSDK.framework'
            ssp.resource = 'libraries/extends/RenRenSDK/RennSDK.bundle'
        end
    end
end
