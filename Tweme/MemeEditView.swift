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
    var memeTextView: UITextView?
    
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
        
        imageView = UIImageView()
        imageView!.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height - 50)
        imageView!.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        imageView!.image = meme.image
        
        println(self.superview)
        println("Image view's frame")
        println(imageView!.frame)
        
        self.addSubview(imageView)
        
        memeTextView = UITextView(frame: imageView!.bounds)
        
        self.addSubview(memeTextView)
        
        let imageSize:CGSize = imageView!.image.size;
        let imageScale = scaleFactor(imageSize)
        let scaledImageSize: CGSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
        let imageFrame: CGRect = CGRectMake(
            roundf(0.5*(CGRectGetWidth(imageView!.bounds)-scaledImageSize.width)),
            roundf(0.5*(CGRectGetHeight(imageView!.bounds)-scaledImageSize.height)),
            roundf(scaledImageSize.width),
            roundf(scaledImageSize.height));
        if (self.drawTextInput) {
            memeTextView!.frame = imageFrame
            memeTextView!.backgroundColor = UIColor.clearColor()
            memeTextView!.font = UIFont(name:"Courier", size: self.fontSize)
            memeTextView!.textColor = UIColor.whiteColor()
            memeTextView!.becomeFirstResponder()
            memeTextView!.textAlignment = NSTextAlignment.Center
            memeTextView!.hidden = false
        } else {
            memeTextView!.hidden = true
        }
        println("My frame in init")
        println(self.frame)
    }
    
    override func layoutSubviews() {
        println("My frame in layoutsubviews")
        println(self.frame)
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    

}
