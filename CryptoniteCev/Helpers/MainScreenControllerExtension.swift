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

  
fileprivate let storiesView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(CircleCell.self, forCellWithReuseIdentifier: "cell")
    return cv
}()

fileprivate let coinsView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(CoinCell.self, forCellWithReuseIdentifier: "cell")
    return cv
}()

extension MainScreenController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func loadImages() {
        
        if(images.count == 0){
            
            images.append(#imageLiteral(resourceName: "stockProfilePic"))
            images.append(#imageLiteral(resourceName: "istockphoto-1142003969-612x612"))
            images.append(#imageLiteral(resourceName: "depositphotos_19841901-stock-photo-asian-young-business-man-close"))
            images.append(#imageLiteral(resourceName: "360_F_367464887_f0w1JrL8PddfuH3P2jSPlIGjKU2BI0rn"))
            images.append(#imageLiteral(resourceName: "logoTransparente"))
            images.append(#imageLiteral(resourceName: "mainScreen"))
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
    
    func createCoinsView() -> UICollectionView {
        coinsView.backgroundColor = .none
        coinsView.delegate = self
        coinsView.dataSource = self
        
        return coinsView
    }
    
    func setCoinsConstraints(coinsCollection : UICollectionView){
        
        coinsCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/5).isActive = true
        coinsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/80).isActive = true
        coinsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/80).isActive = true
        coinsCollection.heightAnchor.constraint(equalToConstant: view.frame.height/5).isActive = true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == storiesView {
            return CGSize(width: storiesView.frame.width/5, height: storiesView.frame.width/5)
        }else{
            return CGSize(width: coinsView.frame.width/3.5, height: coinsView.frame.width/4.5)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storiesView {
            let cell = storiesView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CircleCell
            cell.bg.addTarget(self, action: #selector(buttonTappedInCollectionViewCell), for: .touchUpInside)
            return cell
        }else{
            let cell = coinsView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CoinCell
            return cell
        }
        
    }
    
    @objc func buttonTappedInCollectionViewCell(sender: UIButton) {
        setImage(image: sender.image(for: .normal)!)
        self.performSegue(withIdentifier: "stories", sender: sender)
    }
    
    func setImage(image: UIImage){
        imageSelected = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
        if (segue.identifier == "stories") {
            let storiesController = segue.destination as! StoriesController
            storiesController.storieImage = imageSelected
        }
    }
}
