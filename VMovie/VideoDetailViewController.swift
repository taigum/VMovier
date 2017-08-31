//
//  VideoDetailViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/8/30.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import BMPlayer
import NVActivityIndicatorView

func delay(_ seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}

class VideoDetailViewController: UIViewController {

    @IBOutlet weak var player: BMPlayer!
    
    var index: IndexPath!
    
    var changeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let res0 = BMPlayerResourceDefinition(url: URL(string: "http://baobab.wdjcdn.com/1457162012752491010143.mp4")!,
                                              definition: "高清")
        let res1 = BMPlayerResourceDefinition(url: URL(string: "http://baobab.wdjcdn.com/1457162012752491010143.mp4")!,
                                              definition: "标清")
        
        let asset = BMPlayerResource(name: "周末号外丨中国第一高楼",
                                     definitions: [res0, res1],
                                     cover: URL(string: "http://img.wdjimg.com/image/video/447f973848167ee5e44b67c8d4df9839_0_0.jpeg"))
        
        player.setVideo(resource: asset)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
