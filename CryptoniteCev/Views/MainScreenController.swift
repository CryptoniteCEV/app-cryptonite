//
//  MainScreenController.swift
//  CryptoniteCev
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit


class MainScreenController: UIViewController {

    var stories : UICollectionView?
    var coinsCollection : UICollectionView?
    var usersCollection : UICollectionView?

    @IBOutlet weak var coinCollectionView: UICollectionView!
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    @IBOutlet weak var activityTableView: UITableView!
    
    override func viewDidLoad() {
        
        view.overrideUserInterfaceStyle = .dark
        
        loadImages()
        stories = createStoriesView()
        
        
        
        if stories != nil {
            view.addSubview(stories!)
            setStoriesConstraints(stories: stories!)
        }
        
        coinCollectionView.dataSource = self
        coinCollectionView.delegate = self
        
        usersCollectionView.dataSource = self
        usersCollectionView.delegate = self
        
        activityTableView.dataSource = self
        activityTableView.delegate = self
        self.activityTableView.reloadData()
        
    }
}
    

func getImages(image: UIImage) -> UIImage {
    
    return image
}



