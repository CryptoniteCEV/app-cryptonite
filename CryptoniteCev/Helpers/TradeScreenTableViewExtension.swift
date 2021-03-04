//
//  TradeScreenTableViewExtension.swift
//  CryptoniteCev
//
//  Created by alumnos on 03/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import UIKit

var tradesFeed = [
    Trade(coin: "BTC", date: 1614810279, quantity: 5, price: 500, isSell: 1),
    Trade(coin: "DOGE", date: 1614810279, quantity: 44, price: 500, isSell: 0),
    Trade(coin: "ETH", date: 1614810279, quantity: 57, price: 500, isSell: 0),
    Trade(coin: "BTC", date: 1614810279, quantity: 25, price: 500, isSell: 1),
    Trade(coin: "LITE", date: 1614810279, quantity: 99, price: 500, isSell: 0),
    Trade(coin: "SFP", date: 1614810279, quantity: 77, price: 500, isSell: 1)
]

extension TradingController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trades") as! TradesRow
        if trades.count > 0 {
            if trades[indexPath.row].isSell == 0 {
                cell.buyOrSellImage.image = #imageLiteral(resourceName: "buy")
            }else{
                cell.buyOrSellImage.image = #imageLiteral(resourceName: "sell")
            }
            cell.coinLabel.text = trades[indexPath.row].coin + "/USD"
            cell.tradeDateLabel.text = String(trades[indexPath.row].date)
            cell.amountLabel.text = String(trades[indexPath.row].quantity)
            cell.priceLabel.text = String(trades[indexPath.row].price)
        }
        return cell
    }
}
