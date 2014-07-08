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
        self.registerClass(MemeRosterCellView.classForCoder(), forCellReuseIdentifier: "MemeRosterCellView")
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight
    }
    
    
}

class MemeRosterCellView: UITableViewCell {
    
}