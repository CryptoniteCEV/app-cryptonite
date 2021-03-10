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
    
    @IBOutlet weak var mission1Button: UIButton!
    
    @IBOutlet weak var mission2Button: UIButton!
    
    @IBOutlet weak var mission3Button: UIButton!
    
    
    
    
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet weak var cashLabel: UILabel!
    
    var experience : Int = 0
    
    var experiencePerMission = 200
    
    @IBAction func mission1Cleared(_ sender: UIButton) {
        experience += experiencePerMission
        claimRewards()
    }
    
    @IBAction func mission2Cleared(_ sender: UIButton) {
        experience += experiencePerMission
        claimRewards()
    }
    
    @IBAction func mission3Cleared(_ sender: UIButton) {
        experience += experiencePerMission
        claimRewards()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rewards"
        mission1Button.layer.cornerRadius = mission1Button.frame.width/2
        mission2Button.layer.cornerRadius = mission2Button.frame.width/2
        mission3Button.layer.cornerRadius = mission3Button.frame.width/2
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
        
        let level = GetLevel(exp: self.experiencePerMission)
        let nextlevel = NextLevelExp(level: level)
        let expLeft = nextlevel - self.experiencePerMission
        print(expLeft)
    }
    override func viewDidAppear(_ animated: Bool) {
        //navigationController?.setNavigationBarHidden(false, animated: true)
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
    
    func claimRewards() {
        self.startConfetti(view: self.viewConfeti!)
        self.stopConfetti(view: self.viewConfeti!)
    }
    
    func GetLevel(exp: Int) -> Int {
        return exp/self.experiencePerMission
    }
    func NextLevelExp(level: Int) -> Int {
        return (level + 1)  *  self.experiencePerMission
    }
}
