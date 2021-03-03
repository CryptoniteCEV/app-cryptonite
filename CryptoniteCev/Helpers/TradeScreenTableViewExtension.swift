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
    Trade(coin: "BTC", date: "02-07-2015", quantity: 5, price: 500, isSell: 1),
    Trade(coin: "DOGE", date: "02-12-2019", quantity: 44, price: 500, isSell: 0),
    Trade(coin: "ETH", date: "02-07-2015", quantity: 57, price: 500, isSell: 0),
    Trade(coin: "BTC", date: "02-07-2015", quantity: 25, price: 500, isSell: 1),
    Trade(coin: "LITE", date: "02-07-2015", quantity: 99, price: 500, isSell: 0),
    Trade(coin: "SFP", date: "02-07-2015", quantity: 77, price: 500, isSell: 1)
]

extension TradingController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tradesFeed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trades") as! TradesRow
        if tradesFeed[indexPath.row].isSell == 0 {
            cell.buyOrSellImage.image = #imageLiteral(resourceName: "buy")
        }else{
            cell.buyOrSellImage.image = #imageLiteral(resourceName: "sell")
        }
        cell.coinLabel.text = tradesFeed[indexPath.row].coin + "/USD"
        cell.tradeDateLabel.text = tradesFeed[indexPath.row].date
        cell.amountLabel.text = String(tradesFeed[indexPath.row].quantity)
        cell.priceLabel.text = String(tradesFeed[indexPath.row].price)
        
        return cell
    }
}
