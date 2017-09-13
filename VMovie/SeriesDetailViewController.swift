//
//  SeriesDetailViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/12.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit

class SeriesDetailViewController: UIViewController,UIWebViewDelegate {
    
    var seriesID:Int!
    
    @IBOutlet weak var seriesDetailView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seriesDetailView.delegate = self
        let requestString = "http://www.vmovier.com/series/\(String(seriesID))"
        seriesDetailView.frame = self.view.bounds
        let url = URL(string: requestString)
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data,response,error) in
                if error == nil {
                    self.seriesDetailView.loadRequest(request)
                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
            task.resume()
        }
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        shareButton.addTarget(self, action: #selector(addShare), for: .touchUpInside)
        let item = UIBarButtonItem(customView: shareButton)
        self.navigationItem.setRightBarButton(item, animated: true)
    }

    func addShare() {
        let message = "Message goes here."
        if let image = UIImage(named: "backstage") {
            let vc = UIActivityViewController(activityItems: [image,message], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        let items = "document.getElementById('header').style.display='none';"
        seriesDetailView.stringByEvaluatingJavaScript(from: items)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let title = seriesDetailView.stringByEvaluatingJavaScript(from: "document.title")!
        self.title = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    

}
