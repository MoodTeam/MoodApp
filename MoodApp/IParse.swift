//
//  IParse.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

protocol IParse {
    init()
    func addToParse(parseClassName: String, dict: Dictionary<String, AnyObject>)
    func loadFromParse(parseClassName: String, onLoadSuccess: ([AnyObject]!) -> (), onLoadFailure: (NSError!) -> ())
}