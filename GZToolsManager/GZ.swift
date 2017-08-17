//
//  GZ.swift
//  PaintMaster
//
//  Created by somethingbig on 2017/8/16.
//  Copyright © 2017年 Ghost. All rights reserved.
//  单例,普遍app用到的东西都放这里

import Foundation


class GZ {
    static let share = GZ()
    private init()
    {
        
    }
    
    //MARK: - 属性
    
    //私有属性
    
    // 用于存储运行次数的 UserDefauls 字典键
    private let runIncrementerSetting = "numberOfRuns"
    // 询问评分的最少运行次数
    private var minimumRunCount = 8
    
    
    
    //MARK: - 方法
    
    //设置评论的计算次数
    func setRunCount(count:Int) {
        minimumRunCount = count
    }
    // app 运行次数计数器。可以在 App Delegate 中调用此方法
    private func incrementAppRuns() {
        
        let usD = UserDefaults()
        let runs = getRunCounts() + 1
        usD.setValuesForKeys([runIncrementerSetting: runs])
        usD.synchronize()
        
    }
    // 从 UserDefaults 里读取运行次数并返回。
    private func getRunCounts () -> Int {
        
        let usD = UserDefaults()
        let savedRuns = usD.value(forKey: runIncrementerSetting)
        
        var runs = 0
        if (savedRuns != nil) {
            
            runs = savedRuns as! Int
        }
        
        print("已运行\(runs)次")
        return runs
        
    }
    
    func showReview(doSthing:(()->())?)
    {
        incrementAppRuns()
        let runs = getRunCounts()
        if runs > minimumRunCount
        {
            doSthing?()
            let usD = UserDefaults()
            usD.setValuesForKeys([runIncrementerSetting:0])
        }
        
    }
}


