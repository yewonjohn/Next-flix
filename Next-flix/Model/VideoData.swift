//
//  VideoData.swift
//  Next-flix
//
//  Created by John Kim on 6/15/20.
//  Copyright © 2020 John Yewon Kim. All rights reserved.
//

import Foundation

struct VideoData: Decodable {
    let COUNT: String
    let ITEMS: [Videos]
}

struct Videos: Decodable {
    let netflixid: String
    let title: String
    let image: String
    let synopsis: String
    let rating: String
    let type: String
    let released: String
    let runtime: String
    let largeimage: String
    
}
