//
//  ModeChange.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

enum TestMode: Int {
    case Test = 0
    case Real = 1
    
    static var currentMode: TestMode = .Real
}