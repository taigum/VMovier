//
//  ChannelHeaderView.swift
//  VMovie
//
//  Created by vara shen on 2017/9/5.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class ChannelHeaderView: UICollectionReusableView {
//    @IBOutlet weak var headerSubView: UIView!
    @IBOutlet weak var hotImage: UIImageView!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var backstageImage: UIImageView!
    @IBOutlet weak var seriesImage: UIImageView!
    
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var backstageLabel: UILabel!
    @IBOutlet weak var hotLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!    

    let screenWidth = UIScreen.main.bounds.width
    override func layoutSubviews() {
        hotImage.frame = CGRect(x:0,y:0,width: screenWidth/2,height:screenWidth/2)
        hotImage.isUserInteractionEnabled = true
        albumImage.frame = CGRect(x:screenWidth/2,y:0,width: screenWidth/2,height:screenWidth/2)
        albumImage.isUserInteractionEnabled = true
        backstageImage.frame = CGRect(x:0,y:screenWidth/2,width: screenWidth/2,height:screenWidth/2)
        backstageImage.isUserInteractionEnabled = true
        seriesImage.frame = CGRect(x:screenWidth/2,y:screenWidth/2,width: screenWidth/2,height:screenWidth/2)
        seriesImage.isUserInteractionEnabled = true
        
        albumLabel.center = albumImage.center
        backstageLabel.center = backstageImage.center
        hotLabel.center = hotImage.center
        seriesLabel.center = seriesImage.center
    }
    
}
