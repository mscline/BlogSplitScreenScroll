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

        BlogText.init(title:@"kjh", text:@"lkjl", style:nil, insertInView:self.view)
    }



}

