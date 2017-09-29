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
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var sectionNumber:Int = 1
    var imagesURLStrings = [String]()
    struct bannerImage {
        var bannerType: String
        var bannerParam: String
    }
    var bannerImageData = [bannerImage]()
    var dataSource = [IndexPost]()
    var requestURL: String!
    var lastID: String!
    let screenWidth = UIScreen.main.bounds.width
    var titleLabel:UILabel = {
        let label = UILabel(frame: CGRect(x:0, y: 0, width: UIScreen.main.bounds.width , height: 60))
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postView.delegate = self
        self.postView.dataSource = self
        self.setBannerImage()
        self.getIndexPostList()
        self.loading.isHidden = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.postView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IndexPostViewCell
        print("sectionNumber:\(indexPath.section)")
        let Poster = dataSource[indexPath.row]
        let postCoverUrl = URL(string: Poster.postCover)
        cell.postCover.kf.setImage(with: postCoverUrl)
        cell.cateName.text = Poster.cateName
        cell.duration.text = Poster.duration
        cell.title.text = Poster.title
        cell.tag = Poster.postId
        self.requestURL = Poster.requestURL
        if indexPath[1] == 0 {
            cell.addSubview(self.titleLabel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath) as! bannerView
            headerView.bannerView.imagePaths = self.imagesURLStrings
            headerView.bannerView.lldidSelectItemAtIndex = { index in
                
                self.handleBannerView(index)
            }
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        if indexPath[1] == 0 {
            return CGSize(width: screenWidth, height: (screenWidth/1.5)+60)
        }else{
            return CGSize(width: CGFloat(screenWidth), height: screenWidth/1.5)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = dataSource.count - 1
        if indexPath.row == lastElement {
            loading.isHidden = false
            loading.startAnimating()
            self.getPreVideo()
        }else{
            loading.isHidden = true
        }
    }
    
    func handleBannerView(_ index:Int){
        if bannerImageData[index].bannerType == "1" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let BannerWebViewController = storyBoard.instantiateViewController(withIdentifier: "BannerWebViewController") as! BannerWebViewController
            BannerWebViewController.bannerParam = bannerImageData[index].bannerParam
            self.navigationController?.pushViewController(BannerWebViewController, animated: true)
        }else if bannerImageData[index].bannerType == "2" {
            goToVideoDetail(bannerImageData[index].bannerParam)
        }
    }
    
    func goToVideoDetail(_ bannerParam: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let VideoDetailViewController = storyBoard.instantiateViewController(withIdentifier: "VideoDetailViewController") as! VideoDetailViewController
        VideoDetailViewController.postId = Int(bannerParam)
        VideoDetailViewController.requestURL = "http://app.vmoiver.com/\(bannerParam)?qingapp=app_new"
        self.navigationController?.pushViewController(VideoDetailViewController, animated: true)
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
                    let bannertype = aBanner.1["extra_data"]["app_banner_type"].stringValue
                    let bannerparam = aBanner.1["extra_data"]["app_banner_param"].stringValue
                    let bannerData = bannerImage(bannerType: bannertype,bannerParam:bannerparam)
                    self.bannerImageData.append(bannerData)
                }
                self.postView.reloadData()
            }
        }
    }
    
    func getIndexPostList(){
        Alamofire.request("\(Constants.API_URL)/index/index").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                self.titleLabel.text = jsonObject["data"]["today"]["selection_title"].stringValue
                self.lastID = jsonObject["data"]["today"]["lastid"].stringValue
                for aPost in jsonObject["data"]["today"]["list"] {
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
    
    func getPreVideo() {
        Alamofire.request("\(Constants.API_URL)/index/getIndexPosts/lastid/\(self.lastID!)").responseJSON{ response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                self.lastID = jsonObject["data"]["lastid"].stringValue
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
                self.sectionNumber += 1
                self.loading.stopAnimating()
                self.postView.reloadData()
            }
        }
    }
}
