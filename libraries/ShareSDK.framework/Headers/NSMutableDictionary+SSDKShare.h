//
//  NSMutableDictionary+SSDKShare.h
//  ShareSDK
//
//  Created by 冯 鸿杰 on 15/2/9.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSDKTypeDefine.h"
#import "SSDKImage.h"
#import "SSDKData.h"

/**
 *  分享参数构造相关
 */
@interface NSMutableDictionary (SSDKShare)

/**
 *  设置分享标识
 *
 *  @param flags 标识数组，元素为NSString。
 */
- (void)SSDKSetShareFlags:(NSArray *)flags;

/**
 *  使用客户端分享
 */
- (void)SSDKEnableUseClientShare;

/**
 *  设置分享参数
 *
 *  @param text     文本
 *  @param images   图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage，
 *                  如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]
 *  @param url      网页路径/应用路径
 *  @param title    标题
 *  @param type     分享类型
 */
- (void)SSDKSetupShareParamsByText:(NSString *)text
                            images:(id)images
                               url:(NSURL *)url
                             title:(NSString *)title
                              type:(SSDKContentType)type;

/**
 *  设置新浪微博分享参数
 *
 *  @param text      文本
 *  @param title     标题
 *  @param image     图片对象，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param url       分享链接
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param objectID  对象ID，标识系统内内容唯一性，应传入系统中分享内容的唯一标识，没有时可以传入nil
 *  @param type      分享类型，仅支持Text、Image、WebPage（客户端分享时）类型
 */
- (void)SSDKSetupSinaWeiboShareParamsByText:(NSString *)text
                                      title:(NSString *)title
                                      image:(id)image
                                        url:(NSURL *)url
                                   latitude:(double)latitude
                                  longitude:(double)longitude
                                   objectID:(NSString *)objectID
                                       type:(SSDKContentType)type;

/**
 *  设置腾讯微博分享参数
 *
 *  @param text      文本
 *  @param images    分享图片列表,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *                   如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param type      分享类型, 仅支持Text、Image类型
 */
- (void)SSDKSetupTencentWeiboShareParamsByText:(NSString *)text
                                        images:(id)images
                                      latitude:(double)latitude
                                     longitude:(double)longitude
                                          type:(SSDKContentType)type;

/**
 *  设置微信分享参数
 *
 *  @param text         文本
 *  @param title        标题
 *  @param url          分享链接
 *  @param thumbImage   缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param image        图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param musicFileURL 音乐文件链接地址
 *  @param extInfo      扩展信息
 *  @param fileData     文件数据，可以为NSData、UIImage、NSString、NSURL（文件路径）、SSDKData、SSDKImage
 *  @param emoticonData 表情数据，可以为NSData、UIImage、NSURL（文件路径）、SSDKData、SSDKImage
 *  @param type         分享类型，支持SSDKContentTypeText、SSDKContentTypeImage、SSDKContentTypeWebPage、SSDKContentTypeApp、SSDKContentTypeAudio和SSDKContentTypeVideo
 *  @param platformType 平台子类型，只能传入SSDKPlatformTypeWechatSession、SSDKPlatformTypeWechatTimeline和SSDKPlatformTypeWechatFav其中一个
 *
 *  分享文本时：
 *  设置type为SSDKContentTypeText, 并填入text参数
 *
 *  分享图片时：
 *  设置type为SSDKContentTypeImage, 非gif图片时：填入title和image参数，如果为gif图片则需要填写title和emoticonData参数
 *
 *  分享网页时：
 *  设置type为SSDKContentTypeWebPage, 并设置text、title、url以及thumbImage参数，如果尚未设置thumbImage则会从image参数中读取图片并对图片进行缩放操作。
 *
 *  分享应用时：
 *  设置type为SSDKContentTypeApp，并设置text、title、extInfo（可选）以及fileData（可选）参数。
 *
 *  分享音乐时：
 *  设置type为SSDKContentTypeAudio，并设置text、title、url以及musicFileURL（可选）参数。
 *
 *  分享视频时：
 *  设置type为SSDKContentTypeVideo，并设置text、title、url参数
 */
- (void)SSDKSetupWeChatParamsByText:(NSString *)text
                              title:(NSString *)title
                                url:(NSURL *)url
                         thumbImage:(id)thumbImage
                              image:(id)image
                       musicFileURL:(NSURL *)musicFileURL
                            extInfo:(NSString *)extInfo
                           fileData:(id)fileData
                       emoticonData:(id)emoticonData
                               type:(SSDKContentType)type
                 forPlatformSubType:(SSDKPlatformType)platformSubType;

/**
 *  设置Twitter分享参数
 *
 *  @param text      分享内容
 *  @param images    分享图片列表,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *                   如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]
 *  @param latitude  地理位置，纬度
 *  @param longitude 地理位置，经度
 *  @param type      分享类型，仅支持Text、Image类型
 */
- (void)SSDKSetupTwitterParamsByText:(NSString *)text
                              images:(id)images
                            latitude:(double)latitude
                           longitude:(double)longitude
                                type:(SSDKContentType)type;

/**
 *  设置QQ分享参数
 *
 *  @param text            分享内容
 *  @param title           分享标题
 *  @param url             分享链接
 *  @param thumbImage      缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param image           图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param type            分享类型, 仅支持Text（仅QQFriend）、Image（仅QQFriend）、WebPage、Audio、Video类型
 *  @param platformSubType 平台子类型，只能传入SSDKPlatformSubTypeQZone或者SSDKPlatformSubTypeQQFriend其中一个
 */
- (void)SSDKSetupQQParamsByText:(NSString *)text
                          title:(NSString *)title
                            url:(NSURL *)url
                     thumbImage:(id)thumbImage
                          image:(id)image
                           type:(SSDKContentType)type
             forPlatformSubType:(SSDKPlatformType)platformSubType;

/**
 *  设置Facebook分享参数
 *
 *  @param text  分享内容
 *  @param image 图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param type  分享类型，仅支持Text、Image类型
 */
- (void)SSDKSetupFacebookParamsByText:(NSString *)text
                                image:(id)image
                                 type:(SSDKContentType)type;

/**
 *  设置短信分享参数
 *
 *  @param text        文本
 *  @param title       标题
 *  @param images      分享图片列表,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *                   如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]
 *  @param attachments 附件列表, 可以为单个附件也可以为一个数组，元素可以为NSData、UIImage、NSString、NSURL（文件路径）、SSDKData、SSDKImage，注：只允许指定本地资源
 *  @param recipients  接收人信息，如：@[@"400-685-2216"]
 *  @param type        分享类型，仅支持Text、Image类型
 */
- (void)SSDKSetupSMSParamsByText:(NSString *)text
                           title:(NSString *)title
                          images:(id)images
                     attachments:(id)attachments
                      recipients:(NSArray *)recipients
                            type:(SSDKContentType)type;

/**
 *  设置邮件分享参数
 *
 *  @param text          文本
 *  @param title         标题
 *  @param images        分享图片列表,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *                   如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]
 *  @param attachments   附件列表, 可以为单个附件也可以为一个数组，元素可以为NSData、UIImage、NSString、NSURL（文件路径）、SSDKData、SSDKImage，注：只允许指定本地资源
 *  @param recipients    接收人信息，如：@["tester@163.com"]
 *  @param ccRecipients  抄送人信息，如：@["tester2@163.com"]
 *  @param bccRecipients 密送人信息，如：@["tester3@163.com"]
 *  @param type          分享类型，仅支持Text、Image类型
 */
- (void)SSDKSetupMailParamsByText:(NSString *)text
                            title:(NSString *)title
                           images:(id)images
                      attachments:(id)attachments
                       recipients:(NSArray *)recipients
                     ccRecipients:(NSArray *)ccRecipients
                    bccRecipients:(NSArray *)bccRecipients
                             type:(SSDKContentType)type;

/**
 *  设置拷贝参数
 *
 *  @param text   文本，仅在type为Text时有效
 *  @param images 分享图片列表,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *                   如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]，仅在type为Image时有效。
 *  @param url    链接，仅在type为WebPage时有效
 *  @param type   分享类型，仅支持Text、Image、WebPage类型
 */
- (void)SSDKSetupCopyParamsByText:(NSString *)text
                           images:(id)images
                              url:(NSURL *)url
                             type:(SSDKContentType)type;

/**
 *  设置豆瓣分享参数
 *
 *  @param text  文本
 *  @param image 分享图片，当type为Image时，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。当type为WebPage时，只能为网络图片，可以传入NSString（图片路径）、NSURL（图片路径）。
 *  @param title 网页标题，仅在type为WebPage时有效。
 *  @param url   网页链接，仅在type为WebPage时有效。
 *  @param urlDesc 网页描述，仅在type为WebPage时有效。
 *  @param type  分享类型，仅支持Text、Image、WebPage类型
 */
- (void)SSDKSetupDouBanParamsByText:(NSString *)text
                              image:(id)image
                              title:(NSString *)title
                                url:(NSURL *)url
                            urlDesc:(NSString *)urlDesc
                               type:(SSDKContentType)type;

/**
 *  设置人人网分享参数
 *
 *  @param text    文本
 *  @param image   分享图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage，仅在type为Image时有效。
 *  @param url     网页链接，仅在type为WebPage时有效。
 *  @param albumId 相册ID，指定分享的图片要放入哪个相册，默认为nil，仅在type为Image时有效。
 *  @param type    分享类型，仅支持Image、WebPage类型
 */
- (void)SSDKSetupRenRenParamsByText:(NSString *)text
                              image:(id)image
                                url:(NSURL *)url
                            albumId:(NSString *)albumId
                               type:(SSDKContentType)type;

/**
 *  设置开心网分享参数
 *
 *  @param text  文本
 *  @param image 分享图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage，仅在type为Image时有效。
 *  @param type  分享类型，仅支持Text、Image类型
 */
- (void)SSDKSetupKaiXinParamsByText:(NSString *)text
                              image:(id)image
                               type:(SSDKContentType)type;

/**
 *  设置Pocket分享参数
 *
 *  @param url     分享链接
 *  @param title   标题
 *  @param tags    标签，可以为NSString或者NSArray。为NSString时，标签名称要以逗号分隔；为NSArray时，元素为NSString。
 *  @param tweetId 关联的推文ID
 */
- (void)SSDKSetupPocketParamsByUrl:(NSURL *)url
                             title:(NSString *)title
                              tags:(id)tags
                           tweetId:(NSString *)tweetId;

/**
 *  设置GooglePlus分享参数
 *
 *  @param text       文本
 *  @param image      分享图片，当type为Image时，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。当type为WebPage时，只能为网络图片，可以传入NSString（图片路径）、NSURL（图片路径）
 *  @param url        分享链接，仅在type为WebPage时有效
 *  @param title      链接标题，仅在type为WebPage并且设置deepLinkId时生效。
 *  @param urlDesc    链接描述，仅在type为WebPage并且设置deepLinkId时生效。
 *  @param deepLinkId DeepLink标识， 仅在type为WebPage时有效
 *  @param type  分享类型，仅支持Text、Image、WebPage类型
 */
- (void)SSDKSetupGooglePlusParamsByText:(NSString *)text
                                  image:(id)image
                                    url:(NSURL *)url
                                  title:(NSString *)title
                                urlDesc:(NSString *)urlDesc
                             deepLinkId:(NSString *)deepLinkId
                                   type:(SSDKContentType)type;

/**
 *  设置Instagram分享参数
 *
 *  @param image     分享图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage，仅在type为Image时有效。
 *  @param point     分享菜单的显示位置，仅用于iPad版
 */
- (void)SSDKSetupInstagramByImage:(id)image
                 menuDisplayPoint:(CGPoint)point;

/**
 *  设置LinkedIn分享参数
 *
 *  @param text       分享文本
 *  @param image      分享图片，只能够是网络图片，传入类型可以为NSString（图片路径）， NSURL（图片路径）。
 *  @param url        分享链接
 *  @param title      标题
 *  @param urlDesc    链接的相关描述
 *  @param visibility 可见性，可以传入anyone或者connections-only，默认为anyone
 *  @param type       分享类型,仅支持Text和WebPage
 */
- (void)SSDKSetupLinkedInParamsByText:(NSString *)text
                                image:(id)image
                                  url:(NSURL *)url
                                title:(NSString *)title
                              urlDesc:(NSString *)urlDesc
                           visibility:(NSString *)visibility
                                 type:(SSDKContentType)type;

/**
 *  设置Tumblr分享参数
 *
 *  @param text  分享文本
 *  @param image 分享图片，只能够是网络图片，传入类型可以为NSString（图片路径）， NSURL（图片路径）。
 *  @param url   分享链接
 *  @param title 标题
 *  @param blogName 博客名称，如果为nil，则默认分享到默认博客中。
 *  @param type  分享类型，仅支持Text和Image
 */
- (void)SSDKSetupTumblrParamsByText:(NSString *)text
                              image:(id)image
                                url:(NSURL *)url
                              title:(NSString *)title
                           blogName:(NSString *)blogName
                               type:(SSDKContentType)type;

/**
 *  设置Flickr分享参数
 *
 *  @param text        图片描述
 *  @param image       分享图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。
 *  @param title       图片标题
 *  @param tags        图片标签列表
 *  @param isPublic    指定是否公开图片，NO 私有 YES 公开。
 *  @param isFriend    指定好友是否可以查看图片，NO 不允许，YES 允许
 *  @param isFamily    指定家人是否可以查看图片，NO 不允许，YES 允许
 *  @param safetyLevel 安全级别。1 安全 2 辅导级 3 限制级。
 *  @param contentType 1 照片、2 屏幕截图、3 其他。
 *  @param hidden      1 照片、2 屏幕截图、3 其他。
 */
- (void)SSDKSetupFlickrParamsByText:(NSString *)text
                              image:(id)image
                              title:(NSString *)title
                               tags:(NSArray *)tags
                           isPublic:(BOOL)isPublic
                           isFriend:(BOOL)isFriend
                           isFamily:(BOOL)isFamily
                        safetyLevel:(NSInteger)safetyLevel
                        contentType:(NSInteger)contentType
                             hidden:(NSInteger)hidden;

/**
 *  设置WhatsApp分享参数
 *
 *  @param text  分享文本
 *  @param image 分享图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。
 *  @param audio 分享音频, 可以为NSData、NSString、NSURL（文件路径）、SSDKData、注：只允许指定本地资源
 *  @param video 分享视频, 可以为NSData、NSString、NSURL（文件路径）、SSDKData、注：只允许指定本地资源
 *  @param point 分享菜单的显示位置，仅用于iPad版
 *  @param type  分享类型，仅支持Text、Image、Audio、Video
 */
- (void)SSDKSetupWhatsAppParamsByText:(NSString *)text
                                image:(id)image
                                audio:(id)audio
                                video:(id)video
                     menuDisplayPoint:(CGPoint)point
                                 type:(SSDKContentType)type;

/**
 *  设置有道云笔记分享参数
 *
 *  @param text   分享文本
 *  @param images 分享图片列表,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage，
 *                  如: @"http://mob.com/Assets/images/logo.png?v=20150320" 或 @[@"http://mob.com/Assets/images/logo.png?v=20150320"]
 *  @param title  标题
 *  @param source 来源
 *  @param author 作者
 *  @param notebook 笔记本
 */
- (void)SSDKSetupYouDaoNoteParamsByText:(NSString *)text
                                 images:(id)images
                                  title:(NSString *)title
                                 source:(NSString *)source
                                 author:(NSString *)author
                               notebook:(NSString *)notebook;

@end
