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
    
    @IBOutlet weak var hotButtom: UIButton!
    
    @IBOutlet weak var albumButton: UIButton!
    
    @IBOutlet weak var backstageButton: UIButton!
    
    @IBOutlet weak var seriesButton: UIButton!
    let screenWidth = UIScreen.main.bounds.width
    override func layoutSubviews() {
        hotImage.frame = CGRect(x:0,y:0,width: screenWidth/2,height:screenWidth/2)
        albumImage.frame = CGRect(x:screenWidth/2,y:0,width: screenWidth/2,height:screenWidth/2)
        backstageImage.frame = CGRect(x:0,y:screenWidth/2,width: screenWidth/2,height:screenWidth/2)
        seriesImage.frame = CGRect(x:screenWidth/2,y:screenWidth/2,width: screenWidth/2,height:screenWidth/2)
        
        albumLabel.center = albumImage.center
        backstageLabel.center = backstageImage.center
        hotLabel.center = hotImage.center
        seriesLabel.center = seriesImage.center
        
        hotButtom.frame = CGRect(x:0,y:0,width:screenWidth/2,height:screenWidth/2)
        albumButton.frame = CGRect(x:screenWidth/2,y:0,width: screenWidth/2,height:screenWidth/2)
        backstageButton.frame = CGRect(x:0,y:screenWidth/2,width: screenWidth/2,height:screenWidth/2)
        seriesButton.frame = CGRect(x:screenWidth/2,y:screenWidth/2,width: screenWidth/2,height:screenWidth/2)
    }

    @IBAction func handleAlbumChannel(_ sender: Any) {

//        print("click album channel")
        
    }
 
    @IBAction func handleBackstageChannel(_ sender: Any) {
        print("click backstage channel")
    }
    
    @IBAction func handleSeriesChannel(_ sender: Any) {
        print("click series channel")
    }
    
}
