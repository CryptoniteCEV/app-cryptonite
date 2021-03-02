//
//  TradingController.swift
//  CryptoniteCev
//
//  Created by user177260 on 3/1/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit

class TradingController: UIViewController {

   
    @IBOutlet var buyButton: UIButton!
    
    @IBOutlet var sellButton: UIButton!
    
    @IBOutlet var buyOrSellButton: UIButton!
    
    @IBOutlet var amountTextfield: UITextField!
    
    @IBAction func buySelected(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
        sellButton.alpha = 0.4
        sellButton.backgroundColor = UIColor.darkGray
        buyOrSellButton.backgroundColor = #colorLiteral(red: 0.2767237127, green: 0.8484591842, blue: 0.7351078391, alpha: 1)
        buyOrSellButton.setTitle("Buy BTC", for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 0.07450980392, green: 0.1215686275, blue: 0.2039215686, alpha: 1), for: .normal)
    }
    
    
    @IBAction func sellSelected(_ sender: UIButton) {
        sender.backgroundColor = UIColor.systemRed
        sender.alpha = 1
        sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        buyButton.alpha = 0.4
        buyButton.backgroundColor = UIColor.darkGray
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyOrSellButton.backgroundColor = UIColor.systemRed
        buyOrSellButton.setTitle("Sell BTC", for: .normal)
        buyOrSellButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    @IBAction func amountSlider(_ sender: UISlider) {
        amountTextfield.text = sender.value.description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyOrSellButton.setTitle("Buy BTC", for: .normal)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
