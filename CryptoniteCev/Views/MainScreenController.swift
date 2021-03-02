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
    
    var coins:[Coin] = []
    
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
        
        let request = Service.shared.getCoins()
        
        request.responseJSON { (response) in
        let body = response.value as? [String: Any]
        let data = body!["data"]! as! [[String:Any]]
        
        for i in 0..<data.count {
            self.coins.append(Coin(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, price: (data[i]["Price"] as? Double)!))
        }
            self.coinCollectionView.reloadData()
        }
        
        
    }
}
    

func getImages(image: UIImage) -> UIImage {
    
    return image
}



