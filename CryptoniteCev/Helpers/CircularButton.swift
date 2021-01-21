//
//  CircularButton.swift
//  CryptoniteCev
//
//  Created by alumnos on 21/01/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

class CircularButton: UIButton {
    
    
    public static func setupCircularButton(button : UIButton){
        
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.setImage(UIImage(named:"stockProfilePic.png"), for: .normal)
        
    }
}
