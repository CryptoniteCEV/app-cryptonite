
import UIKit
import Charts

class WalletViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
 
    @IBOutlet weak var container: UIView!
    
    var cash:Double = 0
    var coinsQuantities:[CoinsQuantities] = []
    
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
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.cash = 0
        self.coinsQuantities = []
    
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getWallets()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                    
                        if let data = body["data"] as? [String:Any]{
                        let wallets = data["Wallets"] as! [[String:Any]]
                        let cash = data["Cash"]
                       
                            for i in 0..<wallets.count {
                                self.coinsQuantities.append(CoinsQuantities(name: (wallets[i]["Name"] as? String)!, symbol: (wallets[i]["Symbol"]! as? String)!, quantity: (wallets[i]["Quantity"] as? Double)!, inDollars: (wallets[i]["inDollars"] as? Double)!))
                                self.cash += self.coinsQuantities[i].inDollars
                            }
                            self.totalCash.text = String((round(100*(cash as? Double)!)/100)) + "$"
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.coinsQuantities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.shared.coinID) as! CoinRowWalletController
       
        if coinsQuantities.count>0{
            cell.coin.text = coinsQuantities[indexPath.row].name
            cell.symbol.text = coinsQuantities[indexPath.row].symbol
            cell.icon.image = Images.shared.coins[coinsQuantities[indexPath.row].name]
            cell.price.text = String((round(1000*coinsQuantities[indexPath.row].inDollars)/1000)) + "$"
            cell.quantity.text = String((round(1000*coinsQuantities[indexPath.row].quantity)/1000)) + " " + coinsQuantities[indexPath.row].symbol
        }
        
        return cell
        
       }
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(lineChart: lineChart, screen: container)
            
    }
}
