//
//  MemeEditController.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import UIKit
import Social
import Accounts

class MemeEditController: UIViewController {
    
    var meme: Meme?
    var memeEditView: MemeEditView?
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    convenience init(meme: Meme) {
        self.init(nibName: nil, bundle: nil)
        self.meme = meme
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerKeyboardNotifications()
        
        // Do any additional setup after loading the view.
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.autoresizesSubviews = true
        
        memeEditView = MemeEditView(frame: self.view.frame, meme: meme!)
        self.title = "Meme Edit"
        self.view.addSubview(memeEditView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "twitter.png"), style: UIBarButtonItemStyle.Bordered, target: self, action: "postTweet")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        memeEditView!.topTextView!.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        let kbsize = notification.userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey).CGRectValue().size
        
        var contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbsize.height, 0.0)
        memeEditView!.contentInset = contentInsets
        memeEditView!.scrollIndicatorInsets = contentInsets
        
        if memeEditView!.topTextView!.isFirstResponder() {
            memeEditView!.setContentOffset(memeEditView!.topTextView!.frame.origin, animated: true)
        } else {
            var point = memeEditView!.imageFrame!.origin
            var height = point.y + memeEditView!.imageFrame!.size.height
            height = memeEditView!.frame.height - height
            height = kbsize.height - height
            point.y = height + 64.0
            memeEditView!.setContentOffset(point, animated: true)
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        // Don't do anything if this is the first textView.
        if !memeEditView!.topTextView!.isFirstResponder() {
            var contentInsets = UIEdgeInsetsZero
            memeEditView!.contentInset = contentInsets
            memeEditView!.scrollIndicatorInsets = contentInsets
        }
    }
    
    func postTweet() {
        var shareController :SLComposeViewController =
        SLComposeViewController(forServiceType:SLServiceTypeTwitter)
        shareController.setInitialText("#tweme")
        if (!memeEditView!.memeImage) {
            memeEditView!.convertToMemeImage()
        }
        shareController.addImage(memeEditView!.memeImage)
        self.presentViewController(shareController, animated: true, completion: nil)
    }

}
