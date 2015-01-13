//
//  SplitScreen.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/12/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class SplitScreen: UIView {


    // uiviews, imageviews, and text is inexpensive, so we are going to layout our whole blog without reuse cells
    // but we will only load images in when required


    // DATA
    var leftSideArray:[AnyObject] = Array()
    var rightSideArray:[AnyObject] = Array()

    // SETTINGS
    var defaultFrameForSplitScreen:CGRect!
    var defaultCellFrameWithXYPositionsGivingPadding:CGRect!
    var defaultCellFrameWithNoPadding:CGRect!
    var yPositionForUseInBuild:CGFloat!
    var defaultBlogItemStyle:TextBoxStyle!

    // VIEWS
    var listOfItemsToDisplay:[UIView] = Array()


// INIT
    init(frame: CGRect!, forView: UIView!, defaultCellFrame: CGRect!, blogItemStyle:TextBoxStyle) {
        super.init(frame: frame)


        // set properties
        defaultFrameForSplitScreen = frame
        defaultCellFrameWithXYPositionsGivingPadding = defaultCellFrame
        defaultCellFrameWithNoPadding = CGRectMake(0, 0, defaultCellFrame.size.width, defaultCellFrame.size.height)
        yPositionForUseInBuild = defaultCellFrameWithXYPositionsGivingPadding.origin.y
        defaultBlogItemStyle = blogItemStyle

        // build blog
        buildSkeletonCreatingBlogItemsRowByRow()


        // add to super view
        forView.addSubview(self)

}


required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    // IMPLEMENT, PLEASE
}


// SETUP

func buildSkeletonCreatingBlogItemsRowByRow(){

    var counter = 0

    var rowHeightLeft:CGFloat = 0
    var rowHeightRight:CGFloat = 0

    // xPosition = midpoint +/- xOffset
    let xPositionLeft =  defaultFrameForSplitScreen.width/2
                        - defaultCellFrameWithXYPositionsGivingPadding.origin.x
    let xPositionRight = defaultFrameForSplitScreen.width/2
                        + defaultCellFrameWithXYPositionsGivingPadding.origin.x


    // for each row create left and right blog objects
    for _ in [0...returnNumberOfRowsToDisplay()]{   // fast enumeration uses "for x in y" format


        if counter < leftSideArray.count {

            let view = addBlogItemFromArray(leftSideArray, rowNumber: counter, xPosition: xPositionLeft)
            rowHeightLeft = view.frame.size.height
        }

        if counter < rightSideArray.count {

            let view = addBlogItemFromArray(rightSideArray, rowNumber: counter, xPosition: xPositionRight)
            rowHeightRight = view.frame.size.height
        }


        // update yPostion
        if rowHeightLeft > rowHeightRight {

            yPositionForUseInBuild = yPositionForUseInBuild + rowHeightLeft

        } else {

            yPositionForUseInBuild = yPositionForUseInBuild + rowHeightRight

        }

    }
}

func addBlogItemFromArray(array:Array<AnyObject>, rowNumber:Int, xPosition:CGFloat) -> UIView {


    // get new data object
    let data:AnyObject? = leftSideArray[rowNumber]

    // if empty, return
    if data == nil { return UIView(); }

    // build view
    var view:UIView!

    if data!.isKindOfClass(BlogDataObject){

        let dataObject = data! as BlogDataObject
        let nextBlogItem = BlogText(title: dataObject.title, text: dataObject.text, style: defaultBlogItemStyle, defaultFrame:defaultCellFrameWithNoPadding , insertInView: self)
        view = nextBlogItem as UIView

    }


    // set frame position
    view.frame = CGRectMake(xPosition, yPositionForUseInBuild, self.frame.size.width, self.frame.size.height)

    // add to view and to array of blog items
    self.addSubview(view)
    listOfItemsToDisplay.append(view)

    return view

}

func returnNumberOfRowsToDisplay()-> Int {

        // if arrays are not the same length, you want to find use the larger

        if leftSideArray.count < rightSideArray.count {

            return rightSideArray.count;

        } else {

            return leftSideArray.count;
            
        }
        
    }
}
