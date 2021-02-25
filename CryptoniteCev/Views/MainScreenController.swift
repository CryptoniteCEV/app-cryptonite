//
//  MainScreenController.swift
//  CryptoniteCev
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit


class MainScreenController: UIViewController {

    var stories : UICollectionView?
    var coinsCollection : UICollectionView?

    @IBOutlet weak var coinCollectionView: UICollectionView!
    override func viewDidLoad() {
        
        view.overrideUserInterfaceStyle = .dark
        
        loadImages()
        stories = createStoriesView()
        coinsCollection = createCoinsView()
        
        if stories != nil {
            view.addSubview(stories!)
            setStoriesConstraints(stories: stories!)
        }
        if coinsCollection != nil {
            view.addSubview(coinsCollection!)
        }
    }
}
    

func getImages(image: UIImage) -> UIImage {
    
    return image
}



