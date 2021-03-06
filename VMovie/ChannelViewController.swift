//
//  ChannelViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/4.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import TabPageViewController

class ChannelViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    @IBOutlet var ChanelView: UICollectionView!
    
    var dataSource = [Channel]()
    let screenWidth = UIScreen.main.bounds.width
    var cateArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.ChanelView.dataSource = self
        self.ChanelView.delegate = self
        self.getChannelList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ChannelDetailViewController
        if (segue.identifier == "showChannelDetail") {
            let cell = sender as! ChannelCell
            viewController.requestURL = "\(Constants.API_URL)/post/getPostInCate?size=10&cateid=\(cell.channelID!)"
            viewController.navigateTitle = cell.channelName.text
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.ChanelView.dequeueReusableCell(withReuseIdentifier: "ChanelCell", for: indexPath) as! ChannelCell
        let ChannelList = dataSource[indexPath.row]
        let channelCoverUrl = URL(string: ChannelList.channelImage)
        cell.channelImage.kf.setImage(with: channelCoverUrl)
        cell.channelName.text = ChannelList.channelName
        cell.channelID = ChannelList.channelID
        cell.channelImage.frame.size = CGSize(width:screenWidth/2,height:screenWidth/2)
        cell.channelName.center = cell.channelImage.center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth/2, height: screenWidth/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath) as! ChannelHeaderView
            headerView.frame = CGRect(x:0,y:72,width:screenWidth,height:screenWidth)
            
            let hotTapGesture = UITapGestureRecognizer(target: self, action: #selector(ChannelViewController.handleHotTapped(gesture:)))
            headerView.hotImage.addGestureRecognizer(hotTapGesture)
            
            let albumTapGesture = UITapGestureRecognizer(target: self, action: #selector(ChannelViewController.handleAlbumTapped(gesture:)))
            headerView.albumImage.addGestureRecognizer(albumTapGesture)
            
            let backstageTapGesture = UITapGestureRecognizer(target: self, action: #selector(ChannelViewController.handleBackstageTapped(gesture:)))
            headerView.backstageImage.addGestureRecognizer(backstageTapGesture)
            
            let seriesTapGesture = UITapGestureRecognizer(target: self, action: #selector(ChannelViewController.handleSeriesTapped(gesture:)))
            headerView.seriesImage.addGestureRecognizer(seriesTapGesture)
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func handleHotTapped(gesture: UIGestureRecognizer){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChannelDetailViewController") as? ChannelDetailViewController {
            if let navigator = self.navigationController {
                viewController.requestURL = "\(Constants.API_URL)/post/getPostByTab?size=10&tab=hot"
                viewController.navigateTitle = "热门"
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func handleAlbumTapped(gesture: UIGestureRecognizer) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumViewController") as? AlbumViewController {
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func handleBackstageTapped(gesture: UIGestureRecognizer){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BackStageViewController") as? BackStageViewController {
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func handleSeriesTapped(gesture: UIGestureRecognizer){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SeriesViewController") as? SeriesViewController {
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: screenWidth, height: screenWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
        return UIEdgeInsets(top: 72, left: 0, bottom: 0, right: 0)
    }
    
    func getChannelList() {
        Alamofire.request("\(Constants.API_URL)/cate/getList").responseJSON { response in
            if let json = response.result.value {
                let jsonObject = JSON(json)
                for aChannel in jsonObject["data"]{
                    let channelName = "#\(aChannel.1["catename"])#"
                    let channelImage = aChannel.1["icon"].stringValue
                    let channelID = aChannel.1["cateid"].stringValue
                    let channels = Channel(channelImage:channelImage,channelName:channelName,channelID: channelID)
                    self.dataSource.append(channels)
                }
                self.ChanelView.reloadData()
            }
        }
    }
}
