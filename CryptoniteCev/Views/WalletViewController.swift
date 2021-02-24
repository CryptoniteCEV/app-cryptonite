

import UIKit
import Charts

class WalletViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
 
   
   var wallet = [
    Wallet(icon: #imageLiteral(resourceName: "Bitcoin.svg"),idsCoins: "Bitcoin",simbol: "BTC", quantities: 3,dollars: 63000 ),
    Wallet(icon: #imageLiteral(resourceName: "eth.png"),idsCoins: "Ethereum", simbol: "ETH",quantities: 25,dollars: 35000),
    Wallet(icon: #imageLiteral(resourceName: "doge.png"),idsCoins: "Dogecoin",simbol: "DOGE",quantities: 300,dollars: 10.12)
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
    
        return self.wallet.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! CellRowController
       
        
        cell.currency.text = wallet[indexPath.row].coins
        cell.simbol.text = wallet[indexPath.row].simbol
        cell.icon.image = wallet[indexPath.row].icons
        cell.dolars.text = String(wallet[indexPath.row].dollars)
        cell.currencyValor.text = String(wallet[indexPath.row].quantities)
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
