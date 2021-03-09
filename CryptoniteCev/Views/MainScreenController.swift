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
    var trades:[TradeHistory] = []
    var coinImages:[UIImage] = []
    
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
        
        for (_, value) in Images.shared.coins {
            coinImages.append(value)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        //navigationController?.setNavigationBarHidden(true, animated: true)
        
        coins = []
        trades = []
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let requestCoins = Service.shared.getCoins()
                
                requestCoins.responseJSON { (response) in
                    
                    if let body = response.value as? [String: Any]{
                        let data = body["data"] as! [[String:Any]]
                        
                        for i in 0..<data.count {
                            self.coins.append(Coin(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, price: (data[i]["Price"] as? Double)!))
                        }
                        
                        self.coinCollectionView.reloadData()
                    }
                }
                
                let requestTrades = Service.shared.getTradingHistory()
                
                requestTrades.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        let data = body["data"]! as! [[String:Any]]
                        
                        for i in 0..<data.count {
                            self.trades.append(TradeHistory(coinFrom: (data[i]["Coin_from"] as? String)!, coinTo: (data[i]["Coin_to"] as? String)!,coinFromSymbol: (data[i]["Coin_from_symbol"] as? String)! , coinToSymbol: (data[i]["Coin_to_symbol"] as? String)!, quantity: (data[i]["Quantity"] as? Double)!, username: (data[i]["Username"] as? String)!, converted: (data[i]["Converted"] as? Double)!))
                        }
                        
                    self.activityTableView.reloadData()
                        
                    }
                }
            }
        }else {//cuando no hay conexion: PlaceHolders
            
           
            	
            
        }
    }
}
    

func getImages(image: UIImage) -> UIImage {
    
    return image
}



