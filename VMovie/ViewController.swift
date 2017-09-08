//
//  ViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/8/26.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import LLCycleScrollView
import Alamofire
import SwiftyJSON
import TabPageViewController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tc = TabPageViewController.create()
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiscoverTabViewController")
        vc1.view.backgroundColor = UIColor.white
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChannelViewController")
        tc.tabItems = [(vc1, "发现"), (vc2, "频道")]
        var option = TabPageOption()
        option.tabWidth = view.frame.width / CGFloat(tc.tabItems.count)
        option.hidesTabBarOnSwipe = true
        option.tabHeight = 50
        option.tabBackgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        option.defaultColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        option.currentColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        option.pageBackgoundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        option.fontSize = 16
        option.tabWidth = view.frame.width / 4
        tc.option = option
        self.navigationController?.addChildViewController(tc)
        tc.view.frame = view.bounds
        tc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

