//
//  ViewController.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memeRoster: MemeRoster?
    var memeBook: MemeBook?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        memeRoster = MemeRoster(frame: self.view.frame, style: UITableViewStyle.Plain)
        memeRoster!.dataSource = self
        memeRoster!.delegate = self
        
        self.view.addSubview(memeRoster)
        
        self.title = "MemeRoster"
        self.memeBook = MemeBook()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // ------ UITableViewDelegate
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("MemeRosterCellView") as MemeRosterCellView

            let row = indexPath.row
            
            let meme: Meme = memeBook!.getMeme(row)
            cell.textLabel.text = meme.description
            cell.image = meme.image
            
            return cell
    }
    
    func tableView(tableView: UITableView!,
        numberOfRowsInSection section: Int) -> Int {
            return memeBook!.size()
    }
    
    func tableView(tableView: UITableView!,
        heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
            return 100
    }
    

}

