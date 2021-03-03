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
    
    
    var storieImage : UIImage?
    var trades = [
        Trade(profilePic: #imageLiteral(resourceName: "doge"),username: "@marxtodon",price: 1, currencyIcon: #imageLiteral(resourceName: "LITE"), quantity: 0.002),
        Trade(profilePic: #imageLiteral(resourceName: "doge"),username: "@marxtodon",price: 41, currencyIcon: #imageLiteral(resourceName: "doge"), quantity: 0.0062),
        Trade(profilePic: #imageLiteral(resourceName: "doge"),username: "@marxtodon",price: 11, currencyIcon: #imageLiteral(resourceName: "Bitcoin"), quantity: 0.0021),
        Trade(profilePic: #imageLiteral(resourceName: "doge"),username: "@marxtodon",price: 18, currencyIcon: #imageLiteral(resourceName: "eth"), quantity: 0.022)
    ]
    var graph = PieChart()
    
    @IBOutlet weak var unfollowButton: UIButton!
    
    var lineChart = LineChartView()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unfollowButton.layer.cornerRadius = 15
        /*unfollowButton.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        unfollowButton.layer.borderWidth = 3*/
        
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2
       
        imageView.layer.borderColor = #colorLiteral(red: 0.0733634308, green: 0.1234697327, blue: 0.2026597559, alpha: 1)
        imageView.layer.borderWidth = 3

        tableView.delegate = self
        tableView.dataSource = self

        if storieImage != nil {
            imageView.image = storieImage
            imageView.contentMode = .scaleAspectFill
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell") as! OtherUserCell
       
        cell.profile.image = storieImage
        cell.profile.layer.cornerRadius = cell.profile.bounds.size.width / 2
        print("Username",trades[indexPath.row].username)
        cell.username.text = String(trades[indexPath.row].username)
        cell.price.text = String(trades[indexPath.row].price) + "$"
        cell.quantity.text = String(trades[indexPath.row].quantity)
        cell.currencyIcon.image = trades[indexPath.row].currencyIcon

        /*cell.currency.text = wa
         llet[indexPath.row].coins
        cell.simbol.text = wallet[indexPath.row].simbol
        cell.icon.image = wallet[indexPath.row].icons
        cell.dolars.text = String(wallet[indexPath.row].dollars)
        cell.currencyValor.text = String(wallet[indexPath.row].quantities)*/
           return cell
       
    }

    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(lineChart: lineChart, screen: container)
            
    }


}
