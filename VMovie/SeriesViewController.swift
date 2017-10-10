//
//  SeriesViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/9/6.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
import NVActivityIndicatorView

class SeriesViewController: UITableViewController {

    @IBOutlet var seriesView: UITableView!
    
    var dataSource = [Series]()
    var refreshPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        getSeries()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.title = "系列"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = dataSource.count - 1
        if indexPath.row == lastElement {
            refreshPage+=1
            self.getSeries()
        }
    }
    
    func getSeries(){
        Alamofire.request("\(Constants.API_URL)/series/getList?p=\(refreshPage)").responseJSON { response in
            if let json = response.result.value{
                let jsonObject = JSON(json)
                for aSeries in jsonObject["data"] {
                    let image = aSeries.1["image"].stringValue
                    let title = aSeries.1["title"].stringValue
                    let update = "已更新至\(aSeries.1["update_to"])集"
                    let follower = "\(aSeries.1["follower_num"]))人已订阅"
                    let content = aSeries.1["content"].stringValue
                    let ID = aSeries.1["seriesid"].intValue
                    let SeriesList = Series(seriesCover:image,seriesTitle:title,seriesUpdate:update,seriesFollower:follower,seriesContent:content,seriesID:ID)
                    self.dataSource.append(SeriesList)
                }
                self.seriesView.reloadData()
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesCell", for: indexPath) as! SeriesCell
        let SeriesList = dataSource[indexPath.row]
        let seriesCoverURL = URL(string: SeriesList.seriesCover)
        cell.seriesCover.kf.setImage(with: seriesCoverURL)
        cell.seriesTitle.text = SeriesList.seriesTitle
        cell.seriesFollower.text = SeriesList.seriesFollower
        cell.seriesUpdate.text = SeriesList.seriesUpdate
        cell.seriesContent.text = SeriesList.seriesContent
        cell.tag = SeriesList.seriesID
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! SeriesDetailViewController
        if (segue.identifier == "showSeriesDetail") {
            let cell = sender as? SeriesCell
            viewController.seriesID = cell?.tag
        }
    }
}
