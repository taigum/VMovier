//
//  AlbumViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/7.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
import NVActivityIndicatorView

class AlbumViewController: UITableViewController {

    @IBOutlet var AlbumView: UITableView!
    
    var dataSource = [Album]()
    let screenWidth = UIScreen.main.bounds.width
    var refreshPage = 1
    
    override func viewDidLoad() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        super.viewDidLoad()
        self.getAlbumList()
        self.title = "专题"
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        let AlbumList = dataSource[indexPath.row]
        let albumCoverUrl = URL(string: AlbumList.albumImage)
        cell.albumImage.kf.setImage(with: albumCoverUrl)
        cell.albumTitle.text = AlbumList.albumTitle
        cell.albumFullTitle.text = AlbumList.albumFullTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenWidth/1.5
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = dataSource.count - 1
        if indexPath.row == lastElement {
            refreshPage+=1
            self.getAlbumList()
        }
    }
    
    func getAlbumList(){
        Alamofire.request("\(Constants.API_URL)/post/getPostByTab?p=\(String(refreshPage))&size=10&tab=album").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aAlbum in jsonObject["data"] {
                    let albumImage = aAlbum.1["image"].stringValue
                    let albumTitle = aAlbum.1["title"].stringValue
                    let albumFullTitle = aAlbum.1["app_fu_title"].stringValue
                    let Albums = Album(albumImage: albumImage,albumTitle: albumTitle,albumFullTitle: albumFullTitle)
                    self.dataSource.append(Albums)
                    
                }
                self.AlbumView.reloadData()
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
        }
    }

    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
