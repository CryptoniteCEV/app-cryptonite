

import UIKit
import Charts

class CoinViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tradeButton: UIButton!
    
    @IBOutlet weak var coinIconIV: UIImageView!
    
    @IBOutlet weak var currencyNameL: UILabel!
    
    @IBOutlet weak var coinValueL: UILabel!
    
    @IBOutlet weak var coinPercentageL: UILabel!
    
    var graph = LineChart()
    var lineChart = LineChartView()
    
    var coinName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoin()
        lineChart.delegate = self
        
        tradeButton.layer.cornerRadius = tradeButton.frame.height / 8

    }
    
    
    @IBAction func TradeViewButton(_ sender: Any) {
        //performSegue(withIdentifier: "TradeViewID", sender: sender)
        
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
                            //currencyNameL.text = data["Symbol"] as! String
                            self.coinValueL.text = String(describing: data["Price"]!) + "$"
                            
                            self.coinIconIV.image = Images.shared.coins[data["Name"]! as! String]
                        }
                    }
                }
            }
        }
        
    }

}
