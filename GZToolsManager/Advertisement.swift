//
//  Advertisement.swift
//  PaintMaster
//
//  Created by somethingbig on 2017/7/5.
//  Copyright © 2017年 Ghost. All rights reserved.
//

import Foundation
import Firebase

struct GZAdMob {
    
    
    /// 初始化谷歌广告,这个方法用在AppDelegate.swift中的 didFinishLaunchingWithOptions 方法中
    ///
    /// - Parameter ApplicationID: 谷歌广告ID
    static func setupAdMob(with ApplicationID:String)
    {
        //谷歌广告
        // Use Firebase library to configure APIs
        FIRApp.configure()
        // Initialize Google Mobile Ads SDK
        GADMobileAds.configure(withApplicationID: ApplicationID)
    }
}
