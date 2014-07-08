//
//  MemeRoster.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import Foundation
import UIKit

class MemeRoster: UITableView {
    init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorInset = UIEdgeInsetsZero
        self.registerClass(MemeRosterCellView.classForCoder(), forCellReuseIdentifier: "MemeRosterCellView")
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
    }
    
    
}

class MemeRosterCellView: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let height = self.frame.height
        println(height)
        let padding:CGFloat = 2.0
        
        self.imageView.frame = CGRectMake(
            padding,
            padding,
            height - 2 * padding,
            height - 2 * padding
        )
        
        self.textLabel.frame = CGRectMake(
            height + 2 * padding,
            padding,
            self.frame.width - height - 2 * padding,
            height - 2 * padding
        )
    }
    
    
}