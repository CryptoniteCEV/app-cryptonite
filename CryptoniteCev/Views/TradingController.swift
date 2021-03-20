//
//  TradingController.swift
//  CryptoniteCev
//
//  Created by user177260 on 3/1/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import SkeletonView

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
    let anim = SkeletonableAnim()
    
    //ibaction de tradeos, generara un nuevo tradeo en base a ciertos parametros y reiniciara los valores además de apaga el boton para que no ocurran errores
    @IBAction func tradeButton(_ sender: UIButton) {
        
        if(amountValue.value > 0){
            newTrade(is_sell: isSell, quantity: Double(amountValue.value), coin: coinsSC.titleForSegment(at: cryptoPos)!)
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
    
    //ibaction del slider, dependiendo de si es compra o venta y la posicion elegira unos decimales u otros ademas de modificar a 0 cuando ponga 0.0 en el textfield. Tambien pondrá el boton del color debido
    @IBAction func amountSlider(_ sender: UISlider) {
        var decimalQuantity = 0
        if isSell == 0 || cryptoPos == 2{
            decimalQuantity = 2
        }else{
            decimalQuantity = 7
        }
        
        amountTextfield.text = currencyFormatterFloat(numberToFormat: sender.value, decimalsQuantity: decimalQuantity)
        if(amountTextfield.text == "0.00" || amountTextfield.text == "0.0"){
            amountTextfield.text = "0"
        }
        
        setProperButtonBuySellColor()
        
        if amountTextfield.text == "0.0"{
            amountTextfield.text = "0"
        }
    }
    
    //funcion que se dedica a poner el color correcto del boton de buy/sell
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
    
    /*
      Al iniciarse el view se generan los wallets, la lista de tradeos y las monedas.
     El sc pondrá la posicion adecuada en base al nombre además de colocar el titulo del botón dependiendo de la moneda seleccionada
     */
    
    override func viewDidAppear(_ animated: Bool) {
        setWallet(fromTrades: false)
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
    
    //Al poner cantidad en el textfield pone la cantidad maxima si la cantidad introducida es mayor
    @IBAction func onSelectAmountField(_ sender: Any) {
        
        if (amountTextfield.text! as NSString).floatValue > amountValue.maximumValue{
            amountTextfield.text = String(amountValue.maximumValue)
        }
        setProperButtonBuySellColor()
    }
    
    //Al modificarse el textfield se comprueba la cantidad introducida para poner la maxima posible
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
    
    //Al seleccionar una moneda se modifica el label del precio, se guarda la posición y se modifica el max value del slider
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
    
    //Cambia el color y texto del boton buy/sell al cambiar el sc
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
    
    //Al cargar el view coloca el placeholder, activa el toggle del teclado, coloca el nombre de la moneda y si es compra/venta en el boton además de poner los textos de los sc en color negro
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        anim.placeholder(view: curentPrice)
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
        tradeTableView.rowHeight = 68
        tradeTableView.estimatedRowHeight = 68
        anim.self.placeholder(view: tradeTableView)
        buyOrSellButton.setTitle(self.tradeType + coinsSC.titleForSegment(at: cryptoPos)!, for: .normal)
        amountValue.maximumValue = 0
        amountTextfield.text = "0"
        coinsSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        buySellSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.selected)
        
    }
    
    //peticion que recoge las monedas y precios
    func getCoins()->[Coin]{
        coins = []
        if isConnected {
                if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                   let requestCoins = Service.shared.getCoins()
                   
                   requestCoins.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            let data = body["data"] as! [[String:Any]]
                               
                            for i in 1..<data.count {
                               self.coins.append(Coin(name: (data[i]["Name"] as? String)!, symbol: (data[i]["Symbol"]! as? String)!, price: (data[i]["Price"] as? Double)!, change: (data[i]["Change"] as? Double)!))
                            }
                            self.curentPrice.text = currencyFormatter(numberToFormat: self.coins[self.cryptoPos].price) + "$"
                            self.anim.hidePlaceholder(view: self.curentPrice)
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
        return coins
    }
    
    //Peticion que recibe todos los tradeos
    func getTrades() -> [Trade]{
        trades = []
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let requestTrades = Service.shared.getTradesInfo()
                
                requestTrades.responseJSON { (response) in
                    
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [[String:Any]]{
            
                                for i in 0..<data.count {
                                    self.trades.append(Trade(coin: (data[i]["Coin"] as? String)!, date: self.timestampToDate(date: data[i]["Date"] as! Double), quantity: (data[i]["Quantity"] as? Double)!, price: (data[i]["Price"] as? Double)!, isSell: (data[i]["Is_sell"] as? Int)!))
                                }
                            }
                            
                            self.tradeTableView.reloadData()
                            self.anim.hidePlaceholder(view: self.tradeTableView)
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
    
    //genera nuevo trade en base a compra/venta, moneda y cantidad además de comprobar las misiones
    func newTrade(is_sell:Int, quantity: Double, coin:String) {
        
        if isConnected {
            
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let parameters:[String:String] = [
                    "is_sell":String(is_sell),
                    "quantity":String(quantity),
                    "coin":coin
                ]
                
                let requestTrades = Service.shared.newTrade(parameters: parameters)
            
                requestTrades.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            Banners.shared.successBanner(title: body["message"]! as! String, subtitle: "")
                            self.setWallet(fromTrades: true)
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
                            self.anim.hidePlaceholder(view: self.tradeTableView)
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
    
    //peticion que recibe los wallets ademas de comprobar las misiones correspondientes
    func setWallet(fromTrades:Bool){
        wallets = []
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getWallets()
                request.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
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
                                
                                var walletsWithCash:[String] = []
                                
                                for i in 0..<self.wallets.count{
                                    if self.wallets[i].quantity > 0{
                                        walletsWithCash.append(self.wallets[i].symbol)
                                    }
                                }
                                
                                if(fromTrades){
                                    if self.wallets[0].quantity == 0 && self.isSell == 0{
                                        isMissionFinished(parameters: ["id":"11"])
                                    }
                                }
                                if(fromTrades){
                                    if walletsWithCash.count == 1{
                                        if walletsWithCash[0] == "BTC" {
                                            isMissionFinished(parameters: ["id":"8"])
                                        }
                                    }
                                }
                                if(fromTrades){
                                    if walletsWithCash.count == 1{
                                        if walletsWithCash[0] == "USDT" {
                                            isMissionFinished(parameters: ["id":"7"])
                                        }
                                    }
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
    
    //Comprueba nombre y devuelve positicion en el segmented control
    func getPositionInSGFromName()->Int{
        
        for i in 0..<coinsSC.numberOfSegments{
            
            if coinForSC == coinsSC.titleForSegment(at: i)!{
                return i
            }
        }
        return 0
    }
    
    //Recibe timestamp devuelve date
    func timestampToDate(date: Double) -> String {
        let tradeDate = Date(timeIntervalSince1970: date )
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        return formatter1.string(from: tradeDate)
    }
    
}

