//
//  MainScreenController.swift
//  CryptoniteCev
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import SkeletonView

class MainScreenController: UIViewController {

    //var stories : UICollectionView?
    var storiesCollection: UICollectionView?
    var coinsCollection : UICollectionView?
    var usersCollection : UICollectionView?

    @IBOutlet weak var coinCollectionView: UICollectionView!
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    
    @IBOutlet weak var activityTableView: UITableView!
    
    var coins:[Coin] = []
    var trades:[TradeHistory] = []
    var users:[UserMain] = []
    var followings:[UserStories] = [UserStories(profilePic: Images.shared.users[0], username: "")]
    var coinImages:[UIImage] = []
    
    let experiencePerMission : Double = 200
    let anim = SkeletonableAnim()
    override func viewDidLoad() {
        
        view.overrideUserInterfaceStyle = .dark
        isMissionFinished(parameters: ["id":"13"])
        storiesCollectionView.dataSource = self
        storiesCollectionView.delegate = self
        
        coinCollectionView.dataSource = self
        coinCollectionView.delegate = self
        
        usersCollectionView.dataSource = self
        usersCollectionView.delegate = self
        
        activityTableView.dataSource = self
        activityTableView.delegate = self
        activityTableView.rowHeight = 68
        activityTableView.estimatedRowHeight = 68
        anim.placeholder(view: activityTableView)
        self.activityTableView.reloadData()
        
        for (_, value) in Images.shared.coins {
            coinImages.append(value)
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       fillFollowings()
        //navigationController?.setNavigationBarHidden(true, animated: true)
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let requestCoins = Service.shared.getCoins()
                
                requestCoins.responseJSON { (response) in
                    
                    if let body = response.value as? [String: Any]{
                        let data = body["data"] as! [[String:Any]]
                        self.coins = []
                        for i in 1..<data.count {
                            self.coins.append(Coin(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, price: (data[i]["Price"] as? Double)!, change: (data[i]["Change"] as? Double)!))
                        }
                        
                        self.coinCollectionView.reloadData()
                    }
                }
                
                let requestTrades = Service.shared.getTradingHistory()
                
                requestTrades.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        let data = body["data"]! as! [[String:Any]]
                        self.trades = []
                        for i in 0..<data.count {
                            self.trades.append(TradeHistory(coinFrom: (data[i]["Coin_from"] as? String)!, coinTo: (data[i]["Coin_to"] as? String)!,coinFromSymbol: (data[i]["Coin_from_symbol"] as? String)! , coinToSymbol: (data[i]["Coin_to_symbol"] as? String)!, quantity: (data[i]["Quantity"] as? Double)!, username: (data[i]["Username"] as? String)!, converted: (data[i]["Converted"] as? Double)!, profilePic: (data[i]["Profile_pic"] as? Int)!))
                        }
                    self.anim.hidePlaceholder(view: self.activityTableView)
                    self.activityTableView.reloadData()
                        
                    }
                }
                
                let requestUsers = Service.shared.getUsers()
                requestUsers.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        let data = body["data"]! as! [[String:Any]]
                        self.users = []
                        for i in 0..<data.count {
                            self.users.append(UserMain(profilePic: Images.shared.users[(data[i]["ProfilePic"] as? Int)!], username: (data[i]["Username"] as? String)!, experience: (data[i]["Exp"] as? Double)!))
                        }
                        self.usersCollectionView.reloadData()
                    }
                }
                
                
                
            }
        }else {//cuando no hay conexion: PlaceHolders
            
           
            	
            
        }
    }
    
    func fillFollowings(){
        followings = [UserStories(profilePic: Images.shared.users[0], username: "")]

        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getFollowings()
                request.responseJSON { (response) in
                 
                    if let body = response.value as? [String:Any] {
                        if let data = body["data"] as? [[String:Any]]{
                            
                             for i in 0..<data.count{
                                self.followings.append(UserStories(profilePic: Images.shared.users[data[i]["profile_pic"] as! Int], username: data[i]["username"] as! String))
                               
                             }
                            self.storiesCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
}



