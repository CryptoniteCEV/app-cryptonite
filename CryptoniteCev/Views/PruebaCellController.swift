

import UIKit

class PruebaCellController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var coinCollectionView: UICollectionView!
    
  
    var coinPrueba = [
        CoinPrueba(icono: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", ammount: "+3,056M $", percentage: "+27,06%"),
        CoinPrueba(icono: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", ammount: "+3,056M $", percentage: "+27,06%"),
        CoinPrueba(icono: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", ammount: "+3,056M $", percentage: "+27,06%"),
        CoinPrueba(icono: #imageLiteral(resourceName: "Bitcoin"), coin_name: "BTC", ammount: "+3,056M $", percentage: "+27,06%")
    ]
    
    override func viewDidLoad() {
    
        view.overrideUserInterfaceStyle = .dark
        
        coinCollectionView.dataSource = self
        coinCollectionView.delegate = self
            

    }
    
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.coinPrueba.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = coinCollectionView.dequeueReusableCell(withReuseIdentifier: "cellPrueba", for: indexPath) as! CoinCellPrueba
        cell.iconImageView?.image = coinPrueba[indexPath.row].icono
        cell.coinNameLabel?.text = coinPrueba[indexPath.row].coin_name
        cell.ammountLabel?.text = coinPrueba[indexPath.row].ammount
        cell.percentageLabel?.text = coinPrueba[indexPath.row].percentage
        cell.layer.cornerRadius = cell.frame.height/8
            
        return cell
            
    }
        
        
    
    
}
