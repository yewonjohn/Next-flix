//
//  VideoManager.swift
//  Next-flix
//
//  Created by John Kim on 6/15/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import Foundation

//DEFINE PROTOCOL FOR DELEGATE FRAMEWORK
protocol VideoManagerDelegate {
    func didUpdateVideo(_ videoManager: VideoManager, videos: [VideoModel])
    func didFailWithError(error: Error)
}

struct VideoManager {
    //setting delegate here (for whoever uses the protocol)
    var delegate: VideoManagerDelegate?
    
    let headers = [
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com",
        "x-rapidapi-key": "cc4e05abbemshfaad188dfa53b0ap1d961ajsna3570a8403a1"
    ]
    
    let comingRequest = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew7%3AUS&p=1&t=ns&st=adv")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    
    let leavingRequest = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Aexp%3AUS&t=ns&st=adv&p=1")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    
    //fetches films that are coming to netflix
    func fetchComingVideos(){
        comingRequest.httpMethod = "GET"
        comingRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: comingRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.delegate?.didFailWithError(error: error!)
            } else {
                if let safeData = data{
                    if let videoArr = self.parseJSON(safeData){
                        self.delegate?.didUpdateVideo(self, videos: videoArr)
                        print("delegate function triggered?")
                    }
                }
            }
        })
        dataTask.resume()
    }
    //fetches films that are leaving netflix
    func fetchLeavingVideos(){
        leavingRequest.httpMethod = "GET"
        leavingRequest.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: leavingRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.delegate?.didFailWithError(error: error!)
            } else {
                if let safeData = data{
                    if let videoArr = self.parseJSON(safeData){
                        self.delegate?.didUpdateVideo(self, videos: videoArr)
                    }
                }
            }
        })
        
        dataTask.resume()
    }
    
    //parses JSON to objects
    func parseJSON(_ videoData: Data) -> [VideoModel]?{
        var videoArray: [VideoModel]? = []
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            //iterate through every decodedData.ITEMS array and add to array
            for item in decodedData.ITEMS{
                let video = VideoModel(netflixid: item.netflixid, title: item.title, image: item.image, synopsis: item.synopsis, rating: item.rating, type: item.type, released: item.released, runtime: item.runtime, largeimage: item.largeimage)
                videoArray?.append(video)
            }
            return videoArray
        }catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

