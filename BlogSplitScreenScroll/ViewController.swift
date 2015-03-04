//
//  ViewController.swift
//  BlogSplitScreenScroll
//
//  Created by xcode on 1/9/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textBox: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()


    }


    override func viewDidAppear(animated: Bool) {


        // build split screen
        let facade = BlogSplitScreenFacade()
        facade.setupBlogSplitScreenWithPadding(blogFrame: CGRectMake(10, 10, 350, 400), forView: self.view, outsidePadding_horizontal: 15, interiorPadding_horizontal: 10, topPadding: 15)

        // create data
        var dataArrayLeft:[BlogDataObject] = Array()
        var dataArrayRight:[BlogDataObject] = Array()

                let d1 = facade.createBlogDataObject(theTitle:"1 title\n", theText:"1 sampelText blah blah the papplkjds lksjflksjfl skfjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
                let d2 = facade.createBlogDataObject(theTitle:"2 title\n", theText:"2 lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
                let d3 = facade.createBlogDataObject(theTitle:"3 title\n", theText:"3 lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
                let d4 = facade.createBlogDataObject(theTitle:"4 title\n", theText:"4 lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
        let d1a = facade.createBlogDataObject(theTitle:"5 title\n", theText:"1 sampelText blah blah the papplkjds lksjflksjfl skfjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
        let d2b = facade.createBlogDataObject(theTitle:"6 title\n", theText:"2 lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
        let d3c = facade.createBlogDataObject(theTitle:"7 title\n", theText:"3 lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
        let d4d = facade.createBlogDataObject(theTitle:"8 title\n", theText:"4 lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)

                let a = facade.createBlogDataObject(theTitle:"a title\n", theText:"A lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
                let b = facade.createBlogDataObject(theTitle:"b title\n", theText:"B ", theOptionalImageLocation:nil, theOptionalImage:nil)
                let c = facade.createBlogDataObject(theTitle:"c title\n", theText:"C lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
                let d = facade.createBlogDataObject(theTitle:"d title\n", theText:"D lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkjlskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
        let a1 = facade.createBlogDataObject(theTitle:"e title\n", theText:"A lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)
        let b2 = facade.createBlogDataObject(theTitle:"f title\n", theText:"B ", theOptionalImageLocation:nil, theOptionalImage:nil)
        let c3 = facade.createBlogDataObject(theTitle:"g title\n", theText:"C lskfjl alkdjlskfj aldkjslfkjs lkdjlkjl lkdjflkj    lkjsdfl lkjldkfjlskfjlskfjlskfjlskjflksjflksj   the cat and the hat ate apple cream pielkjslfkjlskjlksfjlksfjlfkjslfkjslfkj", theOptionalImageLocation:nil, theOptionalImage:nil)


        dataArrayRight.append(a)
        dataArrayRight.append(b)
        dataArrayRight.append(c)
        dataArrayRight.append(d)
        dataArrayRight.append(a1)
        dataArrayRight.append(b2)
        dataArrayRight.append(c3)

        dataArrayLeft.append(d1)
        dataArrayLeft.append(d2)
        dataArrayLeft.append(d3)
        dataArrayLeft.append(d4)
        dataArrayLeft.append(d1a)
        dataArrayLeft.append(d2b)
        dataArrayLeft.append(d3c)
        dataArrayLeft.append(d4d)

        //add data
        facade.updateBlogWithData(arrayOfDataForLeftSide: dataArrayLeft, arrayOfDataForRightSide: dataArrayRight)

        playMusic()
    }

    var player:MCMusicPlayer = MCMusicPlayer()

    func playMusic(){

        player.songNameAndExtention = "Highstrung.mp3"
        player.playMusic()

    }

}

