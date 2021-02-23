

import UIKit

class PruebaCellController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var CoinPrueba: [CoinPrueba] = []
    
    override func viewDidLoad() {
    
        view.overrideUserInterfaceStyle = .dark
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.CoinPrueba.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CoinCellPrueba
        //cell.iconImageView.image = CoinPrueba[indexPath.row].icon
        cell.coinNameLabel.text = CoinPrueba[indexPath.row].coin_name
        cell.categoryLabel.text = CoinPrueba[indexPath.row].category
        cell.ammountLabel.text = CoinPrueba[indexPath.row].ammount
        
        return cell
        
    }
    
    
    
    
}
