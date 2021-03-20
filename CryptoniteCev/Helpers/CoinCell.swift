//
//  CoinCell.swift
//  CryptoniteCev
//
//  Created by user177260 on 1/27/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

protocol CoinCellDelegate: class {
    // Funcion delegado que tendrá la refencia de la instancia `UICollectionViewCell`
    func collectionViewCell(_ cell: UICollectionViewCell, buttonTapped: UIButton)
}

class CoinCell: UICollectionViewCell {
    
    static var index = 0
    var isLoaded = false
    
    let coinCardButton: UIButton = {
        
        let coinCardButton = UIButton()
        //Estética del boton
        coinCardButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        coinCardButton.translatesAutoresizingMaskIntoConstraints = false
        coinCardButton.clipsToBounds = true
        coinCardButton.layer.cornerRadius = 5
        coinCardButton.setImage(images[CoinCell.index], for: .normal)
        coinCardButton.imageView?.contentMode = .scaleAspectFill
            
        return coinCardButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        //estética del view
        contentView.addSubview(coinCardButton)
        coinCardButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        coinCardButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        coinCardButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        coinCardButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        CoinCell.index += 1
    
        coinCardButton.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func thumbsUpButtonPressed(_ sender: UIButton){
        sender.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
}
