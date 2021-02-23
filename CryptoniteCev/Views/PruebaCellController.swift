//
//  PruebaCell.swift
//  CryptoniteCev
//
//  Created by alumnos on 23/02/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

class PruebaCellController: UIViewController {
    
    var stories : UICollectionView?
    var coinsCollection : UICollectionView?
    
    override func viewDidLoad() {
    
        view.overrideUserInterfaceStyle = .dark
        
        /*loadImages()
        stories = createStoriesView()
        coinsCollection = createCoinsView()
        
        if stories != nil {
            view.addSubview(stories!)
            setStoriesConstraints(stories: stories!)
        }
        if coinsCollection != nil {
            view.addSubview(coinsCollection!)
            setCoinsConstraints(coinsCollection: coinsCollection!)
        }*/

    }
    
    func getImages(image: UIImage) -> UIImage {
        
        return image
    }
}
