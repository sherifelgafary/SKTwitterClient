//
//  HomeViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/10/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter
import SVPullToRefresh

enum DevicOriantation {
    case LandScape
    case Portrait
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var followersCollectionView: UICollectionView!
    var followers = [UserModel]()
    var followersCurrentPage = "-1"
    let followersPageSize = "5"
    var currentOriantation:DevicOriantation = UIDevice.current.orientation.isLandscape ? .LandScape:.Portrait
    
    override class func instance()->HomeViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        followersCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
        self.getFollowersList()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
        }
        
        layout.estimatedItemSize = CGSize(width: 400, height: 100)
        followersCollectionView.collectionViewLayout = layout
        
        self.followersCollectionView.addPullToRefresh {
            self.followersCurrentPage = "-1"
            self.getFollowersList()
        }
        self.followersCollectionView.pullToRefreshView.arrowColor = .white
        self.followersCollectionView.pullToRefreshView.textColor = .white
        self.followersCollectionView.pullToRefreshView.activityIndicatorViewStyle = .white
        
        self.followersCollectionView.addInfiniteScrolling {
            self.getFollowersList()
        }
        self.followersCollectionView.infiniteScrollingView.activityIndicatorViewStyle = .white
    }
    
    func setupNavigationBarItems()  {
        let logOutButton = UIBarButtonItem(image: UIImage(named:"ico_logout"), style: .plain, target: self, action: #selector(HomeViewController.logout(_:)))
        self.navigationItem.leftBarButtonItem = logOutButton
        
        let currentAccountButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 44))
        currentAccountButton.setTitleColor(.white, for: .normal)
        currentAccountButton.setTitle("@" + (appUser?.userScreenName)!, for: .normal)
        self.navigationItem.titleView = currentAccountButton
        
    }
    
    @objc func chooseCurrentAccount(_ sender: UIButton)  {
        
    }
    
    @objc func logout(_ sender: UIButton)  {
        appUser?.removeUserAUTHData()
        appUser = nil
        let loginVC = LoginViewController.instance()
        replaceCurrentVisableViewControllerWithViewController(viewController: loginVC)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.currentOriantation = .LandScape
        }else {
            self.currentOriantation = .Portrait
        }
        self.followersCollectionView.reloadData()
    }
    
    
    func getFollowersList()  {
        UserModel.getFollowersList(currentPage: followersCurrentPage, pageSize: followersPageSize) { (dataArray, msg, nextPage) in
            if self.followersCurrentPage == "-1"{
                self.followers = dataArray
            }else{
                self.followers.append(contentsOf: dataArray)
            }
            
            if dataArray.count == 0{
                self.followersCollectionView.showsInfiniteScrolling = false
            }else{
                self.followersCollectionView.showsInfiniteScrolling = true
                self.followersCollectionView.infiniteScrollingView.stopAnimating()
            }
            
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.followers)
            UserDefaults.standard.set(encodedData, forKey: "followers")
            
            
            self.followersCollectionView.pullToRefreshView.stopAnimating()
            self.followersCurrentPage = nextPage
            self.followersCollectionView.reloadData()
        }
    }
    
}

extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:FollwerListStyleCollectionViewCell?
        if self.currentOriantation == .LandScape {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollwerGridStyleCollectionViewCell", for: indexPath) as? FollwerGridStyleCollectionViewCell
            cell?.cellWidthConstraint.constant = self.view.frame.size.width / 2 - 18
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollwerListStyleCollectionViewCell", for: indexPath) as? FollwerListStyleCollectionViewCell
            cell?.cellWidthConstraint.constant = self.view.frame.size.width - 24
        }
        cell?.backgroundColor = .clear
        cell?.bindWithFollowerObject(follower: self.followers[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    
}
