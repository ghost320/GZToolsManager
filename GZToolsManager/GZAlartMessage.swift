//
//  GZAlartMessage.swift
//  PaintMaster
//
//  Created by somethingbig on 2017/7/27.
//  Copyright © 2017年 Ghost. All rights reserved.
//  各种弹出信息

import Foundation
import StoreKit


/// 弹出app评论
///
/// - Parameters:
///   - id: app的id
///   - controller: 当前的viewCongroller
func showComment(id: String, controller:UIViewController? = nil)
{
    if #available(iOS 10.3, *) {
        SKStoreReviewController.requestReview()
    } else {
        //弹出对话框
        let alert = UIAlertController(title: CommentString.title, message: CommentString.msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommentString.notNow, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: CommentString.nowGo, style: .default, handler: { (alert) in
            let urlString = "itms-apps://itunes.apple.com/app/id\(id)"
           
            if let url = URL(string: urlString)
            {
                 print(url)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                        
                    })
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }))
        controller?.present(alert, animated: true, completion: nil)
    }
}

struct CommentString {
    static let nowGo = NSLocalizedString("现在就去", comment: "现在就去")
    static let notNow = NSLocalizedString("暂不评论", comment: "暂不评论")
    static let title = NSLocalizedString("觉得好就给一个评价吧", comment: "觉得好就给一个评价吧")
    static let msg = NSLocalizedString("可以告诉我们你的使用感受\n或者一些意见和建议", comment: "可以告诉我们你的使用感受\n或者一些意见和建议")
}
