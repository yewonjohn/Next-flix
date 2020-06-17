//
//  ViewController.swift
//  Next-flix
//
//  Created by John Kim on 6/12/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit

class LeavingController: UITableViewController {

        //setting vid to pass for segue
        var vidToPass: VideoModel? = nil
        //setting instance of videoManager
        var videoManager = VideoManager()
        var videoArray: [VideoModel] = []
            
        override func viewDidLoad() {
            super.viewDidLoad()
            //SETTING ARRAY FOR TESTING

            
            videoManager.delegate = self
            //COMMENTING OUT API CALL FOR TESTING
            videoManager.fetchLeavingVideos()
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
            
            //returning updated cell
            return cell
        }
        
        //MARK - Tableview Delegate Methods
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //deselects after selecting
            tableView.deselectRow(at: indexPath, animated: true)
            
            let vid = videoArray[indexPath.row]
            vidToPass = vid
            //SEGUE - sends over selected video
            performSegue(withIdentifier: "LeavingSegue", sender: self)
        }
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if (segue.identifier == "LeavingSegue") {
                let destinationVC = segue.destination as! VideoController
                destinationVC.video = vidToPass
            }
        }

        
        //setting cell height
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    }

    //MARK - VideoManager Delegate Methods
    extension LeavingController: VideoManagerDelegate{
        
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

