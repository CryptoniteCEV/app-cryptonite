//
//  MainScreenExtension.swift
//  CryptoniteCev
//
//  Created by alumnos on 27/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

var images : [UIImage] = []

var imageSelected : UIImage?


var userPrueba = [
    UserPrueba(profilePic: #imageLiteral(resourceName: "img_femartinez_20181010-125104_imagenes_md_otras_fuentes_captura-kcOG-U452531892714hYG-980x554@MundoDeportivo-Web"), user_name: "@leoMessi10", name: "Lionel Messi", category: "Mayor dinero invertido en BTC", percentage: "+22,89%"),
    UserPrueba(profilePic: #imageLiteral(resourceName: "descarga (1)"), user_name: "@andreita93", name: "Andrea García", category: "Mayor porcentaje de ganancias", percentage: "+38,57%"),
    UserPrueba(profilePic: #imageLiteral(resourceName: "depositphotos_19841901-stock-photo-asian-young-business-man-close"), user_name: "@elJuanCar", name: "Juan Carlos", category: "Mayor porcentaje de pérdidas", percentage: "-44,98%"),
    UserPrueba(profilePic: #imageLiteral(resourceName: "1-intro-photo-final"), user_name: "@shurmano77", name: "Manuel Fernández", category: "Mayor número de seguidores", percentage: "+15,14%")
]

  
fileprivate let storiesView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(CircleCell.self, forCellWithReuseIdentifier: "cell")
    return cv
}()


extension MainScreenController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func loadImages() {
        
        if(images.count == 0){
            
            images.append(#imageLiteral(resourceName: "image1"))
            images.append(#imageLiteral(resourceName: "image1"))
            images.append(#imageLiteral(resourceName: "image1"))
            images.append(#imageLiteral(resourceName: "image1"))
            images.append(#imageLiteral(resourceName: "image1"))
            images.append(#imageLiteral(resourceName: "image1"))
        }
    }
    
    func createStoriesView() -> UICollectionView {
        storiesView.backgroundColor = .none
        storiesView.delegate = self
        storiesView.dataSource = self
        
        return storiesView
    }
    
    func setStoriesConstraints(stories : UICollectionView){
        
        stories.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/20).isActive = true
        stories.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/80).isActive = true
        stories.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/80).isActive = true
        stories.heightAnchor.constraint(equalToConstant: view.frame.height/8).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: storiesView.frame.width/5, height: storiesView.frame.width/5)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storiesView {
            return images.count
        } else if collectionView == coinCollectionView {
            if coins.count>0{
                return coins.count
            }else{
                return coinImages.count
            }
        } else {
            return userPrueba.count
        }
        
    }    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == storiesView {
            let cell = storiesView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CircleCell
            cell.bg.addTarget(self, action: #selector(buttonTappedInCollectionViewCell), for: .touchUpInside)
            return cell
        }
        if collectionView == coinCollectionView{
            
            let cell = coinCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCoins", for: indexPath) as! CoinCellMainController
            if coins.count>0{
                cell.iconImageView?.image = Images.shared.coins[coins[indexPath.row].name]
                cell.coinNameLabel?.text = coins[indexPath.row].name
                cell.categoryLabel?.text = ""
                cell.ammountLabel?.text = String(coins[indexPath.row].price) + "$"
                cell.percentageLabel?.text = "25%"
                
                 if(cell.percentageLabel?.text?.first == "-") {
                    cell.percentageLabel?.textColor = #colorLiteral(red: 0.9595015645, green: 0.2101880014, blue: 0.1372807622, alpha: 1)
                }else {
                    cell.percentageLabel?.textColor = #colorLiteral(red: 0.1485252082, green: 0.7475343347, blue: 0.3074167669, alpha: 1)
                }
            }else{
                cell.iconImageView?.image = coinImages[indexPath.row]
            }
            cell.layer.cornerRadius = cell.frame.height/8
                
            return cell
            
        }
        else {
            let cellUser = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "cellUsers", for: indexPath) as! UserCellMainController
            
            cellUser.profilePicIV.image = userPrueba[indexPath.row].profilePic
            cellUser.profilePicIV.layer.cornerRadius = cellUser.profilePicIV.frame.height/2
            cellUser.usernameL.text = userPrueba[indexPath.row].user_name
            cellUser.nameL.text = userPrueba[indexPath.row].name
            cellUser.categoryUserL.text = userPrueba[indexPath.row].category
            cellUser.percentageUserL.text = userPrueba[indexPath.row].percentage
            if(cellUser.percentageUserL.text?.first == "-") {
                cellUser.percentageUserL.textColor = #colorLiteral(red: 0.9595015645, green: 0.2101880014, blue: 0.1372807622, alpha: 1)
            }else {
                cellUser.percentageUserL.textColor = #colorLiteral(red: 0.1485252082, green: 0.7475343347, blue: 0.3074167669, alpha: 1)
            }
            cellUser.layer.cornerRadius = cellUser.frame.height/8
            
            return cellUser
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellActivity") as! ActivityRow
        if(trades.count>0){
            cell.profilePicActivityIV.image = #imageLiteral(resourceName: "image1")
            cell.profilePicActivityIV.layer.cornerRadius = cell.profilePicActivityIV.frame.height/2
            cell.usernameActivityL.text = trades[indexPath.row].username
            cell.coinSellingL.text = String(trades[indexPath.row].quantity) + " " + trades[indexPath.row].coinFromSymbol
            cell.iconSellingIV.image = Images.shared.coins[trades[indexPath.row].coinFrom]
            cell.coinBuyingL.text = String(trades[indexPath.row].converted) + " " + trades[indexPath.row].coinToSymbol
            cell.iconBuyingIV.image = Images.shared.coins[trades[indexPath.row].coinTo]
        }
        
        return cell
    }
    
    
    @objc func buttonTappedInCollectionViewCell(sender: UIButton) {
        setImage(image: sender.image(for: .normal)!)
        self.performSegue(withIdentifier: Identifiers.shared.stories, sender: sender)
    }
    
    func setImage(image: UIImage){
        imageSelected = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
        if (segue.identifier == Identifiers.shared.stories) {
            let storiesController = segue.destination as! StoriesController
            storiesController.storieImage = imageSelected
        }
    }
}
