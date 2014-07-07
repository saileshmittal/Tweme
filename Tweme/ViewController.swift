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
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!,
        heightForHeaderInSection section: Int) -> CGFloat {
            return 70
    }
    
    func tableView(tableView: UITableView!,
        viewForHeaderInSection section: Int) -> UIView! {
            let width = tableView.frame.width
            let height = self.tableView(tableView, heightForHeaderInSection: section)
            
            println("Header in section")
            var view = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: height)))
            
            var camera = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width / 2, height: height)))
            camera.backgroundColor = UIColor.grayColor()
            camera.titleLabel.textColor = UIColor.whiteColor()
            camera.setTitle("Camera", forState: UIControlState.Normal)
            camera.addTarget(self, action: "cameraButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(camera)
            
            var device = UIButton(frame: CGRect(origin: CGPoint(x: tableView.frame.width / 2, y: 0), size: CGSize(width: width / 2, height: height)))
            device.backgroundColor = UIColor.cyanColor()
            device.setTitle("Device", forState: UIControlState.Normal)
            device.addTarget(self, action: "deviceButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(device)
            
            return view
    }
    
    func cameraButtonPressed () {
        println("Camera")
    }
    
    func deviceButtonPressed () {
        println("Device")
    }
    

}

