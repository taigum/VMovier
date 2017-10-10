//
//  BackStageViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/7.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import TabPageViewController
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class BackStageViewController: UIViewController {
    
    var myStringArray: [(String,Int)] = []
   
    override func viewDidLoad() {
         myStringArray.append(("One", 1))
        super.viewDidLoad()
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        self.title = "幕后文章"
        let tc = TabPageViewController.create()
        var currentTabIndex: Int? {
            guard let viewController = tc.viewControllers?.first else { return nil }
            return tc.tabItems.map{ $0.viewController }.index(of: viewController)
        }
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc6 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc7 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        let vc8 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackstageListViewController") as! BackstageListViewController
        vc1.cateID = "2"
        vc2.cateID = "47"
        vc3.cateID = "53"
        vc4.cateID = "4"
        vc5.cateID = "31"
        vc6.cateID = "80"
        vc7.cateID = "30"
        vc8.cateID = "26"
        tc.tabItems = [(vc1, "全部"),(vc2, "电影自习室"),(vc3, "电影会客厅"), (vc4, "拍摄"), (vc5, "器材"),(vc6, "VR"), (vc7, "后期"), (vc8, "综述")]
        
        tc.isInfinity = true
        let nc = UINavigationController()
        nc.viewControllers = [tc]
        var option = TabPageOption()
        option.currentColor = UIColor.black
        option.tabMargin = 20.0
        option.tabHeight = 44
        option.isTranslucent = true
        tc.option = option
        self.addChildViewController(tc)
        self.view.addSubview(tc.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
