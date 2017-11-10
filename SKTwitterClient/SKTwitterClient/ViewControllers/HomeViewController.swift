//
//  HomeViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/10/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var followersCollectionView: UICollectionView!
    
    override class func instance()->HomeViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
        }
        
        layout.estimatedItemSize = CGSize(width: 400, height: 100)
        followersCollectionView.collectionViewLayout = layout

    }
    
}

extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollwerGridStyleCollectionViewCell", for: indexPath) as? FollwerGridStyleCollectionViewCell
        cell?.backgroundColor = .clear
        cell?.userScreenNameLabel.text = "akjsask dajs kdasjd kasjd akjsd kasd kasjd aksjd aksjd aksdj aksdj askda jsdjka skjda sdkas dkas dakjsd aksdj aksd jaskdj askda sdkja sdkas ksja ksdja skdjas dkasj d"
//        cell?.cellWidthConstraint.constant = self.view.frame.size.width - 24
        cell?.cellWidthConstraint.constant = self.view.frame.size.width / 3 - 24

        cell?.layoutIfNeeded()
        return cell!
    }
    
    
}
