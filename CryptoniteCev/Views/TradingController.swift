//
//  TradingController.swift
//  CryptoniteCev
//
//  Created by user177260 on 3/1/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

class TradingController: UIViewController {

    @IBOutlet weak var amountValue: UISlider!
    
    @IBOutlet weak var curentPrice: UILabel!
    @IBOutlet weak var tradeTableView: UITableView!

    @IBOutlet weak var coinsSC: UISegmentedControl!
    @IBOutlet weak var buySellSC: UISegmentedControl!
    
    @IBOutlet var buyOrSellButton: UIButton!
    
    @IBOutlet var amountTextfield: UITextField!
    
    var trades:[Trade] = []
    var coins:[Coin] = []
    var wallets:[CoinsQuantities] = []
    
    var cryptoPos = 0
    var dollarPos = 0
    var isSell = 0
    var tradeType = "Buy "
    
    @IBAction func tradeButton(_ sender: UIButton) {
        
        if(amountValue.value > 0){
            
            newTrade(is_sell: isSell, quantity: Double(amountValue.value), coin: coinsSC.titleForSegment(at: cryptoPos)!)
            amountValue.value = 0
            amountTextfield.text = "0"
            buyOrSellButton.isEnabled = false
            setProperButtonBuySellColor()
        }
        
    }
    
    
    @IBAction func amountSlider(_ sender: UISlider) {
        amountTextfield.text = sender.value.description
        setProperButtonBuySellColor()
        
        if amountTextfield.text == "0.0"{
            amountTextfield.text = "0"
        }
    }
    
    func setProperButtonBuySellColor(){
        if amountValue.value>0{
            buyOrSellButton.isEnabled = true
            if isSell == 0{
                buyOrSellButton.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                buyOrSellButton.setTitleColor(#colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1), for: .normal)
            }else{
                buyOrSellButton.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                buyOrSellButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            }
        }else{
            buyOrSellButton.isEnabled = false
            buyOrSellButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
            buyOrSellButton.setTitleColor(UIColor.lightGray, for: .normal)
        }
        
        if isSell == 0{
            buySellSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        }else{
            buySellSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        }
        buyOrSellButton.setTitle(self.tradeType + coinsSC.titleForSegment(at: cryptoPos)!, for: .normal)
        
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        setWallet()
        trades = getTrades()
        coins = getCoins()
        
    }
    
    @IBAction func onSelectAmountField(_ sender: Any) {
        
        if (amountTextfield.text! as NSString).floatValue > amountValue.maximumValue{
            amountTextfield.text = String(amountValue.maximumValue)
        }
        
    }
    
    @IBAction func onSelectCoin(_ sender: Any) {
        cryptoPos = coinsSC.selectedSegmentIndex
        curentPrice.text = String(self.coins[self.cryptoPos].price) + "$"
        amountValue.value = 0
        amountTextfield.text = "0"
        
        if buySellSC.selectedSegmentIndex == 0{
            amountValue.maximumValue = Float(self.wallets[dollarPos].inDollars)
        }else{
            amountValue.maximumValue = Float(self.wallets[cryptoPos+1].quantity)
        }
        
        setProperButtonBuySellColor()
    }
    
    @IBAction func onSelectBuySell(_ sender: Any) {
        amountValue.maximumValue = 0
        
        if buySellSC.selectedSegmentIndex == 0{
            isSell = 0
            self.tradeType = "Buy "
            buySellSC.selectedSegmentTintColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            amountValue.maximumValue = Float(self.wallets[dollarPos].inDollars)
            
        }else{
            isSell=1
            self.tradeType = "Sell "
            buySellSC.selectedSegmentTintColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
            amountValue.maximumValue = Float(self.wallets[cryptoPos+1].quantity)
            
        }
        
        setProperButtonBuySellColor()
        amountValue.value = 0
        amountTextfield.text = "0"
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
        
        buyOrSellButton.setTitle(self.tradeType + coinsSC.titleForSegment(at: cryptoPos)!, for: .normal)
        amountValue.maximumValue = 0
        amountTextfield.text = "0"
        coinsSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        buySellSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        
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
                        self.curentPrice.text = String(self.coins[self.cryptoPos].price) + "$"
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
                        }else{
                            self.amountValue.maximumValue = Float(self.wallets[self.cryptoPos+1].inDollars)
                        }
                    }
                }
            }
        }
        
    }
    
}

