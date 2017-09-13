//
//  SeriesCell.swift
//  VMovie
//
//  Created by vara shen on 2017/9/11.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class SeriesCell: UITableViewCell {

    @IBOutlet weak var seriesCover: UIImageView!
    
    @IBOutlet weak var seriesTitle: UILabel!
    
    @IBOutlet weak var seriesUpdate: UILabel!
    
    @IBOutlet weak var seriesFollower: UILabel!
    
    @IBOutlet weak var seriesContent: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
