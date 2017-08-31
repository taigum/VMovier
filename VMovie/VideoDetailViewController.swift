//
//  VideoDetailViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/8/30.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import BMPlayer

class VideoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var player = BMPlayer()
        view.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        // Back button event
        player.backBlock = { [unowned self] in
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
