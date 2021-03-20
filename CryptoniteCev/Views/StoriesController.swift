//
//  storiesController.swift
//  CryptoniteCev
//
//  Created by user177260 on 1/24/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import Charts
import SkeletonView

class StoriesController: UIViewController, ChartViewDelegate, SkeletonTableViewDataSource, UITableViewDelegate {
    
    
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
    var onDoneBlock : (() -> Void)?
    let anim = SkeletonableAnim()
    @IBOutlet weak var unfollowButton: UIButton!
    
    var pieChart = PieChartView()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    
    let roundingPair = ["DogeCoin", "Tether"]

    var roundingQuantity: Double = 100000
    
    /**
     Al iniciarse el view realiza las peticiones de recoger porcentages, rellenar los followings para comprobar si el user logged sigue a este user, se pone la estetica del table view y del boton de unfollow
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        getPercentages()
        fillFollowings()
        pieChart.drawEntryLabelsEnabled = false
        unfollowButton.layer.cornerRadius = 15
        
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
       
        imageView.layer.borderColor = #colorLiteral(red: 0.0733634308, green: 0.1234697327, blue: 0.2026597559, alpha: 1)
        imageView.layer.borderWidth = 3
        
        tableView.rowHeight = 68
        tableView.estimatedRowHeight = 68

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        anim.placeholder(view: nameLabel)
        anim.placeholder(view: usernameLabel)
        anim.placeholder(view: tableView)
        
    }
    
    //antes de desaparecer la vista se llama al closure onDoneBlock para actulizar las stories al volver a main, esto se hace para comprobar si se ha followeado o unfolloweado a la persona
    override func viewWillDisappear(_ animated: Bool) {
        onDoneBlock!()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    /**
     Coloca los labels e imagenes en base a lo recibido en la petición de trades
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell") as! OtherUserCell
        if trades.count > 0{
            cell.profile.image = storieImage
            cell.profile.layer.cornerRadius = cell.profile.bounds.size.width / 2
            roundingQuantity = setRounding(symbol: trades[indexPath.row].coinTo)
            cell.converted.text = currencyFormatter(numberToFormat: round(roundingQuantity * trades[indexPath.row].converted) / roundingQuantity)
            roundingQuantity = setRounding(symbol: trades[indexPath.row].coinFrom)
            cell.quantity.text = currencyFormatter(numberToFormat: round(roundingQuantity * trades[indexPath.row].quantity) / roundingQuantity)
            cell.symbol_from.image = Images.shared.coins[trades[indexPath.row].coinFrom]
            cell.symbol_to.image = Images.shared.coins[trades[indexPath.row].coinTo]
        }
            return cell
       
    }

    //imprime el piechart con los porcentages recogidos
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(pieChart: pieChart, screen: container, percentages: percentages)
            
    }
    //al aparecer el view se llama a trades y se guarda en la variable
    override func viewDidAppear(_ animated: Bool) {
        trades = getTrades()
    }
    
    //Botón de follow llama a peticion follow o unfollow dependiendo del estado
    @IBAction func followUserButton(_ sender: Any) {
        
        if(!following){
            unfollowButton.isEnabled = false
            followSomeone()
        }else{
            unfollowButton.isEnabled = false
            unfollowSomeone()
        }
        
    }
    
    /**
     Petición que recoge tradeos e información del user
     */
    func getTrades() -> [TradesProfile]{
    
        trades = []
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let parameters = ["username":username!]
                
                let requestTrades = Service.shared.getProfileTradesInfo(parameters: parameters)
                
                requestTrades.responseJSON { (response) in
                    
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [String:Any]{
                        
                                let tradeHistory = data["Trades"] as! [[String:Any]]
                                let user = data["User"] as! [String:Any]

                                self.nameLabel.text = user["Name"] as? String
                                self.usernameLabel.text = "@" + (user["Username"] as! String)
                                self.imageView.image = Images.shared.users[user["Profile_pic"] as! Int]
                                self.anim.hidePlaceholder(view: self.usernameLabel)
                                self.anim.hidePlaceholder(view: self.nameLabel)
                                    for i in 0..<tradeHistory.count {
                                        
                                        self.trades.append(TradesProfile(coinFrom: (tradeHistory[i]["Coin_from"] as? String)!, coinTo: (tradeHistory[i]["Coin_to"] as? String)!, coinFromSymbol: (tradeHistory[i]["Coin_from_symbol"] as? String)!, coinToSymbol: (tradeHistory[i]["Coin_to_symbol"] as? String)!, quantity: (tradeHistory[i]["Quantity"] as? Double)!, converted: (tradeHistory[i]["Converted"] as? Double)!))
                                    }
                            }
                        
                            self.tableView.reloadData()
                            self.anim.hidePlaceholder(view: self.tableView)
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                        
                    }
                }
            }
        }
        return trades;
    }
    
    //Petición que ecoge los porcentajes que se mostrarán en el piechart
    func getPercentages(){
       
           if isConnected {
               if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let parameters = ["username":username!]
                   let request = Service.shared.getPercentages(parameters: parameters)
                   request.responseJSON { (response) in
                       if let body = response.value as? [String:Any] {
                           if(response.response?.statusCode == StatusCodes.shared.OK){
                                attemptsMaxed = false
                                if let data = body["data"] as? [String:Any]{
                                    let wallets = data["Wallets"] as! [[String:Any]]
                                    for i in 0..<wallets.count{
                                        self.percentages[wallets[i]["Symbol"] as! String] = wallets[i]["Percentage"] as? Double
                                    }
                               }
                           }else{
                                attemptsMaxed = true
                                if !unknownBanner.isDisplaying{
                                    unknownBanner.show()
                                }
                            }
                        }
                   }
               }
           }
       }
    
    //devuelve identifier del collection view
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
            
            return "otherCell"
            
        }
    //Petición de hacer follow
    func followSomeone(){
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
             let parameters = ["username":username!]
                let request = Service.shared.followUser(params: parameters)
                request.responseJSON { (response) in
                 
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? String{
                                self.following=true
                                self.unfollowButton.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                                self.unfollowButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                                self.unfollowButton.setTitle("Unfollow", for: .normal)
                                isMissionFinished(parameters: ["id":"5"])
                                var numberOfFollows = UserDefaults.standard.integer(forKey: "numberOfFollows")
                                numberOfFollows += 1
                                UserDefaults.standard.set(numberOfFollows, forKey: "numberOfFollows")
                                self.unfollowButton.isEnabled = true
                                if (UserDefaults.standard.integer(forKey: "numberOfFollows") >= 2){
                                    isMissionFinished(parameters: ["id":"9"])
                                }
                            }
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
        
    }
    //recoger las personas que sigue el user logged
    func fillFollowings(){
        followings = []

        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getFollowings()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [[String:Any]]{
                                 for i in 0..<data.count{
                                    self.followings.append(data[i]["username"] as! String)
                                 }
                                self.setProperButton()
                            }
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //Pondrá el boton de follow de la manera correcta dependiendo del estado
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
    
    //Petición de hacer unfollow
    func unfollowSomeone(){
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
             let parameters = ["username":username!]
                let request = Service.shared.stopFollowing(params: parameters)
                request.responseJSON { (response) in
                 
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let message = body["message"] as? String{
                                self.following=false
                                self.unfollowButton.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                                self.unfollowButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1), for: .normal)
                                self.unfollowButton.setTitle("Follow", for: .normal)
                                self.unfollowButton.isEnabled = true
                                
                            }
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
        
    }

}
