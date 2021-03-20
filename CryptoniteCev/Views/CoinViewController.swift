

import UIKit
import Charts

class CoinViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tradeButton: UIButton!
    
    @IBOutlet weak var coinIconIV: UIImageView!
    
    @IBOutlet weak var aboutTitleLabel: UILabel!
    
    @IBOutlet weak var aboutCoinLabel: UILabel!
    
    @IBOutlet weak var currencyNameL: UILabel!
    
    @IBOutlet weak var coinValueL: UILabel!
    
    @IBOutlet weak var marketCapLabel: UILabel!
    
    @IBOutlet weak var volumeLabel: UILabel!
    
    @IBOutlet weak var coinPercentageL: UILabel!
    
    var onDoneBlock : ((String?) -> Void)?
    var values:[ChartDataEntry] = []
    var graph = LineChart()
    var lineChart = LineChartView()
    
    var coinSymbol:String = "BTC"
    var coinName:String?

    //Al iniciarse el view genera valores para la grafica con x e y en 0 como placeholder, recibe las monedas, comprueba la mission, y pone el boton de trade con redondeo
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.delegate = self
        
        for i in 0..<30{            
            self.values.append(ChartDataEntry(x: Double(i), y: 1))
        }
        
        getCoin()
        
        if(coinName! == "Bitcoin"){
            isMissionFinished(parameters: ["id":"3"])
        }
        
        tradeButton.layer.cornerRadius = tradeButton.frame.height / 8

    }
    
    //antes de iniciarse el view recibe el historial de la moneda escogida
    override func viewWillAppear(_ animated: Bool) {
        getCoinHistory()
    }
    
    //Al pulsar el boton de trade hace dismis y ejecuta el closure que te redirigira a la pantalla de trade
    @IBAction func TradeViewButton(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.onDoneBlock!(self.coinSymbol)
        }
    }
    
    
    //imprime la grafica con los valores correctos
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
        
        graph.impirmirGrafica(lineChart: lineChart, screen: containerView, values:values, coinSymbol: coinSymbol)
            
        lineChart.data?.notifyDataChanged()
        lineChart.notifyDataSetChanged()
        lineChart.setNeedsDisplay()
        lineChart.reloadInputViews()
    }
    
    //funcion que recoge la informacion de la moneda pulsada en la pantalla main
    func getCoin(){
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let parameters = ["name":coinName!]
                
                let request = Service.shared.getCoinInfo(parameters: parameters)
                
                request.responseJSON { (response) in
                   
                    if let body = response.value as? [String:Any] {
                        
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [String:Any]{
                                
                                self.currencyNameL.text = data["Name"]! as! String + "'s price"
                                self.coinSymbol = data["Symbol"] as! String
                                let coinValue = currencyFormatter(numberToFormat: (data["Price"] as? Double)!)
                                self.coinValueL.text = coinValue + "$"
                                self.aboutCoinLabel.text = AboutCoins.shared.coins[data["Name"]! as! String]
                                self.aboutTitleLabel.text = "About " + (data["Name"]! as! String)
                                self.coinIconIV.image = Images.shared.coins[data["Name"]! as! String]
                                let percentage = data["Change"]!
                                self.coinPercentageL.text = String(round(100*(percentage as? Double)!)/100) + "%"
                                
                                var volume = String(((data["Volume"]! as? Double)!) / 1000000000)
                                volume = self.removeDecimals(numberToRound: volume)
                                self.volumeLabel.text = volume + "B $"
                                
                                var marketCap = String(((data["Cap"]! as? Double)!)/1000000000)
                                marketCap = self.removeDecimals(numberToRound: marketCap)
                                self.marketCapLabel.text = marketCap + "B $"
                                
                                if((data["Change"] as! Double) < 0) {
                                    self.coinPercentageL?.textColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                                }else {
                                    self.coinPercentageL?.textColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
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

    //funcion que realiza la peticion de recoger el historial de la moneda
    func getCoinHistory(){
    
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let parameters = ["coin":coinName!]
                
                let request = Service.shared.getCoinHistory(params: parameters)
                
                request.responseJSON { (response) in
                   
                    if let body = response.value as? [String:Any] {
                        
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [[Double]]{
                                
                                
                                self.values = []
                                
                                for i in 0..<data.count{
                                   self.values.append(ChartDataEntry(x: Double(i+1), y: data[i][1]))
                                }
                                
                                self.viewDidLayoutSubviews()
                                
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
    
    //quita los decimales de ciertos valores
    func removeDecimals(numberToRound: String) -> String{
        let splitter = numberToRound.components(separatedBy: ".")
        var splitted: String = splitter[1]
        let lastDecimal = splitted.first
        splitted = splitter[0] + "." + String(lastDecimal!)
        
        return splitted
    }
    
}
