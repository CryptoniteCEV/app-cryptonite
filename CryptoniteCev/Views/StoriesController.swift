//
//  storiesController.swift
//  CryptoniteCev
//
//  Created by user177260 on 1/24/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import Charts

class StoriesController: UIViewController, ChartViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var storieImage : UIImage?
    var username : String?
    var trades:[TradesProfile] = []
    var wallets:[CoinsQuantities] = []
    var cash:Double = 0
    var percentages:[String:Double] = [:]
    var followings:[String] = []
    var following:Bool = false
    var graph = PieChart()
    
    @IBOutlet weak var unfollowButton: UIButton!
    
    var pieChart = PieChartView()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPercentages()
        fillFollowings()
        
        unfollowButton.layer.cornerRadius = 15
        //unfollowButton.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        //unfollowButton.layer.borderWidth = 3
        
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
       
        imageView.layer.borderColor = #colorLiteral(red: 0.0733634308, green: 0.1234697327, blue: 0.2026597559, alpha: 1)
        imageView.layer.borderWidth = 3

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell") as! OtherUserCell
        if trades.count > 0{
            cell.profile.image = storieImage
            cell.profile.layer.cornerRadius = cell.profile.bounds.size.width / 2
            cell.username.text = "@alex"
            cell.converted.text = String(trades[indexPath.row].converted)
            cell.quantity.text = String(trades[indexPath.row].quantity)
            cell.symbol_from.image = Images.shared.coins[trades[indexPath.row].coinFrom]
            cell.symbol_to.image = Images.shared.coins[trades[indexPath.row].coinTo]
        }
            return cell
       
    }

    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(pieChart: pieChart, screen: container, percentages: percentages)
            
    }
    override func viewDidAppear(_ animated: Bool) {
        trades = getTrades()
    }
    
    
    @IBAction func followUserButton(_ sender: Any) {
        
        if(!following){
            followSomeone()
        }else{
            unfollowSomeone()
        }
        
    }
    
    func getTrades() -> [TradesProfile]{
    
        trades = []
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let parameters = ["username":username!]
                
                let requestTrades = Service.shared.getProfileTradesInfo(parameters: parameters)
                
                requestTrades.responseJSON { (response) in
                    
                    if let body = response.value as? [String:Any] {
                    
                        if let data = body["data"] as? [String:Any]{
                    
                            let tradeHistory = data["Trades"] as! [[String:Any]]
                            let user = data["User"] as! [String:Any]

                            self.nameLabel.text = user["Name"] as? String
                            self.usernameLabel.text = "@" + (user["Username"] as! String)
                            self.imageView.image = Images.shared.users[user["Profile_pic"] as! Int]
                            
                                for i in 0..<tradeHistory.count {
                                    self.trades.append(TradesProfile(coinFrom: (tradeHistory[i]["Coin_from"] as? String)!, coinTo: (tradeHistory[i]["Coin_to"] as? String)!, coinFromSymbol: (tradeHistory[i]["Coin_from_symbol"] as? String)!, coinToSymbol: (tradeHistory[i]["Coin_to_symbol"] as? String)!, quantity: (tradeHistory[i]["Quantity"] as? Double)!, converted: (tradeHistory[i]["Converted"] as? Double)!))
                                }
                        }
                        
                    self.tableView.reloadData()
                        
                    }
                }
            }
        }
        return trades;
    }
    
    func getPercentages(){
       
           if Service.isConnectedToInternet {
               if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let parameters = ["username":username!]
                   let request = Service.shared.getPercentages(parameters: parameters)
                   request.responseJSON { (response) in
                    
                       if let body = response.value as? [String:Any] {
                       
                           if let data = body["data"] as? [String:Any]{
                                let wallets = data["Wallets"] as! [[String:Any]]
                                for i in 0..<wallets.count{
                                    self.percentages[wallets[i]["Symbol"] as! String] = wallets[i]["Percentage"] as? Double
                                }
                           }
                       }
                   }
               }
           }
       }
    
    func followSomeone(){
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
             let parameters = ["username":username!]
                let request = Service.shared.followUser(params: parameters)
                request.responseJSON { (response) in
                 
                    if let body = response.value as? [String:Any] {
                    
                        if let data = body["data"] as? String{
                            self.following=true
                            self.unfollowButton.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                            self.unfollowButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                            self.unfollowButton.setTitle("Unfollow", for: .normal)
                        }
                    }
                }
            }
        }
        
    }
    
    func fillFollowings(){
        followings = []

        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getFollowings()
                request.responseJSON { (response) in
                 
                    if let body = response.value as? [String:Any] {
                        if let data = body["data"] as? [[String:Any]]{
                            
                             for i in 0..<data.count{
                                self.followings.append(data[i]["username"] as! String)
                               
                             }
                            self.setProperButton()
                        }
                    }
                }
            }
        }
    }
    
    func setProperButton(){
     
        if !self.followings.contains(self.username!){
            self.following = false
            self.unfollowButton.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            self.unfollowButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1), for: .normal)
            self.unfollowButton.setTitle("Follow", for: .normal)
        }else{
            self.following = true
            self.unfollowButton.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
            self.unfollowButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            self.unfollowButton.setTitle("Unfollow", for: .normal)
        }
        
    }
    
    func unfollowSomeone(){
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
             let parameters = ["username":username!]
                let request = Service.shared.stopFollowing(params: parameters)
                request.responseJSON { (response) in
                 
                    if let body = response.value as? [String:Any] {
                    
                        if let message = body["message"] as? String{
                            print(message)
                            self.following=false
                            self.unfollowButton.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                            self.unfollowButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1), for: .normal)
                            self.unfollowButton.setTitle("Follow", for: .normal)
                            
                        }
                    }
                }
            }
        }
        
    }

}
