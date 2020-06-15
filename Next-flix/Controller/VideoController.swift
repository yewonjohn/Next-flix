//
//  VideoController.swift
//  Next-flix
//
//  Created by John Kim on 6/15/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit

class VideoController: UIViewController{
    
    var videoImg: String?
    var videoTit: String?
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    
    
    override func viewDidLoad() {
        videoTitle?.text = videoTit
        //blah
    }
}
