//
//  SplitScreenWithScroll.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/13/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class SplitScreenWithScroll: UIScrollView {

    var splitScreen:SplitScreen!

    init(frame: CGRect!, forView: UIView!, defaultCellFrame: CGRect!, blogItemStyle:TextBoxStyle) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.redColor()  // for debug

        // setup scroll view
        self.frame = frame
        self.contentSize = frame.size		// reset when updateBlog with data
        self.scrollEnabled = true
        self.clipsToBounds = true
        self.directionalLockEnabled = true  // WEIRD ERROR, can scroll horizonally when start animating/moving cells onto screen, even though should be clipped to bounds - this is a partial fix, but not ideal
        forView.addSubview(self)

        // add split screen
        splitScreen = SplitScreen(frame: frame, forView: self, defaultCellFrame: defaultCellFrame, blogItemStyle: blogItemStyle)
        self.delegate = splitScreen
        self.addSubview(splitScreen)

    }

    func updateBlogWithData(arrayOfDataForLeftSide:Array<AnyObject>, arrayOfDataForRightSide:Array<AnyObject>){

        splitScreen.updateBlogWithData(arrayOfDataForLeftSide, arrayOfDataForRightSide: arrayOfDataForRightSide)
        self.contentSize = splitScreen.frame.size

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
}
