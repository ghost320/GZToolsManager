//
//  Extensions.swift
//  TrustToLuck
//
//  Created by Ghost on 2016/12/18.
//  Copyright © 2016年 ghost. All rights reserved.
//
import QuartzCore
import CoreImage
import UIKit


//声明阴影需要的结构体
struct GZShadowInfo
{
    var color: CGColor
    var offset: CGSize
    var opacity: Float
    var radius: CGFloat
    var path: CGPath?
    init(color:CGColor,offset: CGSize, opacity: Float, radius: CGFloat)
    {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
    }
    
    init(color:CGColor,offset: CGSize, opacity: Float, radius: CGFloat, path: CGPath)
    {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
        self.path = path
    }
    
    
}




extension UIView
{
    ///添加自适应
    func addConstraints(withVisualFormat visualFormat:String, views:UIView...)
    {
        var viewDict = [String: UIView]()
        for (index, view) in views.enumerated()
        {
            let key = "v\(index)"
            viewDict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: NSLayoutFormatOptions(), metrics: nil, views: viewDict))
    }
    
    ///添加撑满屏幕的自适应
    func addConstraints(limit:Int,view:UIView)
    {
        self.addConstraints(withVisualFormat: "H:|-\(limit)-[v0]-\(limit)-|", views: view)
        self.addConstraints(withVisualFormat: "V:|-\(limit)-[v0]-\(limit)-|", views: view)
    }
    ///添加撑满屏幕的自适应
    func addConstraints(verticalLimit:Int,view:UIView)
    {
        self.addConstraints(withVisualFormat: "V:|-\(verticalLimit)-[v0]-\(verticalLimit)-|", views: view)
    }
    ///添加撑满屏幕的自适应
    func addConstraints(horizontalLimit:Int,view:UIView)
    {
        self.addConstraints(withVisualFormat: "H:|-\(horizontalLimit)-[v0]-\(horizontalLimit)-|", views: view)
    }
    
    
    
    //根据UIView的transform获取旋转角度
    func getRadians() -> CGFloat
    {
        let radians = atan2( self.transform.b, self.transform.a)
        return radians
    }
    func getDegress() -> CGFloat
    {
        let radians = atan2( self.transform.b, self.transform.a)
        let degrees = radians * (180 / CGFloat.pi)
        return degrees
    }
    
    ///设置阴影
    func setShadow(info:GZShadowInfo)
    {
        //加阴影--任海丽编辑
        self.layer.shadowColor = info.color;//shadowColor阴影颜色
        self.layer.shadowOffset = info.offset;//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = info.opacity;//阴影透明度，默认0
        self.layer.shadowRadius = info.radius;//阴影半径，默认3
    }
    
    ///删除所有子view
    func removeAllSubViews()
    {
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
    }
    
    //获取父类
    ///返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
    
    ///判断是否包含某VIEW
    func didAdd(subView:AnyClass)->Bool
    {
        for view in self.subviews
        {
            if view.isKind(of: subView)
            {
                return true
            }
        }
        return true
    }
}


extension UITableView
{
    ///删除多余的空cell
    func removeSpaceCells() {
        self.tableFooterView = UIView()
    }
    
    ///设置背景颜色
    func setBackgroundColor(to color:UIColor)
    {
        self.backgroundView?.backgroundColor = color
        self.backgroundColor = color
    }
}



extension UITableViewCell
{
    //隐藏cell分割线
    //暂时失效
    func hideSeparator()
    {
        //        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width)
        print("\n\n\n开始找tableView了")
        if let tableView = self.superView(of: UITableView.self)
        {
            self.separatorInset = UIEdgeInsetsMake(0, 0, 0, tableView.bounds.width)
            print("\n\n\n找到tableView了")
        }
        
    }
    
    ///隐藏cell分割线
    func hideSeparator(from tableView:UITableView)
    {
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, tableView.bounds.width)
    }
    
}







extension UIImage
{
    
    /**
     *  改变图片尺寸
     */
    
    func scaleToSize(size: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    
    /**
     *  重设图片大小
     */
//    func reSizeImage(reSize:CGSize)->UIImage {
//        //UIGraphicsBeginImageContext(reSize);
//        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
//        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
//        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return reSizeImage
//    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return scaleToSize(size: reSize)
    }
    
    /**
     *  截取图片
     */
    func clipImageInRect(rect:CGRect)->UIImage
    {
        let imageRef: CGImage = self.cgImage!.cropping(to: rect)!
        
        
        
        
        let thumbScale: UIImage = UIImage(cgImage: imageRef)
//        CGImageRelease(imageRef)
        return thumbScale
    }
}

extension UIPickerView
{
    ///去除分割线
    func clearSpearatorLine()
    {
        for view in self.subviews
        {
            if view.frame.size.height < 1
            {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    func setSpearatorLine(by color:UIColor)
    {
        for view in self.subviews
        {
            if view.frame.size.height < 1
            {
                view.backgroundColor = color
            }
        }
    }
}

extension UITextField
{
    ///设置placeholder的颜色
    func setPlaceholder(placeholder: String, color: UIColor)
    {
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: color])
    }
}


extension UILabel
{
    ///修改行距,在设置label的text属性之后,在设对齐之前调用
    func setLineSpacing(spacing:CGFloat)
    {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, self.text!.characters.count))
        self.attributedText = attributedString
//        self.sizeToFit()
    }
}




extension UIColor
{
    ///根据rgb设置颜色
    static func rgb(r:CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
    static func rgb(r:CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
        return color
    }
    
    ///生成UIImage
    func createUIImage(frame:CGRect) -> UIImage? {
        // 开始绘图
        UIGraphicsBeginImageContext(frame.size)
        
        // 获取绘图上下文
        let context = UIGraphicsGetCurrentContext()
        // 设置填充颜色
        context?.setFillColor(self.cgColor)
        // 使用填充颜色填充区域
        context?.fill(frame)
        
        // 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 结束绘图
        UIGraphicsEndImageContext()
        return image
    }
}

extension UserDefaults
{
    ///清空
    func clear()
    {
        let appDomain = Bundle.main.bundleIdentifier!
        self.removePersistentDomain(forName: appDomain)
        
    }
}



extension Float
{
    //角度转换
    ///把弧度转成角度
    func getAngle() -> Float
    {
        return ((self) * (180.0 / Float.pi))
    }
    ///把角度转成弧度
    func getRadians() -> Float
    {
        return ((self) / 180.0 * Float.pi)
    }
    
    ///转CGFloat
    func toCGFloat()->CGFloat
    {
        return CGFloat(Double(String(self))!)
    }
}

extension String
{
    ///转成CGFloat
    func toCGfloat()->CGFloat
    {
        if let n = NumberFormatter().number(from: self) {
            let f = CGFloat(n)
            return f
        }else
        {
            return 0
        }
    }
}

extension CGFloat
{
    //角度转换
    ///把弧度转成角度
    func getAngle() -> CGFloat
    {
        return ((self) * (180.0 / CGFloat.pi))
    }
    ///把角度转成弧度
    func getRadians() -> CGFloat
    {
        return ((self) / 180.0 * CGFloat.pi)
    }
}
extension Array
{
    static func create<T>(with obj:T,length:Int) -> Array<T>
    {
        var tempArray = Array<T>()
        
        for _ in 1...length
        {
            tempArray.append(obj)
        }
        print("\n\n\ntempArray = \(tempArray)")
        return tempArray
    }
}


extension UIToolbar
{
    func setItemsWithAnimate(_ items: [UIBarButtonItem]?) {
        self.setItems(items, animated: true)
        UIView.beginAnimations(nil, context: nil)
        self.layoutIfNeeded()
        UIView.commitAnimations()
    }
}

extension CGPath
{
    func changeToUIBezierPath() -> UIBezierPath
    {
        return UIBezierPath(cgPath: self)
    }
    
    func changeToData() -> Data
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return data
    }
}

extension UIBezierPath
{
    func changeToCGPath() -> CGPath
    {
        return self.cgPath
    }
    func changeToCGMutablePath() -> CGMutablePath {
        let a =  CGMutablePath()
        a.addPath(self.cgPath)
        return a
        
    }
    
    func changeToData() -> Data
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return data
    }
}

extension Data
{
    func changeToUIBezierPath() -> UIBezierPath
    {
        return NSKeyedUnarchiver.unarchiveObject(with: self) as! UIBezierPath
    }
}




//extension CGMutablePath
//{
//    var paths:[CGMutablePath]? {
//        get{
//            return self.paths
//        }
//        
//        set{
//            self.paths = newValue
//        }
//    }
//    
//    func addAniPath(_ path: CGMutablePath) {
//        if paths == nil
//        {
//            paths = [CGMutablePath]()
//        }else
//        {
//            paths!.append(path)
//            self.addPath(path)
//        }
//        
//    }
//}



/*
extension MKMapView
{
    public func setCenterCoordinateLevel(centerCoordinate:CLLocationCoordinate2D, zoomLevel:Double,animated:Bool) {
        //设置最小缩放级别
        var zoomLevel = zoomLevel
        zoomLevel  = min(zoomLevel, 22)
        
        let span   = self.coordinateSpanWithMapView(mapView: self, centerCoordinate: centerCoordinate, zoomLevel: zoomLevel);
        let region = MKCoordinateRegionMake(centerCoordinate, span);
        
        self.setRegion(region, animated: animated)
        
    }
    
    func longitudeToPixelSpaceX(longitude:Double) ->Double {
        return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0)
    }
    
    func latitudeToPixelSpaceY(latitude:Double) ->Double {
        return round(MERCATOR_OFFSET - MERCATOR_RADIUS * log((1 + sin(latitude * M_PI / 180.0)) / (1 - sin(latitude * M_PI / 180.0))) / 2.0)
    }
    
    func pixelSpaceXToLongitude(pixelX:Double) ->Double {
        return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI
    }
    
    func pixelSpaceYToLatitude(pixelY:Double) ->Double {
        return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI
    }
    
    func coordinateSpanWithMapView(mapView:MKMapView,
                                   centerCoordinate:CLLocationCoordinate2D,
                                   zoomLevel:Double) -> MKCoordinateSpan
    {
        let centerPixelX = self.longitudeToPixelSpaceX(longitude: centerCoordinate.longitude)
        let centerPixelY = self.latitudeToPixelSpaceY(latitude: centerCoordinate.latitude)
        let zoomExponent = 20.0 - zoomLevel
        let zoomScale = pow(2.0, zoomExponent)
        
        let mapSizeInPixels = mapView.bounds.size
        let scaledMapWidth  = Double(mapSizeInPixels.width) * zoomScale
        let scaledMapHeight = Double(mapSizeInPixels.height) * zoomScale
        
        let topLeftPixelX = centerPixelX - (scaledMapWidth/2)
        let topLeftPixelY = centerPixelY - (scaledMapHeight/2)
        
        let minLng = self.pixelSpaceXToLongitude(pixelX: topLeftPixelX)
        let maxLng = self.pixelSpaceXToLongitude(pixelX: topLeftPixelX + scaledMapWidth)
        let longitudeDelta = maxLng - minLng
        
        let minLat = self.pixelSpaceYToLatitude(pixelY: topLeftPixelY);
        let maxLat = self.pixelSpaceYToLatitude(pixelY: topLeftPixelY + scaledMapHeight);
        let latitudeDelta = -1 * (maxLat - minLat);
        
        let span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        return span
    }
}
 */
