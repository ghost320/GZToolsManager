//
//  OpenShareExt.swift
//  PaintMaster
//
//  Created by somethingbig on 2017/8/11.
//  Copyright © 2017年 Ghost. All rights reserved.
//

/*
 可选：支持QQ所需的相关配置及代码 登录QQ互联（http://connect.qq.com/ ）注册成为开发者并登记应用取得AppId，然后打开下图位置，在URL Types中添加QQ的AppID，其格式为：”QQ” ＋ AppId的16进制（如果appId转换的16进制数不够8位则在前面补0，如转换的是：5FB8B52，则最终填入为：QQ05FB8B52 注意：转换后的字母要大写） 转换16进制的方法：echo ‘ibase=10;obase=16;801312852′|bc，其中801312852为QQ的AppID，见下图
 */

import Foundation
//import OpenShare
import MonkeyKing

//extension OpenShare
//{
//    static func shareToQQFriends()
//    {
//        let imgData = UIImagePNGRepresentation(UIImage(named: "800x800")!)
//        let msg = OSMessage()
//        msg.title = "涂鸦大师"
//        msg.link = "https://itunes.apple.com/cn/app/id1256568502"
//        msg.desc = "一款可萌可萌的个性化绘图软件"
//        msg.image = imgData
//        msg.thumbnail = imgData
//
//        OpenShare.share(toQQFriends: msg, success: { (msg) in
//            print("🙂success")
//        }) { (msg, err) in
//            print("fail")
//        }
//
//    }
//
//    static func shareToWeibo() {
//        let imgData = UIImagePNGRepresentation(UIImage(named: "800x800")!)
//        let msg = OSMessage()
//        msg.title = "涂鸦大师-一款可萌可萌的个性化涂鸦工具\n下载地址:https://itunes.apple.com/cn/app/id1256568502"
//        // msg.link = "https://itunes.apple.com/cn/app/id1256568502"
//        msg.desc = "一款可萌可萌的个性化绘图软件"
//        msg.image = imgData
//        msg.thumbnail = imgData
//
//        OpenShare.share(toWeibo: msg, success: { (msg) in
//            print("🙂success")
//        }) { (msg, err) in
//            print("fail")
//        }
//    }
//
//}


extension MonkeyKing
{
    ///公用info
    static var normalInfo:MonkeyKing.Info{
        let info:MonkeyKing.Info = MonkeyKing.Info(
            title: PMString.navigationTitlePaintMaster,
            description: ShareString.introduction,
            thumbnail: UIImage(named: "800x800"),
            media:MonkeyKing.Media.url(URL(string: PMString.appItunesURL)!))
        
        return info
    }
    ///快捷发送给微信好友
    static func shareToWeChatFriend()
    {
        share(info: normalInfo, index: 0) {
            print("分享微信成功")
        }
    }
    ///快捷发送给微信朋友圈
    static func shareToWeChatTimeline()
    {
        share(info: normalInfo, index: 1) {
            print("分享微信朋友圈成功")
        }
    }
    
    ///快捷微信收藏
    static func shareToWeChatFavorite()
    {
        share(info: normalInfo, index: 2) {
            print("微信收藏成功")
        }
    }
    
    ///快捷分享QQ好友
    static func shareToQQFriend()
    {
        share(info: normalInfo, index: 3) {
            print("发送给QQ好友成功")
        }
    }
    
    
    ///快捷分享到QQ我的电脑
    static func shareToQQDataLine()
    {
        share(info: normalInfo, index: 4) {
            print("发送到QQ我的电脑成功")
        }
    }
    
    ///快捷分享到QQ空间
    static func shareToQQZone()
    {
        share(info: normalInfo, index: 5) {
            print("发送到QQ空间成功")
        }
    }
    
    ///快捷收藏到QQ
    static func shareToQQFavorite()
    {
        share(info: normalInfo, index: 6) {
            print("收藏到QQ成功")
        }
    }
    
    ///快捷分享到微博
    static func shareToWeibo()
    {
        
        let info:MonkeyKing.Info = MonkeyKing.Info(
            title: PMString.navigationTitlePaintMaster,
            description: "\(PMString.navigationTitlePaintMaster):https://itunes.apple.com/cn/app/id\(PMString.appID)\n\(ShareString.introduction)",
            thumbnail: UIImage(named: "800x800"),
            media:MonkeyKing.Media.image(UIImage(named: "800x800")!))
        
        share(info: info, index: 7) {
            print("分享到微博成功")
        }
    }
    
    
    
    
    
    /// 分享
    ///
    /// - Parameters:
    ///   - info: MonkeyKing.Info
    ///   - index: 0-微信好友,1-微信朋友圈,2-微信收藏,3-qq好友,4-qq我的电脑,5-qq空间,6-qq收藏,7-微博
    ///   - complete: 成功后回调
    static func share(info:MonkeyKing.Info, index:Int,successHandler:(()->())?)
    {
        var message: MonkeyKing.Message?
        switch index {
        case 0:
            message = MonkeyKing.Message.weChat(.session(info:info))
        case 1:
            message = MonkeyKing.Message.weChat(.timeline(info:info))
        case 2:
            message = MonkeyKing.Message.weChat(.favorite(info:info))
        case 3:
            message = MonkeyKing.Message.qq(.friends(info: info))
        case 4:
            message = MonkeyKing.Message.qq(.dataline(info: info))
        case 5:
            message = MonkeyKing.Message.qq(.zone(info: info))
        case 6:
            message = MonkeyKing.Message.qq(.favorites(info: info))
        case 7:
            
            message = MonkeyKing.Message.weibo(.default(info: info, accessToken: nil))
        default:
            break
        }
        if let message = message
        {
            MonkeyKing.deliver(message, completionHandler: { (result) in
                print("result = \(result)")

                switch result
                {
                case .success(let reponse):
                    print("成功:\(reponse)")
                    successHandler?()
                    break
                case .failure(let error):
                    print("失败:\(error)")
                    break
                }

                
            })
        }
    }
    
}



struct ShareString {
    static let introduction = NSLocalizedString("iOS上一款可萌可萌的个性化绘图软件", comment: "iOS上一款可萌可萌的个性化绘图软件")
}









