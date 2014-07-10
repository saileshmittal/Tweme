//
//  MemeEditController.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import UIKit

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
        
        // Do any additional setup after loading the view.
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.autoresizesSubviews = true
        
        memeEditView = MemeEditView(frame: self.view.frame, meme: meme!)
        self.title = "Meme Edit"
        self.view.addSubview(memeEditView)
    }
    override func viewDidAppear(animated: Bool) {
        memeEditView!.topTextView!.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
