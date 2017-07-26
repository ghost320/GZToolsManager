//
//  GZSequenceFrameAnimation.swift
//  SomethingTest
//
//  Created by somethingbig on 2017/7/3.
//  Copyright © 2017年 somethingbig. All rights reserved.
//

import UIKit

class GZSequenceFrameAnimation: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    ///当前播放帧
    private var currentFrame:Int
    ///总帧数
    private var totalFrame = 0
    ///是否正在播放
    private var isPlaying = false
    
    ///序列名称
    private var name:String
    
    ///是否排序: true就是 序列0000.jpg - 序列1000.jpg; false就是 序列0.jpg - 序列1000.jpg
    private var isSort = true
    
    ///排序长度, 序列0000.jpg 为4
    private var length = 0
    
    ///总计时器  控制序列播放
    private var timer:DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource( queue: .main)
        return timer
    }()
    
    ///循环间隔计时器
    
    ///是否循环播放
    var isRepeat = false
    
    ///如若循环,中间间隔时间,默认3秒
    var repeatIntervalTime = 3
    
    ///第一帧index,默认为0,就是从序列0000.jpg开始
    var defaultIndex = 0
    
    
    ///动画播放速度速度,默认为33毫秒
    private var defaultSpeed = DispatchTimeInterval.milliseconds(33) {
        didSet {
            timer.scheduleRepeating(deadline: .now(), interval: defaultSpeed, leeway:DispatchTimeInterval.milliseconds(100))
        }
    }
    
    
    
    init(name: String, startFrame: String, endFrame: String, frame: CGRect) {
        self.name = name
        currentFrame = defaultIndex
        super.init(frame: frame)
        
        totalFrame = Int(endFrame)! - Int(startFrame)!
        print(totalFrame)
        changeImg(at: 0)
    }
    
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - name: 序列名称
    ///   - totalFrame: 序列总帧数
    ///   - frame: 图片大小
    ///   - isSort: 是否排序: true就是 序列0000.jpg - 序列1000.jpg; false就是 序列0.jpg - 序列1000.jpg
    ///   - length: 排序长度, 序列0000.jpg 为4
    init(name: String,totalFrame: Int, frame: CGRect, isSort: Bool, length: Int, speedInterval:DispatchTimeInterval) {
        self.name = name
        currentFrame = defaultIndex
        super.init(frame: frame)
        
        self.totalFrame = totalFrame
        self.isSort = isSort
        self.length = length
        self.defaultSpeed = speedInterval
        
        setupTimer()
        
//        timerStart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: - 定时器相关
    
    private func setupTimer()
    {
        //
        timer.scheduleRepeating(deadline: .now(), interval: defaultSpeed, leeway:DispatchTimeInterval.milliseconds(100))
        timer.setEventHandler{
            self.timerHandler()
        }
        
    }
    
    
    ///大步骤定时器方法
    private func timerHandler() {
        print("timerHandler()")
        //如果当前帧数大于总帧数,那么就停止计数器
        if currentFrame == totalFrame
        {
            print("最后一帧了")
            timerStop()
            if isRepeat && repeatIntervalTime > 0 {
                print("循环")
                
                currentFrame = defaultIndex
                
                
                
//                let timer = DispatchSource.makeTimerSource( queue: .main)
//                var timerStep = repeatIntervalTime
//                timer.scheduleRepeating(deadline: .now(), interval: DispatchTimeInterval.milliseconds(1000), leeway:DispatchTimeInterval.milliseconds(100))
//                timer.setEventHandler{
//                    print(timerStep)
//                    timerStep -= 1
//                    if timerStep == 0
//                    {
//                        timer.cancel()
//                        self.timerStart()
//                    }
//                }
//                timer.resume()
                
                
                delay(for: DispatchTimeInterval.seconds(2), onComplete: {
                    print("isPlaying = \(self.isPlaying)")
                    
                    if self.isRepeat == true
                    {
                        self.timerStart()
                    }
                    
                })
                
                
            }else
            {
                currentFrame = defaultIndex
                timerStart()
            }
            
            
        }else
        {
            
            playNextStep()
        }
        
    }
    
    //计时器控制开关
    private func timerStart() {
        if !isPlaying {
            timer.resume()
            isPlaying = true
            print("timerStart")
        }
    }
    private func timerStop()
    {
        if isPlaying {
            timer.suspend()
            isPlaying = false
            print("timerStop(计时器停止)")
        }
    }
    
    private func timerDestroy()
    {
        timer.cancel()
        isPlaying = false
    }

    
    
    ///播放下一帧
    private func playNextStep()
    {
        print("playNextStep(下一帧)")
        currentFrame += 1
        changeImg(at: currentFrame)
        
    }
    ///切换图片
    private func changeImg(at index:Int)
    {
        let fileName:String? = name + String(format: "%0\(length)d", index)
        let filePath = Bundle.main.path(forResource: fileName, ofType: "png")
        let image = UIImage(contentsOfFile: filePath!)
        self.image = image
    }
    
    
    
    //MARK: - 公共方法
    
    ///开始播放序列(定时器开始)
    func play() {
        timerStart()
    }
    ///暂停播放序列(定时器暂停)
    func pause()
    {
        timerStop()
    }
    ///停止播放序列(定时器销毁)
    func stop()
    {
        timerDestroy()
    }
    
    func setup(name: String,totalFrame: Int, isSort: Bool, length: Int, speedInterval:DispatchTimeInterval, isRepeat:Bool)
    {
        timerStop()
        self.name = name
        currentFrame = defaultIndex
        self.totalFrame = totalFrame
        self.isSort = isSort
        self.length = length
        self.defaultSpeed = speedInterval
        self.isRepeat = isRepeat
        
        
    }

}
