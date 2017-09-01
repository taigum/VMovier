//
//  DiscoverTabViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/8/29.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import LLCycleScrollView
import Alamofire
import SwiftyJSON
import Kingfisher

class DiscoverTabViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var postView: UICollectionView!

    var imagesURLStrings = [String]()
    var dataSource = [IndexPost]()
    var requestURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postView.delegate = self
        self.postView.dataSource = self
        self.setBannerImage()
        self.getIndexPostList()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("indexPath:\(indexPath[1])")
        let cell = self.postView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IndexPostViewCell
        let Poster = dataSource[indexPath.row]
        let postCoverUrl = URL(string: Poster.postCover)
        cell.postCover.kf.setImage(with: postCoverUrl)
        cell.cateName.text = Poster.cateName
        cell.duration.text = Poster.duration
        cell.title.text = Poster.title
        cell.tag = Poster.postId
        self.requestURL = Poster.requestURL
        if indexPath[1] == 0 {
            cell.dateLabel.isHidden = false
        }else{
            cell.dateLabel.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath) as! bannerView
            headerView.bannerView.imagePaths = self.imagesURLStrings
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: CGFloat(screenWidth), height: CGFloat(255))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showVideo") {
            let viewController = segue.destination as! VideoDetailViewController
            let cell = sender as? IndexPostViewCell
            viewController.postId = cell?.tag
            viewController.requestURL = self.requestURL
            let index = self.dataSource.index(where: {$0.postId==cell?.tag})
            self.requestURL = self.dataSource[index!].requestURL
            viewController.requestURL = self.requestURL
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBannerImage(){
        Alamofire.request("\(Constants.API_URL)/index/getBanner").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aBanner in jsonObject["data"] {
                    self.imagesURLStrings.append(aBanner.1["image"].stringValue)
                }
            }
        }
    }
    
    func getIndexPostList(){
        Alamofire.request("\(Constants.API_URL)/index/getIndexPosts").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aPost in jsonObject["data"]["list"] {
                    let postCover = aPost.1["image"].stringValue
                    let postCateName = aPost.1["cate"][0]["catename"].stringValue
                    let postTitle = aPost.1["title"].stringValue
                    let duration = aPost.1["duration"].intValue
                    let minute = duration/1000/60
                    let second = (duration/1000)%60
                    let postDuration = "\(minute)′\(second)″"
                    let postId = aPost.1["postid"].intValue
                    let requestURL = aPost.1["request_url"].stringValue
                    let post = IndexPost(postCover: postCover,cateName:postCateName,duration:postDuration,title:postTitle,postId:postId,requestURL:requestURL)
                    
                    self.dataSource.append(post)
                }
                self.postView.reloadData()
            }
        }
    }
}
