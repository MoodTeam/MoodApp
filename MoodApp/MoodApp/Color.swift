//
//  Color.swift
//  MoodApp
//
//  Created by Charles Lin on 23/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

struct Color {
    
    static func getFromRgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(
            red: red / 255.0,
            green: green / 255.0,
            blue: blue / 255.0,
            alpha: 1.0
        )
    }

    static func getFromRgb(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    static func getFromName(emotion: Emotion) -> UIColor {
        var color: UIColor = self.getFromRgb(0x000000)
        switch emotion {
        case .Grey:
            color = self.getFromRgb(0xAAAAAA)
        case .Green:
            color = self.getFromRgb(0x00FF00)
        case .Red:
            color = self.getFromRgb(0xFF0000)
        case .White:
            color = self.getFromRgb(0xFFFFFF)
        }
        return color
    }
    
}