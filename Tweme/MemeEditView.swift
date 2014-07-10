//
//  MemeEdit.swift
//  Tweme
//
//  Created by Sailesh Mittal on 7/7/14.
//  Copyright (c) 2014 Twitter. All rights reserved.
//

import UIKit

class MemeEditView: UIScrollView, UITextViewDelegate {
    var meme: Meme?
    var imageView: UIImageView?
    var imageFrame: CGRect?
    var topTextView: UITextView?
    var bottomTextView: UITextView?
    // Size for lines of size 1 through 4. Line size greater than 4 will not be supported.
    var fontSizeDefault : CGFloat
    var font : UIFont
    var topFontInImage : UIFont?
    var bottomFontInImage : UIFont?
    let padding: CGFloat = 5
    var memeImage : UIImage?
    
    func scaleFactor(imageSize: CGSize) -> CGFloat {
        return fminf(CGRectGetWidth(imageView!.bounds)/imageSize.width, CGRectGetHeight  (imageView!.bounds)/imageSize.height);
    }
    
    init(frame: CGRect) {
        fontSizeDefault = 24
        font = UIFont(name:"Courier-Bold", size: self.fontSizeDefault)
        super.init(frame: frame)
        // Initialization code
    }
    
    convenience init(frame: CGRect, meme: Meme) {
        self.init(frame: frame)
        self.meme = meme
        self.addImageView()
        self.addTextViews()
    }
    
    func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    func addImageView() {
        imageView = UIImageView()
        imageView!.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height - 50)
        imageView!.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        imageView!.image = self.meme!.image
        let imageSize:CGSize = imageView!.image.size;
        let imageScale = scaleFactor(imageSize)
        let scaledImageSize: CGSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
        imageFrame = CGRectMake(
            roundf(0.5*(CGRectGetWidth(imageView!.bounds)-scaledImageSize.width)),
            roundf(0.5*(CGRectGetHeight(imageView!.bounds)-scaledImageSize.height)),
            roundf(scaledImageSize.width),
            roundf(scaledImageSize.height));
        self.addSubview(imageView)
    }
    
    func addStyleToTextStyleToTextView(textView : UITextView) {
        textView.backgroundColor = UIColor.clearColor()
        textView.font = font
        textView.textColor = UIColor.whiteColor()
        textView.textAlignment = NSTextAlignment.Center
        textView.delegate = self
        textView.scrollEnabled = false
    }
    

    func addTextViews() {
        let bottomTextViewInitialHeight: CGFloat = self.fontSizeDefault + 2 * padding
        topTextView = UITextView(frame:CGRectMake(imageFrame!.origin.x + padding, imageFrame!.origin.y + padding, imageFrame!.width - 2 * padding, 100))
        bottomTextView = UITextView(frame:CGRectMake(imageFrame!.origin.x + padding, imageFrame!.origin.y + imageFrame!.height - bottomTextViewInitialHeight - padding, imageFrame!.width - 2 * padding, bottomTextViewInitialHeight))
        addStyleToTextStyleToTextView(topTextView!)
        addStyleToTextStyleToTextView(bottomTextView!)
        topTextView!.returnKeyType = UIReturnKeyType.Next
        bottomTextView!.returnKeyType = UIReturnKeyType.Done
        self.addSubview(topTextView!)
        self.addSubview(bottomTextView!)
    }
    
    func convertToMemeImage() {
        let pickedImage : UIImage = self.imageView!.image
        let scale = scaleFactor(pickedImage.size)
        UIGraphicsBeginImageContext(pickedImage.size)
        pickedImage.drawInRect(CGRectMake(0, 0, pickedImage.size.width, pickedImage.size.height))
        let topTextRect = CGRectMake(
            (topTextView!.frame.origin.x - imageFrame!.origin.x) / scale,
            (topTextView!.frame.origin.y - imageFrame!.origin.y) / scale,
            topTextView!.frame.width / scale,
            topTextView!.frame.height / scale)
        let bottomTextRect = CGRectMake(
            (bottomTextView!.frame.origin.x - imageFrame!.origin.x) / scale,
            (bottomTextView!.frame.origin.y - imageFrame!.origin.y) / scale,
            bottomTextView!.frame.width / scale,
            bottomTextView!.frame.height / scale)
        println("image : \(pickedImage.size) with scale : \(scale) At origin: \(imageFrame!) textFrame: \(bottomTextView!.frame) imgFrame \(bottomTextRect)")
        var textStyle: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        if !topTextView!.text.isEmpty {
            var topAttributes:NSDictionary = [
                NSFontAttributeName: UIFont(name:"Courier-Bold", size: self.topFontInImage!.pointSize / scaleFactor(pickedImage.size)),
                NSParagraphStyleAttributeName: textStyle,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]
            topTextView!.text.bridgeToObjectiveC().drawInRect(topTextRect, withAttributes: topAttributes)
        }
        if !bottomTextView!.text.isEmpty {
            var bottomAttributes:NSDictionary = [
                NSFontAttributeName: UIFont(name:"Courier-Bold", size: self.bottomFontInImage!.pointSize / scaleFactor(pickedImage.size)),
                NSParagraphStyleAttributeName: textStyle,
                NSForegroundColorAttributeName: UIColor.whiteColor()
            ]
            bottomTextView!.text.bridgeToObjectiveC().drawInRect(bottomTextRect, withAttributes: bottomAttributes)
        }
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        self.imageView!.image = newImage
        self.memeImage = newImage
        topTextView!.hidden = true
        bottomTextView!.hidden = true
        self.setNeedsLayout()
    }
    func textView(textView: UITextView!,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String!) -> Bool {
            if text == "\n" {
                if textView == self.topTextView {
                    self.topTextView!.resignFirstResponder()
                    self.bottomTextView!.becomeFirstResponder()
                    self.topFontInImage = UIFont(name:self.font.fontName, size:self.font.pointSize)
                    println("Resigned Top")
                } else {
                    println("Resigned Bottom")
                    bottomTextView!.resignFirstResponder()
                    self.bottomFontInImage = UIFont(name:self.font.fontName, size: self.font.pointSize)
                    convertToMemeImage()
                }
                return false
            }
            return true
    }
    
    
    // UITextView delegates
    func textViewDidChange(textView: UITextView) {
        if textView.text.bridgeToObjectiveC().length < 2 {
            return
        }
        let fudgeFactor: CGFloat = 10
        let tallerSize = CGSizeMake(textView.frame.width - fudgeFactor, 1000);
        let currText : NSString = NSString(string: textView.text)
        let prevText : NSString = currText.substringToIndex(currText.length - 1)
        var currStringSize : CGSize = currText.sizeWithFont(self.font, constrainedToSize: tallerSize, lineBreakMode: NSLineBreakMode.ByWordWrapping)
        var prevStringSize : CGSize = prevText.sizeWithFont(self.font, constrainedToSize: tallerSize, lineBreakMode: NSLineBreakMode.ByWordWrapping)
        var changed : Bool = false
        while (currStringSize.height > prevStringSize.height
            && self.fontSizeDefault > 16) {
                self.fontSizeDefault = self.fontSizeDefault - 1
                self.font = UIFont(name:"Courier-Bold", size: self.fontSizeDefault)
                textView.font = self.font
                changed = true
                currStringSize = currText.sizeWithFont(self.font, constrainedToSize: tallerSize, lineBreakMode: NSLineBreakMode.ByWordWrapping)
                prevStringSize = prevText.sizeWithFont(self.font, constrainedToSize: tallerSize, lineBreakMode: NSLineBreakMode.ByWordWrapping)
                println("changing font")
        }
        while (currStringSize.height < prevStringSize.height && self.fontSizeDefault < 24) {
                self.fontSizeDefault = self.fontSizeDefault + 1
            self.font = UIFont(name:"Courier-Bold", size: self.fontSizeDefault)
            textView.font = self.font
            changed = true
            currStringSize = currText.sizeWithFont(self.font, constrainedToSize: tallerSize, lineBreakMode: NSLineBreakMode.ByWordWrapping)
            prevStringSize = prevText.sizeWithFont(self.font, constrainedToSize: tallerSize, lineBreakMode: NSLineBreakMode.ByWordWrapping)
            println("changing font")
        }
        if (textView == bottomTextView!) {
            println(currStringSize)
            textView.frame = CGRectMake(
                textView.frame.origin.x,
                imageFrame!.origin.y + imageFrame!.height - currStringSize.height - 3 * padding,
                textView.frame.width,
                currStringSize.height + 2 * padding)
            self.setNeedsLayout()
        }
    }
}
