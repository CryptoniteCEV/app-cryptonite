//
//  MainScreenController.swift
//  CryptoniteCev
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

var images : [UIImage] = []
var imageSelected : UIImage?


class MainScreenController: UIViewController {
       
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CircleCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        view.overrideUserInterfaceStyle = .dark
        
        images.append(#imageLiteral(resourceName: "stockProfilePic"))
        images.append(#imageLiteral(resourceName: "istockphoto-1142003969-612x612"))
        images.append(#imageLiteral(resourceName: "depositphotos_19841901-stock-photo-asian-young-business-man-close"))
        images.append(#imageLiteral(resourceName: "360_F_367464887_f0w1JrL8PddfuH3P2jSPlIGjKU2BI0rn"))
        images.append(#imageLiteral(resourceName: "logoTransparente"))
        images.append(#imageLiteral(resourceName: "mainScreen"))
        
        CircleCell.images = images
        
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
         
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

extension MainScreenController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/5, height: collectionView.frame.width/5)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CircleCell
        cell.button.addTarget(self, action: #selector(buttonTappedInCollectionViewCell), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonTappedInCollectionViewCell(sender: UIButton) {
        setImage(image: sender.image(for: .normal)!)
        self.performSegue(withIdentifier: "stories", sender: nil)
    }
}




func getImages(image: UIImage) -> UIImage {
    
    return image
}


