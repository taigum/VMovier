//
//  ListViewController.swift
//  VMovie
//
//  Created by vara shen on 2017/8/28.
//  Copyright © 2017年 vara shen. All rights reserved.
//

import UIKit
import TabPageViewController

class ListViewController: UITableViewController {

    @IBOutlet var testView: UITableView!
    
    override func viewDidLoad() {
        self.tableView.contentInset = UIEdgeInsets(top: 65,left: 0,bottom: 0,right: 0)
    }
    
    fileprivate func updateNavigationBarOrigin(velocity: CGPoint) {
        guard let tabPageViewController = parent as? TabPageViewController else { return }
        
        if velocity.y > 0.5 {
            tabPageViewController.updateNavigationBarHidden(true, animated: true)
        } else if velocity.y < -0.5 {
            tabPageViewController.updateNavigationBarHidden(false, animated: true)
        }
    }
}


// MARK: - UITableViewDataSource

extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = String((indexPath as NSIndexPath).row)
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension ListViewController {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        updateNavigationBarOrigin(velocity: velocity)
    }
    
    override func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        guard let tabpageViewController = parent as? TabPageViewController else { return }
        
        tabpageViewController.showNavigationBar()
    }
}
