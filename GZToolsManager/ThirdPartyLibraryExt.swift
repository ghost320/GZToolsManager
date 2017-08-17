//
//  ThirdPartyLibraryExt.swift
//  PaintMaster
//
//  Created by somethingbig on 2017/8/14.
//  Copyright © 2017年 Ghost. All rights reserved.
//

import Foundation
import ChromaColorPicker

//ChromaColorPicker
class GZColorPicker:ChromaColorPicker
{
    func colorDidChanged()
    {
//        delegate?.colorPickerDidChooseColor(self, color: currentColor)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        colorDidChanged()
        print("touchesEnded")
    }
    
    
    override func shadeSliderChoseColor(_ slider: ChromaShadeSlider, color: UIColor) {
        super.shadeSliderChoseColor(slider, color: color)
        colorDidChanged()
        print("shadeSliderChoseColor")
    }
    
//    override func adjustToColor(_ color: UIColor) {
//        super.adjustToColor(color)
//        
//    }
}

