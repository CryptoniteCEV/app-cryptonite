

import UIKit
import Charts

class WalletViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
 
    @IBOutlet weak var container: UIView!
    
    var wallets:[Wallet] = []
    var cash:Double = 0
    var coins:[UIImage] = []
    
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
        
        for (_, value) in Images.shared.coins {
            coins.append(value)
        }
        
        let request = Service.shared.getWallets()
        
        request.responseJSON { (response) in
            let body = response.value as? [String: Any]
            let data = body!["data"]! as! [[String:Any]]
            
            for i in 0..<data.count {
                
                self.wallets.append(Wallet(coin: (data[i]["Coin"] as? String)!, symbol: (data[i]["Symbol"] as? String)!, quantity: (data[i]["Quantity"] as? Double)!, inDollars: (data[i]["Price"] as? Double)!))
                self.cash += self.wallets[i].inDollars
            }
            self.cash = (round(10*self.cash)/100)
            self.totalCash.text = String(self.cash) + " $"
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if self.wallets.count>0{
            print("mayor que 0")
            return self.wallets.count
        }else{
            return coins.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.shared.coinID) as! CoinRowWalletController
       
        if wallets.count>0{
            cell.coin.text = wallets[indexPath.row].coin
            cell.symbol.text = wallets[indexPath.row].symbol
            cell.icon.image = Images.shared.coins[wallets[indexPath.row].coin]
            cell.price.text = String((round(1000*wallets[indexPath.row].inDollars)/1000)) + "$"
            cell.quantity.text = String((round(1000*wallets[indexPath.row].quantity)/1000)) + " " + wallets[indexPath.row].symbol
        }else{
            cell.icon.image = coins[indexPath.row]
        }
        return cell
       }
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(lineChart: lineChart, screen: container)
            
    }
}
