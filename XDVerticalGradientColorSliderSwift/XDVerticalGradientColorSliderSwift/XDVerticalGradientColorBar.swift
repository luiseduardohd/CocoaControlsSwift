//
// Created by Luis Eduardo Hdz on 18/02/20.
// Copyright (c) 2020 LEHD. All rights reserved.
//

import Foundation
import UIKit


class XDVerticalGradientColorBar : UIView {

    var colors: [AnyObject]?
    var gradientLayer: CAGradientLayer?

    init(_ frame: CGRect, withColors colors: [AnyObject]) {

        self.privateInitWithColors(colors)
    }

    convenience init(_ frame: CGRect) {
        //self.init(frame, withColors: nil)
    }

    // for when coming out of a nib
    /*
    init(_ coder: NSCoder) {
        //self.privateInitWithColors(nil)
    }
    */

    func privateInitWithColors(_ colors: [AnyObject]) {
        self.clipsToBounds = true
        self.layer.cornerRadius = kXDVerticalGradientColorBarCornerRadius
        self.backgroundColor = UIColor.clear
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer!.frame = self.bounds
        self.gradientLayer!.cornerRadius = kXDVerticalGradientColorBarCornerRadius
        self.gradientLayer!.masksToBounds = true
        //self.gradientLayer.colors = self.colors;
        var gradientColors: NSMutableArray = NSMutableArray(capacity: 0)
        if colors && colors.count > 0 {
            for color in colors {
                gradientColors.addObject(((color.CGColor as? Any)))
            }
        } else {
            gradientColors.addObjects(from: colors)

        }
        //  创建渐变色数组，需要转换为CGColor颜色
        self.gradientLayer.colors = gradientColors
        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        self.gradientLayer.startPoint = CGPointMake(0, 0)
        self.gradientLayer.endPoint = CGPointMake(0, 1)
        //[self.layer addSublayer:self.gradientLayer];
        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
    }

    // MARK: -
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }

    /**
     校正坐标，用于处理手指拖动到滑竿区域外时，计算用于生成选中颜色的坐标点

     - param: point 手指触屏的点
     - return: 校正后的坐标点
     */
    func convertPointInGradientColorBarCoordinateSystem(_ point: CGPoint) -> CGPoint {
        var x: CFloat = self.bounds.size.width/2.0
        var y: CFloat = point.y
        if y < 0 {
            y = 0
        } else if y > self.bounds.size.height {
            y = self.bounds.size.height
        } else {
            y = point.y

        }
        return CGPointMake(x, y)
    }

    /**
     通过坐标点获取对应颜色

     - param: point 坐标点
     - return: 坐标点对应的颜色
     */
    func colorOfPointInGradientColorBar(_ point: CGPoint) -> UIColor {
        var convertedPoint: CGPoint = self.convertPointInGradientColorBarCoordinateSystem(point)
        var pixel: CUnsignedChar = Array(repeating: 0, count: 4)
        var colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()
        var context: CGContextRef = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask&kCGImageAlphaPremultipliedLast)
        CGContextTranslateCTM(context, -convertedPoint.x, -convertedPoint.y)
        self.layer.renderInContext(context)
        CGContextRelease(context)
        CGColorSpaceRelease(colorSpace)
        //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
        var color: UIColor = UIColor(red: pixel[0]/255.0, green: pixel[1]/255.0, blue: pixel[2]/255.0, alpha: pixel[3]/255.0)
        return color

    }

}