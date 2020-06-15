//
//  ViewController.swift
//  Next-flix
//
//  Created by John Kim on 6/12/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import UIKit

class ComingController: UITableViewController {

    var exampleArr = ["Testing1","Testing2","Testing3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var videoManager = VideoManager()
//        videoManager.fetchVideos()
        
        tableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")


    }
    
    //MARK - Tableview DataSource Methods
    
    //DEFINES HOW MANY CELLS TO CREATE
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleArr.count
    }
    
    //Runs every time a cell is loaded
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //set current cell with "Coming Cell" at the current index
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        //setting fetched cell text
        cell.videoTitle.text = exampleArr[indexPath.row]
        cell.videoType.text = "Movie"
        //returning updated cell
        return cell
        
    }
    //MARK - Tableview Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //deselects after selecting
        tableView.deselectRow(at: indexPath, animated: true)
        
        //performs segue
        performSegue(withIdentifier: "ComingSegue", sender: self)
        
        }
    
    //setting cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    //sends appropriate data over through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ComingSegue"{
            let destinationVC = segue.destination as! VideoController
            destinationVC.videoTit = "Moana"
        }
    }
}

