

import UIKit
import Charts

class WalletViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
 
   
   var wallet = [
        Wallet(icon: "BTC",idsCoins: "Bitcoin",quantities: 25,dollars: 0.03)
    
    ]
    @IBOutlet weak var tableView: UITableView!
    
    
    var graph = PieChart()
    
   
    var lineChart = LineChartView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        lineChart.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! CellRowController
      
           return cell
       }
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
     lineChart.frame = CGRect(
            
                x: 0,y: 0,
                width: 400,
                height: 200
                
            )
     print("está haciendo la funcion")
        lineChart.center = view.center
     view.addSubview(lineChart)
          var entries = [ChartDataEntry]()
            
            for x in 0...10{
                
                entries.append(ChartDataEntry(
                    
                    x: Double(x),
                    y: Double(x^2)
                    
                ))
                
            }
            
            
            let set =  LineChartDataSet(entries: entries)
            set.colors = ChartColorTemplates.colorful()
            let data = LineChartData(dataSet: set)
            lineChart.data = data
   
}
}
