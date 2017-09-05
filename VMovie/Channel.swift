//
//  Channel.swift
//  VMovie
//
//  Created by vara shen on 2017/9/4.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import Foundation


class Channel {
    
    let channelImage: String
    let channelName: String
    let channelID: Int

    init(channelImage: String,channelName:String,channelID: Int) {
        self.channelImage = channelImage
        self.channelName = channelName
        self.channelID = channelID
    }
}
