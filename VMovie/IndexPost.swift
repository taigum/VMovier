//
//  IndexPost.swift
//  VMovie
//
//  Created by vara shen on 2017/8/29.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import Foundation

class IndexPost {
    
    let postCover: String
    let cateName: String
    let duration: String
    let title: String
    let postId: Int
    let requestURL: String
    
    init(postCover: String,cateName:String,duration: String,title:String,postId: Int,requestURL: String) {
        self.postCover = postCover
        self.cateName = cateName
        self.duration = duration
        self.title = title
        self.postId = postId
        self.requestURL = requestURL
    }
}
