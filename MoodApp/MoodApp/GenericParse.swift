//
//  GenericParse.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class GenericParse {
    class var sharedInstance: IParse {
        struct Static {
            static var instance: IParse?
            static var token: dispatch_once_t = 0
            static var mode: TestMode = TestMode.currentMode
        }
        
        dispatch_once(&Static.token) {
            Static.instance = (Static.mode == .Test) ? MockParse() : RealParse()
        }
        
        return Static.instance!
    }
}