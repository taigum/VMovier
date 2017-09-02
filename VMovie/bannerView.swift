//
//  bannerView.swift
//  VMovie
//
//  Created by vara shen on 2017/8/29.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import LLCycleScrollView
class bannerView: UICollectionReusableView {
        
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bannerView: LLCycleScrollView!
    var imagesURLStrings = [String]()
    override func layoutSubviews() {
        self.bannerView.imageViewContentMode = .scaleToFill
        self.bannerView.pageControlPosition = .left
        self.bannerView.customPageControlStyle = .pill
        
        self.bannerView.customPageControlInActiveTintColor = UIColor.lightGray
        self.bannerView.pageControlBottom = 20
        scrollView.addSubview(bannerView)
    }
}
