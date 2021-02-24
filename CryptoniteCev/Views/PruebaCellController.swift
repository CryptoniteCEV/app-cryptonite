

import UIKit

class PruebaCellController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var coinCollectionView: UICollectionView!
    
    var coinPrueba = [
        CoinPrueba(icon: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", category: "Highest invested currency", ammount: "+3,056M $", percentage: "+27,06%"),
        CoinPrueba(icon: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", category: "Highest invested currency", ammount: "+3,056M $", percentage: "+27,06%"),
        CoinPrueba(icon: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", category: "Highest invested currency", ammount: "+3,056M $", percentage: "+27,06%"),
        CoinPrueba(icon: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", category: "Highest invested currency", ammount: "+3,056M $", percentage: "+27,06%")
    ]
    
    override func viewDidLoad() {
    
        view.overrideUserInterfaceStyle = .dark
        
        coinCollectionView.dataSource = self
        coinCollectionView.delegate = self
            
        self.coinCollectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.coinPrueba.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPrueba", for: indexPath) as! CoinCellPrueba
        cell.iconImageView?.image = coinPrueba[indexPath.row].icon
        cell.coinNameLabel?.text = coinPrueba[indexPath.row].coin_name
        cell.categoryLabel?.text = coinPrueba[indexPath.row].category
        cell.ammountLabel?.text = coinPrueba[indexPath.row].ammount
        cell.percentageLabel?.text = coinPrueba[indexPath.row].percentage
        
        return cell
        
    }
    
}
