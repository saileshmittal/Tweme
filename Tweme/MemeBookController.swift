//
//  ViewController.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import MobileCoreServices
import QuartzCore
import UIKit

class MemeBookController: UIViewController,
                          UITableViewDelegate,
                          UITableViewDataSource,
                          UINavigationControllerDelegate,
                          UIImagePickerControllerDelegate {
    
    var memeRoster: MemeRoster?
    var memeBook: MemeBook?
    var picker:UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController.navigationBar.translucent = false
        
        memeRoster = MemeRoster(frame: self.view.frame, style: UITableViewStyle.Plain)
        memeRoster!.dataSource = self
        memeRoster!.delegate = self
        
        self.view.addSubview(memeRoster)
        
        self.title = "Tweme"
        self.memeBook = MemeBook()
    }
    
    override func viewWillAppear(animated: Bool) {
        let indexPath = memeRoster!.indexPathForSelectedRow()
        memeRoster!.deselectRowAtIndexPath(indexPath, animated: animated)
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
            return 60
    }
    
    func tableView(tableView: UITableView!,
        viewForHeaderInSection section: Int) -> UIView! {
            let width = tableView.frame.width
            let height = self.tableView(tableView, heightForHeaderInSection: section)
            let imageHeight : CGFloat = 48
            var view = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: height)))
            var camera = UIButton(frame: CGRectMake(width / 4 - imageHeight / 2, 5.0 , imageHeight, imageHeight))
            addStyleToButton(camera, imageName: "camera.png")
            camera.addTarget(self, action: "cameraButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(camera)
            var sideSeparator : UILabel = UILabel(frame:CGRectMake(width / 2 - 1, 1, 2, height - 2))
            var bottomSeparator : UILabel = UILabel(frame: CGRectMake(0, height - 2, width, 1))
            bottomSeparator.backgroundColor = UIColor.grayColor()
            sideSeparator.backgroundColor = UIColor.grayColor()
            view.addSubview(sideSeparator)
            view.addSubview(bottomSeparator)
            var device = UIButton(frame: CGRectMake(3 * width / 4 - imageHeight / 2, 5.0, imageHeight, imageHeight))
            addStyleToButton(device, imageName: "images.png")
            device.addTarget(self, action: "deviceButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(device)
            view.backgroundColor = UIColor.lightGrayColor()
            return view
    }
    
    func addStyleToButton(button:UIButton, imageName: String) {
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.layer.shadowOffset = CGSizeMake(5, 5)
        button.layer.shadowColor = UIColor.blackColor().CGColor;
        button.layer.shadowOpacity = 0.5
        button.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
    }
    
    func cameraButtonPressed () {
        var cameraUI : UIImagePickerController = UIImagePickerController();
        cameraUI.sourceType = UIImagePickerControllerSourceType.Camera;
        cameraUI.mediaTypes = [kUTTypeImage];
        
        // Hides the controls for moving & scaling pictures, or for
        // trimming movies. To instead show the controls, use YES.
        cameraUI.allowsEditing = false;
        
        cameraUI.delegate = self;
        
        self.presentModalViewController(cameraUI, animated: true);
    }
    
    func deviceButtonPressed () {
        picker = UIImagePickerController()
        picker.delegate = self  // For imagePickerController
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        self.presentModalViewController(picker, animated: true)
    }
    
    func tableView(tableView: UITableView!,
        didSelectRowAtIndexPath indexPath: NSIndexPath!) {
            let meme = memeBook!.getMeme(indexPath.row)
            self.navigationController.pushViewController(MemeEditController(meme: meme), animated: false)

    }
    
    // ImagePicker delegate
    func imagePickerController(picker:UIImagePickerController!, didFinishPickingMediaWithInfo info:NSDictionary) {
        picker.dismissModalViewControllerAnimated(false)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            var meme: Meme = Meme(description: "", image: image)
            self.navigationController.pushViewController(MemeEditController(meme: meme), animated: false)
        }
    }
    
}

