//
//  Missions.swift
//  CryptoniteCev
//
//  Created by alumnos on 09/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import UIKit

class Missions{
    
    static let shared = Missions()
    
    private init(){}
    
    let missions = [ Mission(id: 0, image: #imageLiteral(resourceName: "023-coin stacks"), title: "Buy DOGE"),
                     Mission(id: 1, image: #imageLiteral(resourceName: "034-trading"), title: "Check Bitcoin"),
                     Mission(id: 2, image: #imageLiteral(resourceName: "049-currency exchange"), title: "Buy any cryptocurrency"),
                     Mission(id: 3, image: #imageLiteral(resourceName: "045-digital investment"), title: "Follow someone"),
                     Mission(id: 4, image: #imageLiteral(resourceName: "021-Litecoin"), title: "Sell LTC"),
                     Mission(id: 5, image: #imageLiteral(resourceName: "008-cryptovault"), title: "Sell everything to USDT")]
}
