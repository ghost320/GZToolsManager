//
//  GZTools.swift
//  TrustToLuck
//
//  Created by Ghost on 16/12/8.
//  Copyright © 2016年 ghost. All rights reserved.
//

import Foundation
import UIKit
//获取min..<max范围内随机数CGFloat：
func random(min:CGFloat,max:CGFloat) -> CGFloat
{
    let primary:UInt32 = 0xFFFFFFFF
    return CGFloat(Float(arc4random()) / Float(primary)) * (max - min) + min
}
//获取min..<max范围内随机数Float：
func random(min:Float,max:Float) -> Float
{
    let primary:UInt32 = 0xFFFFFFFF
    return Float(arc4random()) / Float(UInt32(primary)) * (max - min) + min
}

//获取min...max范围内随机数Int
func random(min:Int,max:Int) -> Int
{
    return Int(arc4random()%UInt32(max-min+1))+min
}


//获取 0..<number范围内随机数Int
func random(number:Int)->Int
{
    return Int(arc4random()%UInt32(number))
}

//获取 0..<number范围内随机数Float
func random(number: Float) -> Float
{
    let primary:UInt32 = 0xFFFFFFFF
    return Float(arc4random()) / Float(primary) * number
}

//获取 0..<number范围内随机数Doubule
func random(number: Double) -> Double
{
    let primary:UInt32 = 0xFFFFFFFF
    return Double(arc4random()) / Double(primary) * number
}

//获取 0..<number范围内随机数CGFloat
func random(number: CGFloat) -> CGFloat
{
    let primary:UInt32 = 0xFFFFFFFF
    return CGFloat(Float(arc4random()) / Float(primary)) * number
}

//获取范围内随机数(貌似还不能用)：
func randomInRange(range:Range<Int>) -> Int
{
    
    //3.0小贴士：'endIndex'被改名为'lowerBound'，'endIndex'被改名为'upperBound'
    let count = UInt32(range.upperBound - range.lowerBound)
    return Int(arc4random_uniform(count)) + range.lowerBound
}
