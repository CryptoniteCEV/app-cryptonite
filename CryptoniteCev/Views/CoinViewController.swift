

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.delegate = self
        //lineChart.xAxis.drawGridLinesEnabled = false
        
      
        //lineChart.rightAxis.drawLabelsEnabled = false
        getCoin()
        
        tradeButton.layer.cornerRadius = tradeButton.frame.height / 8

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoinHistory()
    }
    
    
    @IBAction func TradeViewButton(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.onDoneBlock!(self.coinSymbol)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
        
        graph.impirmirGrafica(lineChart: lineChart, screen: containerView, values:values, coinSymbol: coinSymbol)
            
        lineChart.data?.notifyDataChanged()
        lineChart.notifyDataSetChanged()
        lineChart.setNeedsDisplay()
        lineChart.reloadInputViews()
    }
    
    func getCoin(){
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let parameters = ["name":coinName!]
                
                let request = Service.shared.getCoinInfo(parameters: parameters)
                
                request.responseJSON { (response) in
                   
                    if let body = response.value as? [String:Any] {
                    
                        if let data = body["data"] as? [String:Any]{
                            
                            self.currencyNameL.text = data["Name"]! as! String + "'s price"
                            self.coinSymbol = data["Symbol"] as! String
                            self.coinValueL.text = String(describing: data["Price"]!) + "$"
                            self.aboutCoinLabel.text = AboutCoins.shared.coins[data["Name"]! as! String]
                            self.aboutTitleLabel.text = "About " + (data["Name"]! as! String)
                            self.coinIconIV.image = Images.shared.coins[data["Name"]! as! String]
                            self.coinPercentageL.text = String(describing: data["Change"]!) + "%"
                            self.volumeLabel.text = String(describing:data["Volume"]!) + "$"
                            self.marketCapLabel.text = String(describing:data["Cap"]!) + "$"
                            
                            if((data["Change"] as! Double) < 0) {
                                self.coinPercentageL?.textColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                            }else {
                                self.coinPercentageL?.textColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                            }
                        }
                    }
                }
            }
        }
        
    }

    func getCoinHistory(){
    
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let parameters = ["coin":coinName!]
                
                let request = Service.shared.getCoinHistory(params: parameters)
                
                request.responseJSON { (response) in
                   
                    if let body = response.value as? [String:Any] {
                        
                        if let data = body["data"] as? [[Double]]{
                            
                            for i in 0..<data.count{
                                
                                self.values.append(ChartDataEntry(x: Double(i+1), y: data[i][1]))
                                
                            }
                            
                            self.viewDidLayoutSubviews()
                            
                        }
                    }
                }
            }
        }
    }
}
