//
//  BlogSplitScreenFacade.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/14/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//


// step 1: create facade - one per split screen you are making
// step 2: use facade to create BlogDataObjects to display and your split screen
// step 3: use facade to call update data


import UIKit

class BlogSplitScreenFacade: NSObject {

    var splitScreen:SplitScreenWithScroll?


    func setupBlogSplitScreenWithPadding(#blogFrame:CGRect!, forView:UIView!, outsidePadding_horizontal:CGFloat!, interiorPadding_horizontal:CGFloat!, topPadding:CGFloat!) {

        let cellWidth = (blogFrame.size.width / 2) - (interiorPadding_horizontal + outsidePadding_horizontal)
        let cellFrame = CGRectMake(interiorPadding_horizontal, topPadding, cellWidth, 0)  // the frame will give the interior padding as the x-value

        splitScreen = SplitScreenWithScroll(
            frame: blogFrame,
            forView: forView,
            defaultCellFrame: cellFrame,
            blogItemStyle: TextBoxStyle.defaultStyle)

    }


    func createBlogDataObject(#theTitle:NSString?, theText:NSString?, theOptionalImageLocation:NSString?, theOptionalImage:UIImage?) ->(BlogDataObject){

        return BlogDataObject(theTitle:theTitle, theText:theText, theOptionalImageLocation:theOptionalImageLocation, theOptionalImage: theOptionalImage)
        
    }

    func updateBlogWithData(#arrayOfDataForLeftSide:Array<AnyObject>, arrayOfDataForRightSide:Array<AnyObject>){

        splitScreen?.updateBlogWithData(arrayOfDataForLeftSide, arrayOfDataForRightSide: arrayOfDataForRightSide)

    }



}
