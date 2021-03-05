

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.delegate = self
        
        tradeButton.layer.cornerRadius = tradeButton.frame.height / 8

    }
    
    @IBAction func TradeViewButton(_ sender: Any) {
        performSegue(withIdentifier: "TradeViewID", sender: sender)
        
    }
    
    
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(lineChart: lineChart, screen: containerView)
            
    }

}
