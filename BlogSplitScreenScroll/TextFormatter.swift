//
//  TextFormatter.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/9/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class TextFormatter: NSObject {


    class func createAttributedString(text: NSString, withFont: String, fontSize:CGFloat, fontColor:UIColor, nsTextAlignmentStyle:NSTextAlignment) -> (NSAttributedString)
    {

        // create attributed string to work with
        let artString = NSMutableAttributedString(string: text)

        // check to make sure have all our values
        if (text == ""){ return artString;}

        let theFont = withFont ?? "Palatino-Roman"
        let theFontSize = fontSize ?? 12.0
        let theFontColor = fontColor ?? UIColor.blackColor()
        let textAlignmentStyle = nsTextAlignmentStyle ?? NSTextAlignment.Left

        // prep work - build font, paragraph style, range
        let fontX = UIFont(name: theFont, size: theFontSize)!
        let artStringRange = NSMakeRange(0, artString.length)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = nsTextAlignmentStyle;

        // set attributes
        artString.addAttribute(NSFontAttributeName, value:fontX, range: artStringRange)
        artString.addAttribute(NSForegroundColorAttributeName, value:fontColor, range: artStringRange)
        artString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range: artStringRange)

        return artString;

    }

    class func combineAttributedStrings(arrayOfAttributedStrings:Array<NSAttributedString>) -> (NSAttributedString)
    {

        let artString = NSMutableAttributedString()

        for insertMe:NSAttributedString in arrayOfAttributedStrings {

            artString.appendAttributedString(insertMe)

        }
    
        return artString;
    
    }
}
