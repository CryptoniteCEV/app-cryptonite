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

    override func viewDidLoad() {
        
        view.overrideUserInterfaceStyle = .dark
        
        loadImages()
        stories = createStoriesView()
        if stories != nil {
            view.addSubview(stories!)
            setConstraints(stories: stories!)
        }
             
        
    }
    
}
    

func getImages(image: UIImage) -> UIImage {
    
    return image
}



