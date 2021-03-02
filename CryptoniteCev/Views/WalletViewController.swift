

import UIKit
import Charts

class WalletViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
 
    @IBOutlet weak var container: UIView!
    
    var wallets:[Wallet] = []
    
    @IBOutlet weak var totalCash: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var porgress: UIProgressView!
    var graph = PieChart()
    
   
    var lineChart = LineChartView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        
        let request = Service.shared.getWallets()
        
        request.responseJSON { (response) in
            let body = response.value as? [String: Any]
            let data = body!["data"]! as! [[String:Any]]
            var cash = body!["message"]! as? Double
            cash = (round(1000*cash!)/1000)
            self.totalCash.text = String(cash!) + " $"
            for i in 0..<data.count {
                
                self.wallets.append(Wallet(coin: (data[i]["Coin"] as? String)!, symbol: (data[i]["Symbol"] as? String)!, quantity: (data[i]["Quantity"] as? Double)!, inDollars: (data[i]["Price"] as? Double)!))
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.wallets.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.shared.coinID) as! CoinRowWalletController
       
        if wallets.count>0{
            cell.coin.text = wallets[indexPath.row].coin
            cell.symbol.text = wallets[indexPath.row].symbol
            cell.icon.image = Images.shared.coins[wallets[indexPath.row].coin]
            cell.price.text = String(wallets[indexPath.row].inDollars) + "$"
            cell.quantity.text = String(wallets[indexPath.row].quantity) + " " + wallets[indexPath.row].symbol
        }
        return cell
       }
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(lineChart: lineChart, screen: container)
            
    }
}
