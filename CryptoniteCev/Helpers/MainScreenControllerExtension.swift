//
//  MainScreenExtension.swift
//  CryptoniteCev
//
//  Created by alumnos on 27/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import SkeletonView

var images : [UIImage] = []

var imageSelected : UIImage?

//imagen que venga con el token
var myProfilePic = #imageLiteral(resourceName: "logoNoText")


extension MainScreenController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storiesCollectionView {
            return followings.count
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
        
        if collectionView == storiesCollectionView {
            let cell = storiesCollectionView.dequeueReusableCell(withReuseIdentifier: "CellStories", for: indexPath) as! StoriesCell
            
            if indexPath.row == 0 {
                cell.storiesImageView?.image = myProfilePic
            }else if followings.count > 1{
                cell.storiesImageView?.image = followings[indexPath.row].profilePic
                cell.storiesImageView.layer.cornerRadius = cell.storiesImageView.frame.height/2
            }
            cell.layer.cornerRadius = cell.frame.width/2
            cell.layer.borderWidth = 3
            cell.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
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
            if users.count > 0{
                cellUser.profilePicIV.image = users[indexPath.row].profilePic
                cellUser.profilePicIV.layer.cornerRadius = cellUser.profilePicIV.frame.height/2
                cellUser.usernameL.text = users[indexPath.row].username
                cellUser.percentageUserL.text = "Lvl. " + String(users[indexPath.row].experience)
                
                if(cellUser.percentageUserL.text?.first == "-") {
                    cellUser.percentageUserL.textColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
                }else {
                    cellUser.percentageUserL.textColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                }
                cellUser.layer.cornerRadius = cellUser.frame.height/8
            }
            return cellUser
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if coins.count>0 && collectionView == coinCollectionView{
            let selectedItem = coins[indexPath.row].name
            performSegue(withIdentifier: "coinViewID", sender: selectedItem)
        }else if users.count>0 && collectionView == usersCollectionView {
            let selectedItem = users[indexPath.row].username
            performSegue(withIdentifier: "stories", sender: selectedItem)
        } else if followings.count>0 && collectionView == storiesCollectionView {
            
            let cell = storiesCollectionView.cellForItem(at: indexPath)
            cell?.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
            if indexPath.row == 0 {
                performSegue(withIdentifier: "gaming", sender: (Any).self)
            }else {
                let selectedItem = followings[indexPath.row].username
                performSegue(withIdentifier: "stories", sender: selectedItem)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityRow.identifier) as! ActivityRow
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
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ActivityRow.identifier
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
        if (segue.identifier == Identifiers.shared.stories) {
            let storiesController = segue.destination as! StoriesController
            storiesController.onDoneBlock = { result in
                
                //self.storiesCollectionView.reloadData()
                self.fillFollowings()
            }
            storiesController.username = sender as? String
            
        }else if(segue.identifier == "coinViewID"){
            let coinController = segue.destination as! CoinViewController
            coinController.coinName = sender as? String
        }
    }
}
