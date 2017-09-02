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
import Alamofire
import SwiftyJSON
import Kingfisher

func delay(_ seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}

class VideoDetailViewController: UIViewController {

    @IBOutlet weak var player: BMPlayer!
    @IBOutlet weak var videoWebView: UIWebView!
    
    var index: IndexPath!
    var changeButton = UIButton()
    var postId: Int!
    var requestURL: String!

    var allVideo = [BMPlayerResourceDefinition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        self.getVideo()
        self.setWebView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getVideo(){
        
        Alamofire.request("\(Constants.API_URL)/post/view?postid=\(String(postId))").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aVideo in jsonObject["data"]["content"]["video"]{
                    for video1 in aVideo.1["progressive"]{
                        
                        let videourl = URL(string: video1.1["qiniu_url"].stringValue)
                        let videodefinition = video1.1["profile_name"].stringValue
                        let vVideo = BMPlayerResourceDefinition(url:videourl!,definition:videodefinition)
                        self.allVideo.append(vVideo)
                        
                        let asset = BMPlayerResource(definitions: self.allVideo)
                        self.player.setVideo(resource: asset)
                    }
                }
            }
        }
    }
    
    func setWebView(){
        let url = URL(string: self.requestURL)
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data,response,error) in
                if error == nil {
                    self.videoWebView.loadRequest(request)
                } else {
                    print("ERROR: \(String(describing: error))")
                }
            }
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
