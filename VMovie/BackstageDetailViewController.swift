//
//  BackstageDetailViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/29.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class BackstageDetailViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var backstageView: UIWebView!
    
    var postID:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backstageView.delegate = self
        backstageView.frame = self.view.bounds
        let url = URL(string: "http://h5.vmovier.com/index.html?id=\(postID!)")
        print("url:\(url)")
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data,response,error) in
                if error == nil {
                    self.backstageView.loadRequest(request)
                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
            task.resume()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        let items = "document.getElementsByClassName('fixed-banner log')[0].style.display='none';"
        backstageView.stringByEvaluatingJavaScript(from: items)
        let title = backstageView.stringByEvaluatingJavaScript(from: "document.title")!
        self.title = title
    }
}
