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
import NotificationBannerSwift

class GamificationController: UIViewController {
    
    @IBOutlet var circleProgressBar: CircleProgressBar!
    
    @IBOutlet var levelLabel: UILabel!
    
    @IBOutlet var missionsCard: UIView!
    
    @IBOutlet var walletCard: UIView!
    
    var viewConfetti: SwiftConfettiView?
    
    @IBOutlet weak var mission1Button: UIButton!
    
    @IBOutlet weak var mission2Button: UIButton!
    
    @IBOutlet weak var mission3Button: UIButton!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet weak var cashLabel: UILabel!
    
    @IBOutlet weak var mission1Image: UIImageView!
    @IBOutlet weak var mission1Label: UILabel!
    
    
    @IBOutlet weak var mission2Image: UIImageView!
    @IBOutlet weak var mission2Label: UILabel!
    
    @IBOutlet weak var mission3Image: UIImageView!
    @IBOutlet weak var mission3Label: UILabel!
    
    
    var onDoneBlock : (() -> Void)?
    
    var didLogout : (() -> Void)?
    
    var mainClass:MainScreenController?
    
    var experience : Double = 0
    
    var experiencePerMission : Double = 200
    
    var level : Double = 0
    
    var prevLevel : Double = 0
    
    
    @IBAction func mission1Cleared(_ sender: UIButton) {
        getExperience()
        level = levelManagement()!
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    @IBAction func mission2Cleared(_ sender: UIButton) {
        getExperience()
        level = levelManagement()!
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    @IBAction func mission3Cleared(_ sender: UIButton) {
        getExperience()
        level = levelManagement()!
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func toWalletButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.onDoneBlock!()
        }
    }
    
    @IBAction func logout(_ sender: UIButton) {       
        UserDefaults.standard.removeObject(forKey: Identifiers.shared.auth)
        self.dismiss(animated: true) {
            self.didLogout!()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rewards"
        circleProgressBar.setProgress(0.0, animated: false)
        
        roundButton(button: mission1Button)
        roundButton(button: mission2Button)
        roundButton(button: mission3Button)
        
        setMissions(missionImage: mission1Image, missionTittle: mission1Label)
        setMissions(missionImage: mission2Image, missionTittle: mission2Label)
        setMissions(missionImage: mission3Image, missionTittle: mission3Label)
        
        level = levelManagement()!
        self.levelLabel.text = String(Int(level))
        
        print("Hola " + String(Missions.shared.missions[1].title))
        
        self.viewConfetti = SwiftConfettiView(frame: self.view.bounds)
        self.viewConfetti?.tag = 200
        
        missionsCard.layer.cornerRadius = 10
        walletCard.layer.cornerRadius = 10
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 4
        profileImage.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //navigationController?.setNavigationBarHidden(false, animated: true)
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getCash()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if let data = body["data"] as? String{
                            let cash = round(100*(Double(data)!))/100
                                
                            self.cashLabel.text = String(cash) + " $"
                        }
                    }
                }
            }
        }
    }
    func setMissions(missionImage: UIImageView, missionTittle: UILabel) {
        var index = Int.random(in: 0...Missions.shared.missions.count-1)
        missionImage.image = Missions.shared.missions[index].image
        missionTittle.text = Missions.shared.missions[index].title
    }
    
    func roundButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.width/2
    }
    
    func startConfetti(view: SwiftConfettiView){
        
        self.view.addSubview(self.viewConfetti!)
        view.startConfetti()
    }
    
    func stopConfetti(view: SwiftConfettiView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.stopConfetti()
            let confeti = self.view.viewWithTag(200)
            confeti!.removeFromSuperview()
            self.setProgressLabel()
        }
    }
    
    func claimRewards() {
        self.startConfetti(view: self.viewConfetti!)
        self.stopConfetti(view: self.viewConfetti!)
    }    
    
    func neededExperience(level: Double) -> Double {
        if level != 0 {
            return neededExperience(level: level-1) + level  *  self.experiencePerMission
        }
        return 0
    }
    
    func getExperience() {
        experience += experiencePerMission
    }
    
    func levelManagement()->Double? {
        prevLevel = level
        var n = 0
        while true {
            if experience < neededExperience(level: Double(n))  {
                level = Double(n)
                return Double(n)
            }
            n += 1
        }
    }
    func checkHasLeveledUp(){
        if level != prevLevel  {
            self.claimRewards()
            prevLevel = level
            DispatchQueue.main.async {
                self.circleProgressBar.setProgress(CGFloat(1), animated: true)
                Banners.shared.levelUpBanner(title: "Congrats! You have just reached level " + String(Int(self.level)))
            }            
        }
        self.levelLabel.text = String(Int(level))
    }
    
    func setProgressLabel() {
        let progress = (experience - neededExperience(level: level-1)) / (neededExperience(level: level) - neededExperience(level: level - 1))
        self.circleProgressBar.setProgress(CGFloat(progress), animated: true)
    }
}
