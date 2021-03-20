//
//  CircleCellClass.swift
//  CryptoniteCev
//
//  Created by user177260 on 1/21/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

protocol CircleCellDelegate: class {
    // Funcion delegado que tendrá la refencia de la instancia `UICollectionViewCell`
    func collectionViewCell(_ cell: UICollectionViewCell, buttonTapped: UIButton)
}

class CircleCell: UICollectionViewCell {
     
    static var index = 0
    var isLoaded = false
    
    let bg: UIButton = {
        
        let circularButton = UIButton()
        
        //estetica de los botones
        circularButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        circularButton.translatesAutoresizingMaskIntoConstraints = false
        circularButton.clipsToBounds = true
        circularButton.layer.cornerRadius = 0.8 * circularButton.bounds.size.width
        circularButton.setImage(images[CircleCell.index], for: .normal)
        circularButton.imageView?.contentMode = .scaleAspectFill
        circularButton.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        circularButton.layer.borderWidth = 3
            
        return circularButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)      
        
        //estetica de la vista
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        CircleCell.index += 1
    
        bg.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func thumbsUpButtonPressed(_ sender: UIButton){
        sender.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
}
