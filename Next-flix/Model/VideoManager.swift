//
//  VideoManager.swift
//  Next-flix
//
//  Created by John Kim on 6/15/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import Foundation

struct VideoManager {


    let headers = [
        "x-rapidapi-host": "unogs-unogs-v1.p.rapidapi.com",
        "x-rapidapi-key": "cc4e05abbemshfaad188dfa53b0ap1d961ajsna3570a8403a1"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://unogs-unogs-v1.p.rapidapi.com/aaapi.cgi?q=get%3Anew7%3AUS&p=1&t=ns&st=adv")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
    
    func fetchVideos(){
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error ?? "error is empty")
        } else {
            if let safeData = data{
                self.parseJSON(videoData: safeData)
            }
        }
    })

    dataTask.resume()

    }
    
    func parseJSON(videoData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(VideoData.self, from: videoData)
            print(decodedData.ITEMS[0].title)
        }catch {
            print(error)
        }
        
    }
    
}

