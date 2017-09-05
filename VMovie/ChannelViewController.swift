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

//private let reuseIdentifier = "Cell"

class ChannelViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    @IBOutlet var ChanelView: UICollectionView!
    
    var dataSource = [Channel]()
    let screenWidth = UIScreen.main.bounds.width
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showChannelDetail") {
            let viewController = segue.destination as! ChannelDetailViewController
            let cell = sender as? ChannelCell
            viewController.cateID = cell?.tag
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
        cell.tag = ChannelList.channelID
        
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
    
    func getChannelList() {
        Alamofire.request("\(Constants.API_URL)/cate/getList").responseJSON { response in
            if let json = response.result.value {
                let jsonObject = JSON(json)
                for aChannel in jsonObject["data"]{
                    let channelName = "#\(aChannel.1["catename"])#"
                    let channelImage = aChannel.1["icon"].stringValue
                    let channelID = aChannel.1["cateid"].intValue
                    let channels = Channel(channelImage:channelImage,channelName:channelName,channelID: channelID)
                    self.dataSource.append(channels)
                }
                self.ChanelView.reloadData()
            }
        }
    }

}
