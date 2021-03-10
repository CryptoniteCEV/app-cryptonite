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
    private var _image : UIImage
    private var _title : String
    
    init(id:Int, image:UIImage, title: String){
        self._id = id
        self._image = image
        self._title = title
    }
    
    public var id: Int {
        get {
            return self._id;
        }
        set {
            self._id = newValue
        }
    }
    
    public var image: UIImage {
        get {
            return self._image;
        }
        set {
            self._image = newValue
        }
    }

    public var title: String {
        get {
            return self._title;
        }
        set {
            self._title = newValue
        }
    }

}
