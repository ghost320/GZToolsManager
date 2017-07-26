//
//  Info.swift
//  PaintMaster
//
//  Created by somethingbig on 2017/7/17.
//  Copyright © 2017年 Ghost. All rights reserved.
//

import Foundation
import UIKit


/// 设备,app信息
struct  AppInfo {
    
    static let infoDictionary = Bundle.main.infoDictionary
    
    ///App名称
    static let appDisplayName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String //App 名称
    /// Bundle Identifier
    static let bundleIdentifier:String = Bundle.main.bundleIdentifier! // Bundle Identifier
    /// App 版本号
    static let appVersion:String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String// App 版本号
    ///Bulid 版本号
    static let buildVersion : String = Bundle.main.infoDictionary! ["CFBundleVersion"] as! String //Bulid 版本号
    ///ios 版本
    static let iOSVersion:String = UIDevice.current.systemVersion //ios 版本
    ///设备 udid
    static let identifierNumber = UIDevice.current.identifierForVendor //设备 udid
    ///设备名称
    static let systemName = UIDevice.current.systemName //设备名称
    /// 设备型号
    static let model = UIDevice.current.model // 设备型号
    ///设备区域化型号
    static let localizedModel = UIDevice.current.localizedModel  //设备区域化型号
    
}

