//
//  BlogDataObject.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/13/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class BlogDataObject: NSObject {

    var title:String?
    var text:String?
    var imageLocation:String?
    var image:UIImage?

    init(theTitle:NSString?, theText:NSString?, theOptionalImageLocation:NSString?, theOptionalImage:UIImage?){

        title = theTitle
        text = theText
        imageLocation = theOptionalImageLocation
        image = theOptionalImage

    }

    func lookupImageAndInsertIntoView(destinationView:UIView){


    }

}
