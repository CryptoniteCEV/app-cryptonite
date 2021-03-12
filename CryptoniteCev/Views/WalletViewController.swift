
import UIKit
import Charts
import SkeletonView

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
        
        pieChart.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        navigationController?.setNavigationBarHidden(true, animated: true)
       let anim = SkeletonableAnim()
        anim.placeholder(view: totalCash)
    
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.cash = 0
        self.coinsQuantities = []
    
        if Service.isConnectedToInternet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                               self.totalCash.stopSkeletonAnimation()
                               self.totalCash.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            print("Skeleton out")
                    })
            print("con internet")
            
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
                            self.percentages = self.getCoinPercentages(cash: cash as! Double)

                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }else {
            print("sin internet")
            totalCash.isSkeletonable = true
            let animation = GradientDirection.leftRight.slidingAnimation()
            let gradient = SkeletonGradient.init(baseColor: .midnightBlue)
            totalCash.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            
        }
    }
    
    func getCoinPercentages(cash:Double)->[String:Double]{
        var coinsInWallet:[String:Double] = [:]
        
        for wallet in coinsQuantities {
            
            if wallet.inDollars > 0{
                let percentage = (wallet.inDollars * 100) / cash
                coinsInWallet [wallet.symbol] = percentage
            }
        }
        
        return coinsInWallet
        
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
}
