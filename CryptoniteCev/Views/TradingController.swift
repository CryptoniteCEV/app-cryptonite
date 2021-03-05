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

    @IBOutlet weak var amountValue: UISlider!
    
    @IBOutlet weak var curentPrice: UILabel!
    @IBOutlet weak var tradeTableView: UITableView!
    
    @IBOutlet weak var coinDropdown: DropDown!

    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var sellButton: UIButton!
    
    @IBOutlet var buyOrSellButton: UIButton!
    
    @IBOutlet var amountTextfield: UITextField!
    
    var trades:[Trade] = []
    var coins:[Coin] = []
    var wallets:[CoinsQuantities] = []
    var selected = 0
    
    var isSell = 0
    var tradeType = "Buy "
    
    @IBAction func buySelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        sellButton.alpha = 0.4
        sellButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        buyOrSellButton.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        buyOrSellButton.setTitle("Buy " + coinDropdown.optionArray[coinDropdown.selectedIndex!], for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        isSell = 0
        amountValue.value = 0
        amountTextfield.text = "0"
        if wallets.count > 0{
            amountValue.maximumValue = Float(self.wallets[0].inDollars)
        }
    }
    
    @IBAction func tradeButton(_ sender: UIButton) {
        
        if(amountValue.value > 0){
            //buyOrSellButton.isEnabled = false
            newTrade(is_sell: isSell, quantity: Double(amountValue.value), coin: coinDropdown.optionArray[selected])
            amountValue.value = 0
            amountTextfield.text = "0"
        }
    }
    
    @IBAction func sellSelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        buyButton.alpha = 0.4
        buyButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyOrSellButton.setTitle("Sell " + coinDropdown.optionArray[coinDropdown.selectedIndex!], for: .normal)
        buyOrSellButton.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        isSell = 1
        amountValue.value = 0
        amountTextfield.text = "0"
        if let price = inWallet(coin: coinDropdown.optionArray[selected]){
            self.amountValue.maximumValue = Float(price)
        }
        
    }
    
    @IBAction func amountSlider(_ sender: UISlider) {
        amountTextfield.text = sender.value.description
    }
    
    @IBAction func coinSelected(_ sender: DropDown) {
        coinDropdown.didSelect{(selectedText , index ,id) in
            self.selected = index
            self.amountValue.value = 0
            self.amountTextfield.text = "0"
            if self.isSell == 1 {
                self.tradeType = "Sell "
                if let price = self.inWallet(coin: self.coinDropdown.optionArray[self.selected]){
                    
                    self.amountValue.maximumValue = Float(price)
                }
            }else{
                self.tradeType = "Buy "
                if self.wallets.count > 0{
                    self.amountValue.maximumValue = Float(self.wallets[0].inDollars)
                }
            }
            if self.coins.count > 0{
                self.curentPrice.text = String(self.coins[index].price) + "$"
            }
            self.buyOrSellButton.setTitle(self.tradeType + self.coinDropdown.optionArray[index], for: .normal)
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        setWallet()
        trades = getTrades()
        coins = getCoins()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
        
        amountValue.maximumValue = 0
        amountTextfield.text = "0"
        coinDropdown.optionArray = ["BTC", "ETH", "DOGE", "LTC"]
        coinDropdown.selectedIndex = 0
        coinDropdown.text = coinDropdown.optionArray[coinDropdown.selectedIndex!]
        buyOrSellButton.setTitle("Buy " + coinDropdown.optionArray[coinDropdown.selectedIndex!], for: .normal)
        
    }
    
    func getCoins()->[Coin]{
        coins = []
        if Service.isConnectedToInternet {
                if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                   let requestCoins = Service.shared.getCoins()
                   
                   requestCoins.responseJSON { (response) in
                       
                       if let body = response.value as? [String: Any]{
                           let data = body["data"] as! [[String:Any]]
                           
                           for i in 1..<data.count {
                               self.coins.append(Coin(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, price: (data[i]["Price"] as? Double)!))
                           }
                        self.curentPrice.text = String(self.coins[self.coinDropdown.selectedIndex!].price) + "$"
                   }
                }
            }
        }
        return coins
    }
    
    func getTrades() -> [Trade]{
        trades = []
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let requestTrades = Service.shared.getTradesInfo()
                
                requestTrades.responseJSON { (response) in
                    
                    if let body = response.value as? [String:Any] {
                    
                        if let data = body["data"] as? [[String:Any]]{
        
                            for i in 0..<data.count {
                                self.trades.append(Trade(coin: (data[i]["Coin"] as? String)!, date: (data[i]["Date"] as? UInt64)!, quantity: (data[i]["Quantity"] as? Double)!, price: (data[i]["Price"] as? Double)!, isSell: (data[i]["Is_sell"] as? Int)!))
                            }
                        }
                        
                        self.tradeTableView.reloadData()
                    }
                }
            }
        }
        
        return trades;
    }
    
    func newTrade(is_sell:Int, quantity:Double, coin:String) {
        
        if Service.isConnectedToInternet {
            
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let parameters:[String:String] = [
                    "is_sell":String(is_sell),
                    "quantity":String(quantity),
                    "coin":coin
                ]
                
                let requestTrades = Service.shared.newTrade(parameters: parameters)
            
                requestTrades.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        print(body["message"]!)
                        
                        self.setWallet()
                        self.trades = self.getTrades()
                        self.tradeTableView.reloadData()
                        //self.buyOrSellButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    func setWallet(){
        wallets = []
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getCoinsWithQuantities()
                request.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        let data = body["data"]! as! [[String:Any]]
                   
                        for i in 0..<data.count {
                            self.wallets.append(CoinsQuantities(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, quantity: (data[i]["Quantity"] as? Double)!, inDollars: (data[i]["inDollars"] as? Double)!))
                        }
                        if self.isSell == 0{
                            self.amountValue.maximumValue = Float(self.wallets[0].inDollars)
                            print("entrando")
                        }else{
                            if let price = self.inWallet(coin: self.coinDropdown.optionArray[self.selected]){
                            self.amountValue.maximumValue = Float(price)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func inWallet(coin: String) -> Double?
    {
        for wallet in wallets {
            if coin == wallet.symbol {
                return wallet.quantity
            }
        }

        return nil
    }
    
}

