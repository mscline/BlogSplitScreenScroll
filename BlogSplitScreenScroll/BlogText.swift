//
//  BlogText.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/9/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

enum TextBoxStyle {

    case defaultStyle, coolStyle

}

class BlogText: UIView {


    // PROPERTIES
    var boxStyle:TextBoxStyle!
    var parentView:UIView!

    // headings
    var ourTitle:String!
    var fontForTitle:String!
    var fontSizeForTitle:CGFloat!
    var fontColorForTitle:UIColor!
    var textAlignmentForTitle:NSTextAlignment!

    // text
    var ourText:String!
    var font:String!
    var fontSize:CGFloat!
    var fontColor:UIColor!
    var textAlignment:NSTextAlignment!

    // decoration line
    var decorationLineHeight:CGFloat!
    var decorationLineColor:UIColor!

    // text box attributes
    var backColor:UIColor!
    

    // MARK: INITIALIZATION

    init(title:String?, text:String?, style:TextBoxStyle, defaultFrame:CGRect, insertInView:UIView!){
        super.init(frame: defaultFrame)

        // deal with optionals
        ourTitle = title ?? ""
        ourText = text ?? ""
        boxStyle = style ?? TextBoxStyle.defaultStyle
        parentView = insertInView

        buildBox()

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: BUILD IT

    func buildBox(){


        // create attributed text message and set default layout values
        let messageToDisplay = buildAttributedText()


        // set the frame height based on the attributed text height
        var desiredFrameHeight = TextFormatter.returnHeightOfAttributedStringGivenFixedHeightOrWidth(attributedString: messageToDisplay, maxWidth: self.frame.size.width, maxHeight: 100000)

        desiredFrameHeight = desiredFrameHeight + decorationLineHeight
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, desiredFrameHeight)


        // add background color
        self.backgroundColor = backColor


        // create text view, add our text, add to current view
        let textView = UITextView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + decorationLineHeight))
        textView.attributedText = messageToDisplay
        textView.backgroundColor = UIColor.clearColor()
        textView.scrollEnabled = false
        self.addSubview(textView)


        // create decoration line across bottom and add to current view
        let decorationLine = UIView(frame: CGRectMake(0, self.frame.height - decorationLineHeight, self.frame.width, decorationLineHeight))
        decorationLine.backgroundColor = backColor
        self.addSubview(decorationLine)


        // add self to parent view
        parentView.addSubview(self)


    }


    // MARK: ATTRIBUTED TEXT

    func buildAttributedText() -> (NSAttributedString)
    {
        // set text box attributes
        if  boxStyle == TextBoxStyle.coolStyle {

            setupCoolStyle()

        } else {

            setupDefaultStyle()

        }

        // create attributed text
        let heading = TextFormatter.createAttributedString(ourTitle, withFont: fontForTitle, fontSize: fontSizeForTitle, fontColor: fontColorForTitle, nsTextAlignmentStyle: textAlignmentForTitle)

        let message = TextFormatter.createAttributedString(ourText, withFont: font, fontSize: fontSize, fontColor: fontColor, nsTextAlignmentStyle: textAlignment)

        return TextFormatter.combineAttributedStrings([heading, message])
        
    }

    func setupDefaultStyle(){

        fontForTitle = "Chalkduster"
        fontSizeForTitle = 20.0
        fontColorForTitle = UIColor.blackColor()
        textAlignmentForTitle = NSTextAlignment.Left

        font = "Arial"
        fontSize = 12.0
        fontColor = UIColor.blackColor()
        textAlignment = NSTextAlignment.Left

        decorationLineHeight = 8
        decorationLineColor = UIColor.blueColor()

        backColor = UIColor.lightGrayColor()

    }

    func setupCoolStyle(){

        fontForTitle = "Chalkduster"
        fontSizeForTitle = 12.0
        fontColorForTitle = UIColor.redColor()
        textAlignmentForTitle = NSTextAlignment.Left

        font = "Arial"
        fontSize = 12.0
        fontColor = UIColor.blackColor()
        textAlignment = NSTextAlignment.Left

        decorationLineHeight = 8
        decorationLineColor = UIColor.redColor()

        backColor = UIColor.yellowColor()

    }

}
