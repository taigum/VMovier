//
//  Album.swift
//  VMovie
//
//  Created by vara shen on 2017/9/7.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import Foundation

class Album {
    
    let albumImage: String
    let albumTitle: String
    let albumFullTitle: String
    
    init(albumImage: String,albumTitle:String,albumFullTitle: String) {
        self.albumImage = albumImage
        self.albumTitle = albumTitle
        self.albumFullTitle = albumFullTitle
    }
}
