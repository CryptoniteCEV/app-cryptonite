//
//  Mission.swift
//  CryptoniteCev
//
//  Created by alumnos on 09/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import UIKit

class Mission{
    
    private var _id : Int
    private var _icon : UIImage
    private var _description : String
    private var _isFinished : Int
    
    init(id:Int, icon:UIImage, description: String, isFinished:Int){
        self._id = id
        self._icon = icon
        self._description = description
        self._isFinished = isFinished
    }
    
    public var id: Int {
        get {
            return self._id;
        }
        set {
            self._id = newValue
        }
    }
    
    public var icon: UIImage {
        get {
            return self._icon;
        }
        set {
            self._icon = newValue
        }
    }

    public var description: String {
        get {
            return self._description;
        }
        set {
            self._description = newValue
        }
    }
    public var isFinished: Int {
        get {
            return self._isFinished;
        }
        set {
            self._isFinished = newValue
        }
    }

}
