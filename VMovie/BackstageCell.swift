//
//  BackstageCell.swift
//  VMovie
//
//  Created by vara shen on 2017/9/27.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class BackstageCell: UICollectionViewCell {
    
    @IBOutlet weak var backstageCover: UIImageView!
    
    @IBOutlet weak var backstageTitle: UILabel!
    
    @IBOutlet weak var shareCount: UILabel!
    
    @IBOutlet weak var likeCount: UILabel!
    
    override func layoutSubviews() {
        self.backstageTitle.adjustsFontSizeToFitWidth = false
        self.backstageTitle.lineBreakMode = .byTruncatingTail
    }
    
}
