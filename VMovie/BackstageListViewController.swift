//
//  BackstageListViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/27.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import NVActivityIndicatorView

class BackstageListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet var backstageView: UICollectionView!
    
    var cateID :String!
    var dataSource = [Backstage]()
    var refreshPage = 1
    var imagesURLStrings = [String]()
    struct bannerImage {
        var bannerType: String
        var bannerParam: String
    }
    var bannerImageData = [bannerImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBackstageList()
        self.setBannerImage()
        backstageView.dataSource = self
        backstageView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.backstageView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BackstageCell
        let BackstageList = dataSource[indexPath.row]
        let backstageCoverUrl = URL(string: BackstageList.backstageImage)
        cell.backstageCover.kf.setImage(with: backstageCoverUrl)
        cell.backstageTitle.text = BackstageList.backstageTitle
        cell.shareCount.text = BackstageList.backstageShareCount
        cell.likeCount.text = BackstageList.backstageLikeCount
        cell.tag = BackstageList.backstageID
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElement = dataSource.count - 1
        if indexPath.row == lastElement {
            refreshPage+=1
            self.getBackstageList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! bannerView
            headerView.bannerView.imagePaths = self.imagesURLStrings
            headerView.bannerView.lldidSelectItemAtIndex = { index in
                
                self.handleBannerView(index)
            }
            return headerView
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            return footerView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        if cateID != "2" {
            return CGSize.zero
        }else{
            return CGSize(width:UIScreen.main.bounds.width,height:220)
        }
    }
    
    func handleBannerView(_ index:Int){
        if bannerImageData[index].bannerType == "1" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let BannerWebViewController = storyBoard.instantiateViewController(withIdentifier: "BannerWebViewController") as! BannerWebViewController
            BannerWebViewController.bannerParam = bannerImageData[index].bannerParam
            self.navigationController?.pushViewController(BannerWebViewController, animated: true)
        }
    }
    
    func setBannerImage(){
        Alamofire.request("\(Constants.API_URL)/index/getBanner?type=9").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aBanner in jsonObject["data"] {
                    self.imagesURLStrings.append(aBanner.1["image"].stringValue)
                    let bannertype = aBanner.1["extra_data"]["app_banner_type"].stringValue
                    let bannerparam = aBanner.1["extra_data"]["app_banner_param"].stringValue
                    let bannerData = bannerImage(bannerType: bannertype,bannerParam:bannerparam)
                    self.bannerImageData.append(bannerData)
                }
            }
        }
    }
    
    func getBackstageList() {
        Alamofire.request("\(Constants.API_URL)/backstage/getPostByCate?p=\(refreshPage)&cateid=\(cateID!)").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aBackstage in jsonObject["data"]{
                    let cover = aBackstage.1["image"].stringValue
                    let title = aBackstage.1["title"].stringValue
                    let shareCount = aBackstage.1["share_num"].stringValue
                    let likeCount = aBackstage.1["like_num"].stringValue
                    let postID = aBackstage.1["postid"].intValue
                    
                    let backstageList = Backstage(backstageImage: cover,backstageTitle: title,backstageShareCount:shareCount,backstageLikeCount:likeCount,backstageID:postID)
                    self.dataSource.append(backstageList)
                }
                self.backstageView.reloadData()
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showBackstage") {
            let viewController = segue.destination as! BackstageDetailViewController
            let cell = sender as? BackstageCell
            viewController.postID = cell?.tag
        }
    }
}
