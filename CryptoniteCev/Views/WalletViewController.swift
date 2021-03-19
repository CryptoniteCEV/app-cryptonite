
import UIKit
import Charts
import SkeletonView

class WalletViewController: UIViewController, SkeletonTableViewDataSource, UITableViewDelegate,
    ChartViewDelegate
{
    @IBOutlet weak var container: UIView!
    
    var balance:Double = 0
    var coinsQuantities:[CoinsQuantities] = []
    
    var percentages:[String:Double] = [:]
    
    @IBOutlet weak var totalCash: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var porgress: UIProgressView!
    var graph = PieChart()
   
    var pieChart = PieChartView()
    
    var roundingQuantity: Double = 100000
    let anim = SkeletonableAnim()
    
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
        
        tableView.rowHeight = 68
        tableView.estimatedRowHeight = 68
        
        anim.placeholder(view: totalCash)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        isMissionFinished(parameters: ["id":"14"])
        balance = 0
        
        if(coinsQuantities.count == 0){
            anim.placeholder(view: tableView)
        }
        coinsQuantities = []
        getWallets()
       
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    
    func getWallets(){
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getWallets()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [String:Any]{
                                let wallets = data["Wallets"] as! [[String:Any]]
                                let cash = data["Cash"]
                           
                                for i in 0..<wallets.count {
                                    self.coinsQuantities.append(CoinsQuantities(name: (wallets[i]["Name"] as? String)!, symbol: (wallets[i]["Symbol"]! as? String)!, quantity: (wallets[i]["Quantity"] as? Double)!, inDollars: (wallets[i]["inDollars"] as? Double)!))
                                }
                                self.balance = cash as! Double
                                self.totalCash.text = currencyFormatter(numberToFormat: (round(100*(cash as? Double)!)/100)) + "$"
                                
                                self.percentages = self.getPercentages(myWallets: self.coinsQuantities)
                                self.anim.hidePlaceholder(view: self.totalCash)
                                self.anim.hidePlaceholder(view: self.tableView)
                                self.viewDidLayoutSubviews()

                            }else{
                                if !unknownBanner.isDisplaying{
                                    unknownBanner.show()
                                }
                            }
                            self.tableView.reloadData()
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getPercentages(myWallets:[CoinsQuantities]) -> [String:Double]{
        var values:[String:Double] = [:];
        var percentage:Double = 0
        
        for i in 0..<myWallets.count {
            if(myWallets[i].inDollars > 0){
                percentage = (myWallets[i].inDollars * 100) / balance;
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
            roundingQuantity = setRounding(symbol: "Tether")
            cell.price.text = currencyFormatter(numberToFormat: (round(roundingQuantity*coinsQuantities[indexPath.row].inDollars)/roundingQuantity)) + "$"
            roundingQuantity = setRounding(symbol: coinsQuantities[indexPath.row].symbol)
            let quantity = currencyFormatter(numberToFormat: (round(roundingQuantity * (coinsQuantities[indexPath.row].quantity)) / roundingQuantity))
            cell.quantity.text = quantity + " " + coinsQuantities[indexPath.row].symbol
        }
        
        return cell
        
       }
    override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
    
        graph.impirmirGrafica(pieChart: pieChart, screen: container, percentages: percentages)
            
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
            
            return Identifiers.shared.coinID
            
        }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        Banners.shared.creatorsBanner()
    }
}
