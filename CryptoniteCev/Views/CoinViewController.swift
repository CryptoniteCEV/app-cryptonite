

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
    
    @IBOutlet weak var coinPercentageL: UILabel!
    
    var onDoneBlock : ((String?) -> Void)?
    
    var graph = LineChart()
    var lineChart = LineChartView()
    
    var coinSymbol:String = "BTC"
    var coinName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoin()
        lineChart.delegate = self
        
        tradeButton.layer.cornerRadius = tradeButton.frame.height / 8

    }
    
    
    @IBAction func TradeViewButton(_ sender: Any) {
        //performSegue(withIdentifier: "TradeViewID", sender: sender)
        self.dismiss(animated: true) {
            self.onDoneBlock!(self.coinSymbol)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(lineChart: lineChart, screen: containerView)
            
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
                        }
                    }
                }
            }
        }
        
    }

}
