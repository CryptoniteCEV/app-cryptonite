//
//  GamificationController.swift
//  CryptoniteCev
//
//  Created by alumnos on 04/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import SwiftConfettiView

class GamificationController: UIViewController {
    
    var viewConfeti: SwiftConfettiView?

    @IBAction func claimRewards(_ sender: UIButton) {
        
        
        self.startConfetti(view: self.viewConfeti!)
        self.stopConfetti(view: self.viewConfeti!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewConfeti = SwiftConfettiView(frame: self.view.bounds)
        let tag = viewConfeti?.tag
    
        
        
        
    }
    
    func startConfetti(view: SwiftConfettiView){
        
        self.view.addSubview(self.viewConfeti!)
        view.startConfetti()
    }
    func stopConfetti(view: SwiftConfettiView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.stopConfetti()
            var confeti = self.view.viewWithTag(view.tag)
            confeti!.removeFromSuperview()
        }
    }
}
