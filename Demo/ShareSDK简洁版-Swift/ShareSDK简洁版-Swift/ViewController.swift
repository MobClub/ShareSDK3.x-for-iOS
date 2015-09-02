//
//  ViewController.swift
//  ShareSDK简洁版-Swift
//
//  Created by lisk@uuzu.com on 15/7/31.
//  Copyright (c) 2015年 MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     * 简单分享示例
     */
    @IBAction func SimpleShare(sender: UIButton) {

        // 1.创建分享参数
        var shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("分享内容",
                                           images : UIImage(named: "shareImg.png"),
                                              url : NSURL(string:"http://mob.com"),
                                            title : "分享标题",
                                             type : SSDKContentType.Image)
        
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.TypeSinaWeibo, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
            
            switch state{
                
                case SSDKResponseState.Success:
                                                println("分享成功")
                                                let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "取消")
                                                alert.show()
                case SSDKResponseState.Fail:    println("分享失败,错误描述:\(error)")
                case SSDKResponseState.Cancel:  println("分享取消")
            
            default:
                break
            }
        }
    }
    
    /**
     * 显示分享菜单示例
     */
    @IBAction func ShowShareMenu(sender: UIButton) {
        
        //1.创建分享参数
        var shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("分享内容",
                                         images : UIImage(named: "shareImg.png"),
                                            url : NSURL(string:"http://mob.com"),
                                          title : "分享标题",
                                           type : SSDKContentType.Auto)
        //2.进行分享
        ShareSDK.showShareActionSheet(self.view, items: nil, shareParams: shareParames) { (state : SSDKResponseState, platformType : SSDKPlatformType, userdata : [NSObject : AnyObject]!, contentEnity : SSDKContentEntity!, error : NSError!, Bool end) -> Void in
            
            switch state{
            
                case SSDKResponseState.Success: println("分享成功")
                case SSDKResponseState.Fail:    println("分享失败,错误描述:\(error)")
                case SSDKResponseState.Cancel:  println("分享取消")
            
            default:
                break
            }
        }
    }
    
    /**
    *  显示分享编辑界面
    */
    @IBAction func ShowShareEditor(sender: UIButton) {
        
        // 1.创建分享参数
        var shareParames = NSMutableDictionary()

        shareParames.SSDKSetupShareParamsByText("分享内容",
                                         images : UIImage(named: "shareImg.png"),
                                            url : NSURL(string:"http://mob.com"),
                                          title : "分享标题",
                                           type : SSDKContentType.Image)
        //2.显示分享编辑页面
        ShareSDK.showShareEditor(SSDKPlatformType.TypeSinaWeibo, otherPlatformTypes: nil, shareParams: shareParames) { (state :SSDKResponseState, platformType : SSDKPlatformType, userData: [NSObject : AnyObject]!, contentEntity : SSDKContentEntity!, error : NSError!, Bool end) -> Void in
            
            switch state{
                
                case SSDKResponseState.Success: println("分享成功")
                case SSDKResponseState.Fail:    println("分享失败,错误描述:\(error)")
                case SSDKResponseState.Cancel:  println("分享取消")
                
            default:
                break
            }
        }
    }
    
    /**
    * 获取授权用户信息
    */
    @IBAction func OAuth(sender: UIButton) {
        //授权
        ShareSDK.authorize(SSDKPlatformType.TypeSinaWeibo, settings: nil, onStateChanged: { (state : SSDKResponseState, user : SSDKUser!, error : NSError!) -> Void in
            
            switch state{
                
            case SSDKResponseState.Success: println("授权成功,用户信息为\(user)\n ----- 授权凭证为\(user.credential)")
            case SSDKResponseState.Fail:    println("授权失败,错误描述:\(error)")
            case SSDKResponseState.Cancel:  println("操作取消")
                
            default:
                break
            }
        })
    }
}




