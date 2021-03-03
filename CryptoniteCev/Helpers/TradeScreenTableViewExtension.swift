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
    Trade(idCoin: "BTC", date: "02-07-2015", quantity: 5, price: 500, isSell: 1),
    Trade(idCoin: "DOGE", date: "02-07-2015", quantity: 44, price: 500, isSell: 0),
    Trade(idCoin: "ETH", date: "02-07-2015", quantity: 57, price: 500, isSell: 0),
    Trade(idCoin: "BTC", date: "02-07-2015", quantity: 25, price: 500, isSell: 0),
    Trade(idCoin: "LITE", date: "02-07-2015", quantity: 99, price: 500, isSell: 1),
    Trade(idCoin: "SFP", date: "02-07-2015", quantity: 77, price: 500, isSell: 1)
]

extension TradingController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tradesFeed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trades") as! TradesRow
        cell.buyOrSellImage.image = #imageLiteral(resourceName: "buy")
        cell.coinLabel.text = tradesFeed[indexPath.row].coin
        cell.tradeDateLabel.text = tradesFeed[indexPath.row].date
        cell.amountLabel.text = String(tradesFeed[indexPath.row].quantity)
        cell.priceLabel.text = String(tradesFeed[indexPath.row].price)
        
        return cell
    }
}
