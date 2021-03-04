//
//  TradingController.swift
//  CryptoniteCev
//
//  Created by user177260 on 3/1/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import iOSDropDown

class TradingController: UIViewController {

   
    @IBOutlet weak var tradeTableView: UITableView!
    
    @IBOutlet weak var coinDropdown: DropDown!
    
    @IBOutlet weak var coinDropdownTextfield: UITextField!
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var sellButton: UIButton!
    
    @IBOutlet var buyOrSellButton: UIButton!
    
    @IBOutlet var amountTextfield: UITextField!
    
    var trades:[Trade]=[]
    
    var isSell = false
    
    var tradeType = "Buy "
    
    @IBAction func buySelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        sellButton.alpha = 0.4
        sellButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        buyOrSellButton.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        buyOrSellButton.setTitle("Buy " + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        isSell = false
    }
    
    
    @IBAction func sellSelected(_ sender: UIButton) {
        sender.backgroundColor = UIColor.systemRed
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        buyButton.alpha = 0.4
        buyButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyOrSellButton.backgroundColor = UIColor.systemRed
        buyOrSellButton.setTitle("Sell " + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        isSell = true
    }
    
    @IBAction func amountSlider(_ sender: UISlider) {
        amountTextfield.text = sender.value.description
    }
    
    @IBAction func coinSelected(_ sender: DropDown) {
        if isSell {
            tradeType = "Sell "
        }
        buyOrSellButton.setTitle(tradeType + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
    }
    override func viewDidAppear(_ animated: Bool) {
        trades = getTrades()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
        tradeTableView.reloadData()
        
        coinDropdown.optionArray = ["BTC/USD", "ETH/USD", "DOGE/USD", "LITE/USD", "SFP/USD"]
        coinDropdown.selectedIndex = 0
        coinDropdownTextfield.text = coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0]
        buyOrSellButton.setTitle("Buy " + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
        
        }
    
    func getTrades() -> [Trade]{
        trades = []
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let requestTrades = Service.shared.getTradesInfo()
                
                requestTrades.responseJSON { (response) in
                    
                    if let body = response.value as? [String:Any] {
                    
                    let data = body["data"] as! [[String:Any]]
        
                        for i in 0..<data.count {
                            self.trades.append(Trade(coin: (data[i]["Coin"] as? String)!, date: (data[i]["Date"] as? UInt64)!, quantity: (data[i]["Quantity"] as? Double)!, price: (data[i]["Price"] as? Double)!, isSell: (data[i]["Is_sell"] as? Int)!))
                        }
                        
                    self.tradeTableView.reloadData()
                        
                    }
                }
            }
        }
        return trades;
    }
    
    /*func getTrades() -> [Trade]{
        
        trades = []
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let requestTrades = Service.shared.getTradesInfo()
                
                requestTrades.responseJSON { (response) in
                    
                    if let body = response.value as? [String:Any] {
                    
                    let data = body["data"] as! [String:Any]
                    
                    let tradeHistory = data["Trades"] as! [[String:Any]]
                       print(tradeHistory)
                        for i in 0..<tradeHistory.count {
                            self.trades.append(Trade(coin: (tradeHistory[i]["Coin"] as? String)!, date: (tradeHistory[i]["Date"] as? UInt64)!, quantity: (tradeHistory[i]["Quantity"] as? Double)!, price: (tradeHistory[i]["Price"] as? Double)!, isSell: (tradeHistory[i]["Is_sell"] as? Int)!))
                        }
                        
                    self.tradeTableView.reloadData()
                        
                    }
                }
            }
        }
        return trades;
        }*/
    
}

