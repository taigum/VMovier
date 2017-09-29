//
//  Backstage.swift
//  VMovie
//
//  Created by vara shen on 2017/9/27.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import Foundation

class Backstage {
    
    let backstageImage: String
    let backstageTitle: String
    let backstageShareCount: String
    let backstageLikeCount: String
    let backstageID: Int
    
    init(backstageImage: String,backstageTitle:String,backstageShareCount: String,backstageLikeCount: String,backstageID:Int) {
        self.backstageImage = backstageImage
        self.backstageTitle = backstageTitle
        self.backstageShareCount = backstageShareCount
        self.backstageLikeCount = backstageLikeCount
        self.backstageID = backstageID
    }
}
