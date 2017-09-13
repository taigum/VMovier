//
//  Series.swift
//  VMovie
//
//  Created by vara shen on 2017/9/12.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import Foundation

class Series {
    
    let seriesCover: String
    let seriesTitle: String
    let seriesUpdate: String
    let seriesFollower: String
    let seriesContent: String
    let seriesID: Int
    
    init(seriesCover: String,seriesTitle:String,seriesUpdate: String,seriesFollower:String,seriesContent:String,seriesID:Int) {
        self.seriesCover = seriesCover
        self.seriesTitle = seriesTitle
        self.seriesUpdate = seriesUpdate
        self.seriesFollower = seriesFollower
        self.seriesContent = seriesContent
        self.seriesID = seriesID
    }
}
