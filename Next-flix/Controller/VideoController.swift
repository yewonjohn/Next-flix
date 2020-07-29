//
//  VideoController.swift
//  Next-flix
//
//  Created by John Kim on 6/15/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit
import Kingfisher

class VideoController: UIViewController{
    
    var video: VideoModel?
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var videoRelease: UILabel!
    @IBOutlet weak var runtime: UILabel!
    
    
    override func viewDidLoad() {
        //setting image with kingfisher
        let url = URL(string: video!.largeimage)
        videoImage?.kf.setImage(with: url)
        videoTitle?.text = video?.title
        synopsis?.attributedText = video?.synopsis.htmlToAttributedString
//        synopsis?.textColor = #colorLiteral(red: 0.8312904239, green: 0.8314308524, blue: 0.848477304, alpha: 1)
//        synopsis?.font = UIFont(name:"Helvetica Neue", size: 24.0)
//        synopsis?.text = video?.synopsis
        rating?.text = video?.rating
        videoRelease?.text = video?.released
        runtime?.text = video?.runtime
 
    }
    func fetchImage(){
        
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


