//
//  SplitScreen.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/12/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class SplitScreen: UIView, UIScrollViewDelegate {


    // uiviews, imageviews, and text is inexpensive, so we are going to layout our whole blog without reuse cells
    // but we will only load images in when required


    // DATA
    var leftSideArray:[AnyObject]!
    var rightSideArray:[AnyObject]!

    // SETTINGS
    var defaultFrameForSplitScreen:CGRect!
    var defaultCellFrameWithXYPositionsGivingPadding:CGRect!
    var defaultCellFrameWithNoPadding:CGRect!
    var yPositionForUseInBuild:CGFloat!
    var defaultBlogItemStyle:TextBoxStyle!

    // x-POSTIONS
    var xPositionLeftStartPoint:CGFloat!
    var xPositionRightStartPoint:CGFloat!

    var xPositionLeftDestination:CGFloat!
    var xPositionRightDestinatation:CGFloat!

    // VIEWS
    var listOfItemsToDisplay:[UIView] = Array()  // not actively using, but thought should have around
    var listOfCellsInStartinPositionsOffScreen = NSMutableArray() // can't remove object at index for an array!  seriously!!!

    // TIMER
    let timer:NSTimer!
    var secondsSinceStart:Float!
    var lastUsedTimeSlotToMoveItem_inTermsOfSecondsSinceStart:Float!


// MARK: BASIC SETUP

init(frame: CGRect!, forView: UIView!, defaultCellFrame: CGRect!, blogItemStyle:TextBoxStyle) {
        super.init(frame: frame)

    // setup timer (need to schedule moving views)
    timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timerFired", userInfo: nil, repeats: true)

    // set default settings
    setDefaults(frame, forView: forView, defaultCellFrame: defaultCellFrame, blogItemStyle: blogItemStyle)
    calculateXPositioning()

    // add this UIView to super view
    forView.addSubview(self)

}

func setDefaults(frame: CGRect!, forView: UIView!, defaultCellFrame: CGRect!, blogItemStyle:TextBoxStyle) {

    // set properties - for working with cells
    defaultBlogItemStyle = blogItemStyle

    defaultCellFrameWithXYPositionsGivingPadding = defaultCellFrame
    defaultCellFrameWithNoPadding = CGRectMake(0, 0, defaultCellFrame.size.width, defaultCellFrame.size.height)

    // set properties - for doing the layout
    defaultFrameForSplitScreen = frame  // will later update with proper height
    yPositionForUseInBuild = defaultCellFrameWithXYPositionsGivingPadding.origin.y  // use the y-padding for the starting position

    // set time defaults
    lastUsedTimeSlotToMoveItem_inTermsOfSecondsSinceStart = 0.0
    secondsSinceStart = 0

}

func calculateXPositioning(){

    // find x position start points
    xPositionLeftStartPoint = -defaultCellFrameWithNoPadding.width
    xPositionRightStartPoint = defaultFrameForSplitScreen.size.width + defaultCellFrameWithNoPadding.width

    // xPositionDestination = midpoint +/- xOffset
    xPositionLeftDestination =  defaultFrameForSplitScreen.width/2
        - defaultCellFrameWithXYPositionsGivingPadding.origin.x
        - defaultCellFrameWithXYPositionsGivingPadding.size.width
    xPositionRightDestinatation = defaultFrameForSplitScreen.width/2
        + defaultCellFrameWithXYPositionsGivingPadding.origin.x

}


// MARK: LAYOUT WHEN GET DATA

func updateBlogWithData(arrayOfDataForLeftSide:Array<AnyObject>, arrayOfDataForRightSide:Array<AnyObject>){

    // store properties
    leftSideArray = arrayOfDataForLeftSide
    rightSideArray = arrayOfDataForRightSide

    // layout blogsite
    buildSkeletonCreatingBlogItemsRowByRow()

    // update frame to fit content
    self.frame = CGRectMake(0, 0, self.frame.size.width, yPositionForUseInBuild)

    // tell cells on screen to move into final positions
    slideNewCellsIntoPosition(scrollView: nil)

}

func buildSkeletonCreatingBlogItemsRowByRow(){

    var counter = 0
    let lastRow = returnNumberOfRowsToDisplay() - 1

    var rowHeightLeft:CGFloat = 0
    var rowHeightRight:CGFloat = 0


    // for each row create left and right blog objects
    for _ in 0...lastRow {   // rem: fast enumeration uses "for x in y" format


        // check to see if item on left or right side
        if counter < leftSideArray.count {

            // add item at position
            let view = addBlogItemFromArray(leftSideArray, rowNumber: counter, xPosition: xPositionLeftStartPoint)

            // save row height
            rowHeightLeft = view.frame.size.height
        }

        if counter < rightSideArray.count {

            // add item at position
            let view = addBlogItemFromArray(rightSideArray, rowNumber: counter, xPosition: xPositionRightStartPoint)

            // save row height
            rowHeightRight = view.frame.size.height
        }


        // update yPostion
        if rowHeightLeft > rowHeightRight {

            yPositionForUseInBuild = yPositionForUseInBuild + rowHeightLeft + defaultCellFrameWithXYPositionsGivingPadding.origin.y

        } else {

            yPositionForUseInBuild = yPositionForUseInBuild + rowHeightRight + defaultCellFrameWithXYPositionsGivingPadding.origin.y

        }

        counter++
    }
}

func addBlogItemFromArray(array:Array<AnyObject>, rowNumber:Int, xPosition:CGFloat) -> UIView {


    // get new data object
    let data:AnyObject? = array[rowNumber]

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
    view.frame = CGRectMake(xPosition, yPositionForUseInBuild, view.frame.size.width, view.frame.size.height)

    // add to view and to array of blog items
    self.addSubview(view)
    listOfItemsToDisplay.append(view)
    listOfCellsInStartinPositionsOffScreen.addObject(view)

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


required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    // IMPLEMENT, PLEASE

}


// MARK: SCROLL VIEW DELEGATE & TIMER

func scrollViewDidScroll(scrollView: UIScrollView) {

    slideNewCellsIntoPosition(scrollView:scrollView)

}

func timerFired()
{

    secondsSinceStart = secondsSinceStart + 0.1

}


// MARK: MOVE CELLS INTO POSITION

func slideNewCellsIntoPosition(#scrollView:UIScrollView?){

    // REFACTOR IF WE ARE GOING TO ADD IMAGES  ???

    // basic settings
    var defaultDelayBeforeNextItem:Float = 1.0
    let durationOfAnimation:Float = 2.0

    // slide cells
    let firstTimeOnScreen = findCellsIfFirstTimeOnScreen(scrollView: scrollView)
    moveCellsFromStartPointToDestination(cellsToMove: firstTimeOnScreen, defaultDelay: defaultDelayBeforeNextItem, defaultLenghtOfAnimation: durationOfAnimation)

}

func findCellsIfFirstTimeOnScreen(#scrollView:UIScrollView?)->(Array<AnyObject>?){

    var firstTimers:[AnyObject] = Array()
    var offset:CGFloat = 0

    if scrollView != nil {

        offset = scrollView!.contentOffset.y

    }

    // rather than iterating thru a full list of our blog items, just look at ones we haven't moved yet
    for view in listOfCellsInStartinPositionsOffScreen {

        // find the y value for the bottom of the screen
        let yValueOfBottomOfScreen = offset + defaultFrameForSplitScreen.size.height

        // check to see if a view is on screen 
        // (if was scheduled for move, would have already been removed from view)
        if view.frame.origin.y <  yValueOfBottomOfScreen {

            // if so, add it to our list of cells to move
            firstTimers.append(view)
            listOfCellsInStartinPositionsOffScreen.removeObject(view)

        } else {

            // if a cell is off screen, then all subsequent cells are off screen, so return
            return firstTimers

        }

    }

    return firstTimers

}

func moveCellsFromStartPointToDestination(#cellsToMove:Array<AnyObject>?, defaultDelay:Float, defaultLenghtOfAnimation:Float){


    // deal with optionals
    if(cellsToMove?.count == 0){ return; }
    var cells = cellsToMove!


    // for each cell
    for aCell in cells {
let theCell = aCell as BlogText
println("\(theCell.ourTitle)")
        // if items ahead waiting to move, recalculate delay
        let delayBeforeNextItem:Double = calculateDelayBeforeMovingNextItem_andSaveLastUsedTimeSlot(defaultDelay)!

        // move cell / run method after time delay using dispatch queue
        var dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayBeforeNextItem * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {


                // BLOCK

                self.moveCell(cell: aCell as BlogText, lengthOfAnimation: defaultLenghtOfAnimation)

                // END BLOCK

        })

    }

}

func moveCell(#cell:BlogText!, lengthOfAnimation:Float!){


    UIView.animateWithDuration(Double(lengthOfAnimation), animations: { () -> Void in

        // check to see if it is a right or a left cell, which will have different positions, save value

        var xPos:CGFloat!

        if cell.frame.origin.x < 0 {

            xPos = self.xPositionLeftDestination

        } else {

            xPos = self.xPositionRightDestinatation
        }

        // move cell
        cell.frame = CGRectMake(xPos, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)

    })

}

func calculateDelayBeforeMovingNextItem_andSaveLastUsedTimeSlot(delay:Float!)->(Double!)
{

    var moveInXSeconds:Float

    if lastUsedTimeSlotToMoveItem_inTermsOfSecondsSinceStart > secondsSinceStart
    {

        // how many seconds ahead of now, should we wait?
        moveInXSeconds = (lastUsedTimeSlotToMoveItem_inTermsOfSecondsSinceStart + delay) - secondsSinceStart

    }else{

        moveInXSeconds = delay

    }

    lastUsedTimeSlotToMoveItem_inTermsOfSecondsSinceStart = moveInXSeconds
    println("\(secondsSinceStart) + \(moveInXSeconds)\n")
    return Double(moveInXSeconds)

}





} // End
