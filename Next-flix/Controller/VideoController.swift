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
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var videoRelease: UILabel!
    @IBOutlet weak var runtime: UILabel!
    
    
    override func viewDidLoad() {
        //change that ! later I think
        if let imageURL = URL(string: video!.largeimage){
            // just not to cause a deadlock in UI!
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.videoImage.image = image
                }
            }
        }
        videoTitle?.text = video?.title
        synopsis?.text = video?.synopsis
        rating?.text = video?.rating
        videoRelease?.text = video?.released
        runtime?.text = video?.runtime
 
    }
    func fetchImage(){
        
    }
}
