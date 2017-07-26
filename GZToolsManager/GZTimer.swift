//
//  GZTimer.swift
//  PaintMaster
//
//  Created by Ghost on 2017/6/6.
//  Copyright © 2017年 Ghost. All rights reserved.
//

import Foundation
import UIKit

class GZTimer: Timer {
    
}


func delay(for delayTime: DispatchTimeInterval, onComplete: (()->Void)?)
{
    let delayQueue = DispatchQueue(label: "delayQueue")
    print("权限等级:\(delayQueue.qos)")
//    delayQueue.asyncAfter(deadline: .now() + delayTime, execute: onComplete)
    delayQueue.asyncAfter(deadline: .now() + delayTime){
        onComplete?()
    }
}
