//
//  MemeEdit.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import UIKit

class MemeEditView: UIView {
    
    var meme: Meme?
    var imageView: UIImageView?
    var topTextView: UITextView?
    var bottomTextView: UITextView?
    
    var imageReady = false
    var drawTextInput = true
    var pickedImage: UIImage?
    var fontSize:CGFloat = 18


    func scaleFactor(imageSize: CGSize) -> CGFloat {
        return fminf(CGRectGetWidth(imageView!.bounds)/imageSize.width, CGRectGetHeight  (imageView!.bounds)/imageSize.height);
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }
    
    convenience init(frame: CGRect, meme: Meme) {
        self.init(frame: frame)
        self.meme = meme
        self.addImageView()
        self.addTextViews()
        
        let imageSize:CGSize = imageView!.image.size;
        let imageScale = scaleFactor(imageSize)
        let scaledImageSize: CGSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
        let imageFrame: CGRect = CGRectMake(
            roundf(0.5*(CGRectGetWidth(imageView!.bounds)-scaledImageSize.width)),
            roundf(0.5*(CGRectGetHeight(imageView!.bounds)-scaledImageSize.height)),
            roundf(scaledImageSize.width),
            roundf(scaledImageSize.height));
    }
   
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    func addImageView() {
        imageView = UIImageView()
        imageView!.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height - 50)
        imageView!.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        imageView!.image = self.meme!.image
        self.addSubview(imageView)
    }
    
    func addStyleToTextView(textView : UITextView) {
        textView.backgroundColor = UIColor.clearColor()
        textView.font = UIFont(name:"Courier", size: self.fontSize)
        textView.textColor = UIColor.whiteColor()
        textView.textAlignment = NSTextAlignment.Center
    }

    func addTextViews() {
        let padding: CGFloat = 5.0
        let imageSize:CGSize = imageView!.image.size;
        let imageScale = scaleFactor(imageSize)
        let scaledImageSize: CGSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
        let imageFrame: CGRect = CGRectMake(
            roundf(0.5*(CGRectGetWidth(imageView!.bounds)-scaledImageSize.width)),
            roundf(0.5*(CGRectGetHeight(imageView!.bounds)-scaledImageSize.height)),
            roundf(scaledImageSize.width),
            roundf(scaledImageSize.height));

        self.topTextView = UITextView(frame: CGRect(
            x: imageFrame.origin.x + padding,
            y: imageFrame.origin.y + padding,
            width: imageFrame.width - 2 * padding,
            height: imageFrame.height / 2  - 2 * padding))
        addStyleToTextView(self.topTextView!)
        self.addSubview(self.topTextView)
        self.bottomTextView = UITextView(frame: CGRect(
            x: imageFrame.origin.x + padding,
            y: imageFrame.origin.y + imageFrame.height / 2 + padding,
            width: imageFrame.width - 2 * padding,
            height: imageFrame.height / 2 - 2 * padding))
        addStyleToTextView(self.bottomTextView!)
        self.addSubview(self.bottomTextView)
    }

}
