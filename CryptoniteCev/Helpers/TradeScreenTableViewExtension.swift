//
//  TradeScreenTableViewExtension.swift
//  CryptoniteCev
//
//  Created by alumnos on 03/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import UIKit

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
            roundingQuantity = setRounding(symbol: trades[indexPath.row].coin)
            cell.amountLabel.text = currencyFormatter(numberToFormat: round(roundingQuantity * trades[indexPath.row].quantity) / roundingQuantity)
            cell.priceLabel.text = currencyFormatter(numberToFormat: trades[indexPath.row].price)
        }
        return cell
    }
}
