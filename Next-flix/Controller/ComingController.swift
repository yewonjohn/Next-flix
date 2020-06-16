//
//  ViewController.swift
//  Next-flix
//
//  Created by John Kim on 6/12/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit

class ComingController: UITableViewController {
    
    //setting instance of videoManager
    var videoManager = VideoManager()
    var videoArray: [VideoModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //SETTING ARRAY FOR TESTING
        let vid1 = VideoModel(netflixid: "1234", title: "Bob", image: "http://art-0.nflximg.net/7e210/c95b08aff5e62852a3f9be44c9c8f12f65b7e210.jpg", synopsis: "There once was a man beep boppitty", rating: "7.7", type: "movie", released: "2013", runtime: "1h19m", largeimage: "http://cdn1.nflximg.net/images/9475/10869475.jpg")
        let vid2 = VideoModel(netflixid: "1235", title: "Bobby", image: "http://art-0.nflximg.net/7e210/c95b08aff5e62852a3f9be44c9c8f12f65b7e210.jpg", synopsis: "There once was a man beep boppitty", rating: "7.7", type: "movie", released: "2013", runtime: "1h19m", largeimage: "http://cdn1.nflximg.net/images/9475/10869475.jpg")
        let vid3 = VideoModel(netflixid: "1236", title: "Bobby Brown", image: "http://art-0.nflximg.net/7e210/c95b08aff5e62852a3f9be44c9c8f12f65b7e210.jpg", synopsis: "There once was a man beep boppitty", rating: "7.7", type: "movie", released: "2013", runtime: "1h19m", largeimage: "http://cdn1.nflximg.net/images/9475/10869475.jpg")
        videoArray.append(vid1)
        videoArray.append(vid2)
        videoArray.append(vid3)
        
        videoManager.delegate = self
        //COMMENTING OUT API CALL FOR TESTING
//        videoManager.fetchComingVideos()
        //setting this VC to videoManager delegate
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
    }
    
    //MARK - Tableview DataSource Methods
    //DEFINES HOW MANY CELLS TO CREATE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    //Runs every time a cell is loaded
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //set current cell with "Coming Cell" at the current index
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        //setting fetched cell text
        cell.videoTitle.text = videoArray[indexPath.row].title
        cell.videoType.text = videoArray[indexPath.row].type
        cell.videoRelease.text = videoArray[indexPath.row].released
        cell.videoRating.text = videoArray[indexPath.row].rating
        
        //----
        if let imageURL = URL(string: videoArray[indexPath.row].image){
            // just not to cause a deadlock in UI!
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.videoImage.image = image
                }
            }
        }
        //----
        
        //returning updated cell
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //deselects after selecting
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vid = videoArray[indexPath.row]
        let destinationVC = VideoController()
        destinationVC.video = vid
        
        //SEGUE - sends over selected video
        performSegue(withIdentifier: "ComingSegue", sender: self)
    }
    
    
    //setting cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK - VideoManager Delegate Methods
extension ComingController: VideoManagerDelegate{
    
    func didUpdateVideo(_ videoManager: VideoManager, videos: [VideoModel]) {
        videoArray = videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
