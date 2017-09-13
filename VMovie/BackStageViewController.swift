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

class BackStageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "幕后文章"
        let tc = TabPageViewController.create()
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor(red: 251/255, green: 252/255, blue: 149/255, alpha: 1.0)
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor(red: 252/255, green: 150/255, blue: 149/255, alpha: 1.0)
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor(red: 149/255, green: 218/255, blue: 252/255, alpha: 1.0)
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor(red: 149/255, green: 252/255, blue: 197/255, alpha: 1.0)
        let vc5 = UIViewController()
        vc5.view.backgroundColor = UIColor(red: 252/255, green: 182/255, blue: 106/255, alpha: 1.0)
        tc.tabItems = [(vc1, "Mon."), (vc2, "Tue."), (vc3, "Wed."), (vc4, "Thu."), (vc5, "Fri.")]
        
        tc.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tc.title = "幕后文章"
        tc.isInfinity = true
        let nc = UINavigationController()
        nc.viewControllers = [tc]
        var option = TabPageOption()
        option.currentColor = UIColor(red: 246/255, green: 175/255, blue: 32/255, alpha: 1.0)
        option.tabMargin = 30.0
        tc.option = option
        self.addChildViewController(tc)
        self.view.addSubview(tc.view)
        var currentTabIndex: Int? {
            guard let viewController = tc.viewControllers?.first else { return nil }
            return tc.tabItems.map{ $0.viewController }.index(of: viewController)
        }
        print("id: \(currentTabIndex)")
        getBackstage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getBackstage() {
        Alamofire.request("\(Constants.API_URL)/backstage/getCate").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                print("jsonObject:\(jsonObject)")
            }
        }
    }

}
