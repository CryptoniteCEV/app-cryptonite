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


var users = [
    UserMain(profilePic: #imageLiteral(resourceName: "img_femartinez_20181010-125104_imagenes_md_otras_fuentes_captura-kcOG-U452531892714hYG-980x554@MundoDeportivo-Web"), username: "@leoMessi10", percentage: "+22,89%"),
    UserMain(profilePic: #imageLiteral(resourceName: "descarga (1)"), username: "@andreita93", percentage: "+38,57%"),
    UserMain(profilePic: #imageLiteral(resourceName: "depositphotos_19841901-stock-photo-asian-young-business-man-close"), username: "@elJuanCar", percentage: "-44,98%"),
    UserMain(profilePic: #imageLiteral(resourceName: "1-intro-photo-final"), username: "@shurmano77", percentage: "+15,14%")
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
            
            images.append(#imageLiteral(resourceName: "user1.png"))
            images.append(#imageLiteral(resourceName: "user13"))
            images.append(#imageLiteral(resourceName: "user15"))
            images.append(#imageLiteral(resourceName: "user7"))
            images.append(#imageLiteral(resourceName: "user12"))
            images.append(#imageLiteral(resourceName: "user6"))
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
            return users.count
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
                cell.ammountLabel?.text = String(coins[indexPath.row].price) + "$"
                cell.percentageLabel?.text = "25%"
                
                 if(cell.percentageLabel?.text?.first == "-") {
                    cell.percentageLabel?.textColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                }else {
                    cell.percentageLabel?.textColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                }
            }else{
                cell.iconImageView?.image = coinImages[indexPath.row]
            }
            cell.layer.cornerRadius = cell.frame.height/8
                
            return cell
            
        }
        else {
            let cellUser = usersCollectionView.dequeueReusableCell(withReuseIdentifier: "cellUsers", for: indexPath) as! UserCellMainController
            
            cellUser.profilePicIV.image = users[indexPath.row].profilePic
            cellUser.profilePicIV.layer.cornerRadius = cellUser.profilePicIV.frame.height/2
            cellUser.usernameL.text = users[indexPath.row].user_name
            cellUser.percentageUserL.text = users[indexPath.row].percentage
            if(cellUser.percentageUserL.text?.first == "-") {
                cellUser.percentageUserL.textColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
            }else {
                cellUser.percentageUserL.textColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            }
            cellUser.layer.cornerRadius = cellUser.frame.height/8
            
            return cellUser
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if coins.count>0 && collectionView == coinCollectionView{
            let selectedItem = coins[indexPath.row]
            performSegue(withIdentifier: "coinViewID", sender: selectedItem)
        }else if collectionView == coinCollectionView{
            performSegue(withIdentifier: "coinViewID", sender: Any?.self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellActivity") as! ActivityRow
        if(trades.count>0){
            cell.profilePicActivityIV.image = Images.shared.users[trades[indexPath.row].profilePic]
            cell.profilePicActivityIV.layer.cornerRadius = cell.profilePicActivityIV.frame.height/2
            cell.usernameActivityL.text = trades[indexPath.row].username
            cell.coinSellingL.text = String(trades[indexPath.row].quantity)
            cell.iconSellingIV.image = Images.shared.coins[trades[indexPath.row].coinFrom]
            cell.coinBuyingL.text = String(trades[indexPath.row].converted)
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
        }else if(segue.identifier == "coinViewID"){
            let coinController = segue.destination as! CoinViewController
        }
    }
}
