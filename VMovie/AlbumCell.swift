//
//  AlbumCell.swift
//  VMovie
//
//  Created by vara shen on 2017/9/7.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumFullTitle: UILabel!
  
    let screenWidth = UIScreen.main.bounds.width
    
    override func layoutSubviews() {
        self.albumImage.frame.size = CGSize(width:screenWidth,height:screenWidth/1.5)
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0,y:albumLabel.frame.height - 1, width:albumLabel.frame.width, height:1.0)
        bottomLine.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        albumLabel.layer.addSublayer(bottomLine)
        self.albumLabel.layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
