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
    var coinForSC:String?
    var cryptoPos = 0
    var dollarPos = 0
    var isSell = 0
    var tradeType = "Buy "
    
    @IBAction func tradeButton(_ sender: UIButton) {
        
        if(amountValue.value > 0){
            let quantityWithFee = applyFee(quantity: Double(amountValue.value))
            newTrade(is_sell: isSell, quantity: quantityWithFee, coin: coinsSC.titleForSegment(at: cryptoPos)!)
            amountValue.value = 0
            amountTextfield.text = "0"
            buyOrSellButton.isEnabled = false
            setProperButtonBuySellColor()
        }
        
        if(wallets.count>0){
            if buySellSC.selectedSegmentIndex == 0{
                amountValue.maximumValue = Float(self.wallets[dollarPos].inDollars)
            }else{
                amountValue.maximumValue = Float(self.wallets[cryptoPos+1].quantity)
            }
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
        
        if coinForSC != nil {
            coinsSC.selectedSegmentIndex = getPositionInSGFromName()
            self.cryptoPos = coinsSC.selectedSegmentIndex
            if coins.count > 0{
                curentPrice.text = currencyFormatter(numberToFormat: self.coins[self.cryptoPos].price) + "$"
            }else{
                curentPrice.text = "N/A"
            }
            buyOrSellButton.setTitle(self.tradeType + coinsSC.titleForSegment(at: cryptoPos)!, for: .normal)
        }
        
    }
    
    @IBAction func onSelectAmountField(_ sender: Any) {
        
        if (amountTextfield.text! as NSString).floatValue > amountValue.maximumValue{
            amountTextfield.text = String(amountValue.maximumValue)
        }
        setProperButtonBuySellColor()
    }
    
    @IBAction func onTextFieldValueChanged(_ sender: UITextField) {
        
        if(sender.text == ""){
            amountValue.value = 0
        }else{
            amountValue.value = (sender.text! as NSString).floatValue
            if (amountTextfield.text! as NSString).floatValue > amountValue.maximumValue{
                amountTextfield.text = String(amountValue.maximumValue)
            }
            
        }
        setProperButtonBuySellColor()
        
    }
    
    
    @IBAction func onSelectCoin(_ sender: Any) {
        cryptoPos = coinsSC.selectedSegmentIndex
        if(coins.count>0){
            curentPrice.text = currencyFormatter(numberToFormat: self.coins[self.cryptoPos].price) + "$"
        }else{
            curentPrice.text = "N/A"
        }
        amountValue.value = 0
        amountTextfield.text = "0"
        if(wallets.count>0){
            if buySellSC.selectedSegmentIndex == 0{
                amountValue.maximumValue = Float(self.wallets[dollarPos].inDollars)
            }else{
                amountValue.maximumValue = Float(self.wallets[cryptoPos+1].quantity)
            }
        }
        
        setProperButtonBuySellColor()
    }
    
    @IBAction func onSelectBuySell(_ sender: Any) {
        amountValue.maximumValue = 0
        
        if buySellSC.selectedSegmentIndex == 0{
            isSell = 0
            self.tradeType = "Buy "
            buySellSC.selectedSegmentTintColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            if(wallets.count>0){
                amountValue.maximumValue = Float(self.wallets[dollarPos].inDollars)
            }
        }else{
            isSell=1
            self.tradeType = "Sell "
            buySellSC.selectedSegmentTintColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                if(wallets.count>0){
                amountValue.maximumValue = Float(self.wallets[cryptoPos+1].quantity)
            }
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
                               self.coins.append(Coin(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, price: (data[i]["Price"] as? Double)!, change: (data[i]["Change"] as? Double)!))
                           }
                        self.curentPrice.text = currencyFormatter(numberToFormat: self.coins[self.cryptoPos].price) + "$"
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
                                
                                
                                self.trades.append(Trade(coin: (data[i]["Coin"] as? String)!, date: self.timestampToDate(date: data[i]["Date"] as! Double), quantity: (data[i]["Quantity"] as? Double)!, price: (data[i]["Price"] as? Double)!, isSell: (data[i]["Is_sell"] as? Int)!))
                            }
                        }
                        
                        self.tradeTableView.reloadData()
                    }
                }
            }
        }
        
        return trades;
    }
    
    func newTrade(is_sell:Int, quantity: Double, coin:String) {
        
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
                        
                        Banners.shared.successBanner(title: body["message"]! as! String, subtitle: "")
                        self.setWallet()
                        isMissionFinished(parameters: ["id":"4"])
                        self.trades = self.getTrades()
                        if(self.coinsSC.titleForSegment(at: self.cryptoPos) == "DOGE"){
                            isMissionFinished(parameters: ["id":"1"])
                        }
                        if(self.coinsSC.titleForSegment(at: self.cryptoPos) == "LTC" && self.isSell==1){
                            isMissionFinished(parameters: ["id":"6"])
                        }
                        
                        var numberOfFollows = UserDefaults.standard.integer(forKey: "numberOfFollows")
                        numberOfFollows += 1
                        UserDefaults.standard.set(numberOfFollows, forKey: "numberOfFollows")
                        
                        if (UserDefaults.standard.integer(forKey: "numberOfFollows") >= 3){
                            isMissionFinished(parameters: ["id":"10"])
                        }
                        
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
                let request = Service.shared.getWallets()
                request.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        if let data = body["data"]! as? [String:Any]{
                            let walletsReceived = data["Wallets"] as! [[String:Any]]
                   
                            for i in 0..<walletsReceived.count {
                                self.wallets.append(CoinsQuantities(name: (walletsReceived[i]["Name"] as? String)!, symbol: (walletsReceived[i]["Symbol"]! as? String)!, quantity: (walletsReceived[i]["Quantity"] as? Double)!, inDollars: (walletsReceived[i]["inDollars"] as? Double)!))
                            }
                            
                            if self.isSell == 0{
                                self.amountValue.maximumValue = Float(self.wallets[0].inDollars)
                            }else{
                                self.amountValue.maximumValue = Float(self.wallets[self.cryptoPos+1].quantity)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func getPositionInSGFromName()->Int{
        
        for i in 0..<coinsSC.numberOfSegments{
            
            if coinForSC == coinsSC.titleForSegment(at: i)!{
                return i
            }
        }
        return 0
    }
    
    func applyFee(quantity: Double) -> Double {
        
        let quantityWithFee = quantity - (quantity/100)
        return quantityWithFee
    }
    
    func timestampToDate(date: Double) -> String {
        let tradeDate = Date(timeIntervalSince1970: date )
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        return formatter1.string(from: tradeDate)
    }
    
}

