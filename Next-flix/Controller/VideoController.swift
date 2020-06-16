//
//  VideoController.swift
//  Next-flix
//
//  Created by John Kim on 6/15/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit

class VideoController: UIViewController{
    
    var video: VideoModel?
    var vidImg: UIImage?
    var vidTitle: String?
    var vidSynopsis: String?
    var vidRating: String?
    var vidRelease: String?
    var vidRuntime: String?
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var videoRelease: UILabel!
    @IBOutlet weak var runtime: UILabel!
    
    
    override func viewDidLoad() {
        videoImage.image = vidImg
        videoTitle?.text = vidTitle
        synopsis?.text = vidSynopsis
        rating?.text = vidRating
        videoRelease?.text = vidRelease
        runtime?.text = vidRuntime
        
        
        //blah
    }
}
