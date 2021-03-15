
import UIKit
import Charts

class WalletViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
    @IBOutlet weak var container: UIView!
    
    var cash:Double = 0
    var coinsQuantities:[CoinsQuantities] = []
    
    var percentages:[String:Double] = [:]
    
    @IBOutlet weak var totalCash: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var porgress: UIProgressView!
    var graph = PieChart()
   
    var pieChart = PieChartView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        swipeRight.numberOfTouchesRequired = 2
        
        self.view.addGestureRecognizer(swipeRight)
        
        pieChart.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pieChart.drawEntryLabelsEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isMissionFinished(parameters: ["id":"14"])
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
                            }
                            self.cash = cash as! Double
                            self.totalCash.text = String((round(100*(cash as? Double)!)/100)) + "$"
                            self.percentages = self.getPercentages(myWallets: self.coinsQuantities)
                            self.viewDidLayoutSubviews()

                        }else{
                            Banners.shared.errorBanner(title: body["message"] as! String, subtitle: "Sorry!")
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            Banners.shared.noConnectionBanner()
        }
    }
    
    func getPercentages(myWallets:[CoinsQuantities]) -> [String:Double]{
        var values:[String:Double] = [:];
        var percentage:Double = 0
        
        for i in 0..<myWallets.count {
            if(myWallets[i].inDollars > 0){
                percentage = (myWallets[i].inDollars * 100) / cash;
                if(percentage > 2){
                    values[myWallets[i].symbol] = percentage
                }
            }
        }
        return values;
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
    
        graph.impirmirGrafica(pieChart: pieChart, screen: container, percentages: percentages)
            
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        Banners.shared.creatorsBanner()
    }
}
