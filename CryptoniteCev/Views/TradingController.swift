//
//  TradingController.swift
//  CryptoniteCev
//
//  Created by user177260 on 3/1/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import iOSDropDown

class TradingController: UIViewController {

   
    @IBOutlet weak var tradeTableView: UITableView!
    
    @IBOutlet weak var coinDropdown: DropDown!
    
    @IBOutlet weak var coinDropdownTextfield: UITextField!
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var sellButton: UIButton!
    
    @IBOutlet var buyOrSellButton: UIButton!
    
    @IBOutlet var amountTextfield: UITextField!
    
    var isSell = false
    
    var tradeType = "Buy "
    
    @IBAction func buySelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        sellButton.alpha = 0.4
        sellButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        buyOrSellButton.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        buyOrSellButton.setTitle("Buy " + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        isSell = false
    }
    
    
    @IBAction func sellSelected(_ sender: UIButton) {
        sender.backgroundColor = UIColor.systemRed
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        buyButton.alpha = 0.4
        buyButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyOrSellButton.backgroundColor = UIColor.systemRed
        buyOrSellButton.setTitle("Sell " + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        isSell = true
    }
    
    @IBAction func amountSlider(_ sender: UISlider) {
        amountTextfield.text = sender.value.description
    }
    
    @IBAction func coinSelected(_ sender: DropDown) {
        if isSell {
            tradeType = "Sell "
        }
        buyOrSellButton.setTitle(tradeType + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tradeTableView.delegate = self
        tradeTableView.dataSource = self
        tradeTableView.reloadData()
        
        coinDropdown.optionArray = ["BTC/USD", "ETH/USD", "DOGE/USD", "LITE/USD", "SFP/USD"]
        coinDropdown.selectedIndex = 0
        coinDropdownTextfield.text = coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0]
        buyOrSellButton.setTitle("Buy " + coinDropdown.optionArray[coinDropdown.selectedIndex ?? 0], for: .normal)
        
    }
}
