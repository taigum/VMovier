//
//  ChannelDetailViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/5.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher
import NVActivityIndicatorView

class ChannelDetailViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,NVActivityIndicatorViewable {

    @IBOutlet var channelDetailView: UICollectionView!
    
    var dataSource = [IndexPost]()
    let screenWidth = UIScreen.main.bounds.width
    var refreshPage = 1
    var navigateTitle:String!
    var requestURL:String!
    override func viewDidLoad() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        super.viewDidLoad()
        self.getChannelList()
        self.title = navigateTitle.replacingOccurrences(of: "#", with: "", options: NSString.CompareOptions.literal, range:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.channelDetailView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IndexPostViewCell
        let Poster = dataSource[indexPath.row]
        let postCoverUrl = URL(string: Poster.postCover)
        cell.postCover.kf.setImage(with: postCoverUrl)
        cell.cateName.text = Poster.cateName
        cell.duration.text = Poster.duration
        cell.title.text = Poster.title
        cell.tag = Poster.postId
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: screenWidth/1.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = dataSource.count - 1
        if indexPath.row == lastElement {
            refreshPage+=1
            self.getChannelList()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showChannelVideo") {
            let viewController = segue.destination as! VideoDetailViewController
            var requestURL:String!
            let cell = sender as? IndexPostViewCell
            viewController.postId = cell?.tag
            viewController.requestURL = requestURL
            let index = self.dataSource.index(where: {$0.postId==cell?.tag})
            requestURL = self.dataSource[index!].requestURL
            viewController.requestURL = requestURL
        }
    }
    
    func getChannelList() {

        Alamofire.request("\(requestURL!)&p=\(String(refreshPage))").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aVideo in jsonObject["data"]{
                    let postCover = aVideo.1["image"].stringValue
                    let postCateName = aVideo.1["cate"][0]["catename"].stringValue
                    let postTitle = aVideo.1["title"].stringValue
                    let duration = aVideo.1["duration"].intValue
                    let minute = duration/60
                    let second = (duration)%60
                    let postDuration = "\(minute)′\(second)″"
                    let postId = aVideo.1["postid"].intValue
                    let requestURL = aVideo.1["request_url"].stringValue
                    let post = IndexPost(postCover: postCover,cateName:postCateName,duration:postDuration,title:postTitle,postId:postId,requestURL:requestURL)
                    self.dataSource.append(post)
                    self.stopAnimating()
                }
                self.channelDetailView.reloadData()
            }
        }
    }
}
