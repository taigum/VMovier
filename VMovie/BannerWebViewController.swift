//
//  BannerWebViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/1.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class BannerWebViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var bannerWebView: UIWebView!
    var bannerParam: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerWebView.delegate = self
        
        let url = URL(string: self.bannerParam)
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data,response,error) in
                if error == nil {
                    self.bannerWebView.loadRequest(request)
                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
            task.resume()
        }
    }

    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let title = bannerWebView.stringByEvaluatingJavaScript(from: "document.title")!
        self.title = title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
