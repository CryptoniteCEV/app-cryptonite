//
//  GamificationController.swift
//  CryptoniteCev
//
//  Created by alumnos on 04/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import SwiftConfettiView
import CircleProgressBar

class GamificationController: UIViewController {
    
    @IBOutlet var circleProgressBar: CircleProgressBar!
    
    @IBOutlet var missionsCard: UIView!
    
    @IBOutlet var walletCard: UIView!
    var viewConfeti: SwiftConfettiView?

    @IBOutlet var clearMission1: UIButton!
    
    @IBOutlet var clearMission2: UIButton!
    
    @IBOutlet var clearMission3: UIButton!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet weak var cashLabel: UILabel!
    
    @IBAction func claimRewards(_ sender: UIButton) {
        
        self.startConfetti(view: self.viewConfeti!)
        self.stopConfetti(view: self.viewConfeti!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rewards"
        clearMission1.layer.cornerRadius = clearMission1.frame.width/2
        clearMission2.layer.cornerRadius = clearMission1.frame.width/2
        clearMission3.layer.cornerRadius = clearMission1.frame.width/2
        circleProgressBar.setProgress(0.3, animated: true)
        self.viewConfeti = SwiftConfettiView(frame: self.view.bounds)
        /*
            self.viewConfeti?.type = .image(#imageLiteral(resourceName: "btc"))
            self.viewConfeti?.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
            self.viewConfeti?.intensity=0.69
        */
        self.viewConfeti?.tag = 200
        missionsCard.layer.cornerRadius = 10
        walletCard.layer.cornerRadius = 10
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 4
        profileImage.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getCash()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if let data = body["data"]{
                            self.cashLabel.text = data as! String + " $"
                        }
                    }
                }
            }
        }
    }
    
    func startConfetti(view: SwiftConfettiView){
        
        self.view.addSubview(self.viewConfeti!)
        view.startConfetti()
    }
    
    func stopConfetti(view: SwiftConfettiView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.stopConfetti()
            let confeti = self.view.viewWithTag(200)
            confeti!.removeFromSuperview()
        }
    }
}