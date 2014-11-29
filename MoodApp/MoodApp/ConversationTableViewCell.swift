//
//  ConversationTableViewCell.swift
//  MoodApp
//
//  Created by Charles Lin on 29/11/14.
//  Copyright (c) 2014 42labs. All rights reserved.
//

import Foundation

class ConversationTableViewCell: UITableViewCell {
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var friendName: UILabel!
    @IBOutlet var friendLastUpdate: UILabel!
    @IBOutlet var myEmotion: UIButton!
    @IBOutlet var borderLine: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}