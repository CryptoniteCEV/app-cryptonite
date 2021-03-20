//
//  TabBarController.swift
//  CryptoniteCev
//
//  Created by Alejandro García on 5/3/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import UIKit


class TabBarController:UITabBarController{
    
    /**
     Iniciará como primera pantalla el index 1 del tab bar que será la main screen
     */
    override func viewDidLoad() {
        self.selectedIndex = 1
    }
}
