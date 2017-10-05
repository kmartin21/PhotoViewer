//
//  UIColorExtensions.swift
//  PhotoViewer
//
//  Created by keith martin on 8/23/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import UIKit

extension UIColor {
    static let backgroundLightGrey = UIColor(red: 240, green: 240, blue: 240)
    static let backgroundGrey = UIColor(red: 189, green: 195, blue: 199)
    static let successGreen = UIColor(red: 46, green: 204, blue: 113)
    static let failRed = UIColor(red: 231, green: 76, blue: 60)
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
