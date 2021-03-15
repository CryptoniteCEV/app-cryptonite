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
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var onDoneBlock : (() -> Void)?
    
    var didLogout : (() -> Void)?
    
    var mainClass:MainScreenController?
    
    var experience : Double = 0
    
    let experiencePerMission : Double = 200
    
    let startingReward:Double = 250
    
    var level : Int = 0
    
    var prevLevel : Int = 0
    
    var missions:[Mission] = []
    
    let anim = SkeletonableAnim()
    
    @IBAction func mission1Cleared(_ sender: UIButton) {
        assigNewMission(parameters: ["id":String(missions[0].id)])
        getExperience()
        level = levelManagement()
        updateUser()
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    @IBAction func mission2Cleared(_ sender: UIButton) {
        assigNewMission(parameters: ["id":String(missions[1].id)])
        getExperience()
        level = levelManagement()
        updateUser()
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    @IBAction func mission3Cleared(_ sender: UIButton) {
        assigNewMission(parameters: ["id":String(missions[2].id)])
        getExperience()
        level = levelManagement()
        updateUser()
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    func updateUser() {
        updateExp(parameters: ["new_exp" : Int(experience)])
        if level != prevLevel  {
            deposit(parameters: ["quantity":calculateReward(level: level)])
        }
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
        
        self.levelLabel.text = String(Int(level))
        
        self.viewConfetti = SwiftConfettiView(frame: self.view.bounds)
        self.viewConfetti?.tag = 200
        
        missionsCard.layer.cornerRadius = 10
        walletCard.layer.cornerRadius = 10
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 4
        profileImage.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        
        anim.placeholder(view: cashLabel)
        anim.placeholder(view: mission1Label)
        anim.placeholder(view: mission2Label)
        anim.placeholder(view: mission3Label)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        getCash()
        getGamification()
        
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
    
    func neededExperience(level: Int) -> Double {
        if level != 0 {
            return neededExperience(level: level-1) + Double(level)  *  self.experiencePerMission
        }
        return 0
    }
    
    func getExperience(){
        experience += experiencePerMission
    }
    
    func levelManagement()->Int {
        prevLevel = level
        var n = 0
        while true {
            if experience < neededExperience(level: n)  {
                return n
            }
            n += 1
        }
    }
    
    func getCurrentLvl(experience:Double)->Int{
        var n = 0
        var level:Int = 0
        
        while true {
            if experience < neededExperience(level: n)  {
                level = n
                return level
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
    
    func getGamification(){
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let request = Service.shared.gamification()
                
                request.responseJSON { (response) in
                   
                    if let body = response.value as? [String:Any] {
                        
                        if let data = body["data"] as? [String:Any]{
                            
                            let missions = data["Missions"] as! [[String:Any]]
                           
                            let userInfo = data["User"] as! [String:Any]
                            
                            let user = UserMain(profilePic: Images.shared.users[(userInfo["ProfilePic"] as? Int)!], username: (userInfo["Username"] as? String)!, experience: (userInfo["Exp"] as? Double)!)
                            
                            self.missions = []
                            
                            for i in 0..<missions.count{
                                self.missions.append(Mission(id: missions[i]["id"] as! Int, icon: Missions.shared.missions[missions[i]["icon"] as! Int], description: missions[i]["description"] as! String, isFinished: missions[i]["is_finished"] as! Int))
                                
                            }
                            
                            self.setMissions()
                            self.experience = user.experience
                            self.level = self.getCurrentLvl(experience: user.experience)
                            self.setProgressLabel()
                            self.profileImage.image = user.profilePic
                            self.welcomeLabel.text = "Good earnings @" + user.username
                            self.levelLabel.text = String(self.level)
                            self.anim.hidePlaceholder(view: self.mission1Label)
                            self.anim.hidePlaceholder(view: self.mission2Label)
                            self.anim.hidePlaceholder(view: self.mission3Label)
                        }
                        
                    }
                }
            }
        }
        
    }
    
    func setMissions(){
        
        mission1Label.text = missions[0].description
        mission1Image.image = missions[0].icon
        if missions[0].isFinished == 0{
            mission1Button.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
            mission1Button.isEnabled = false
        }else{
            mission1Button.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            mission1Button.isEnabled = true
        }
        
        mission2Label.text = missions[1].description
        mission2Image.image = missions[1].icon
        if missions[1].isFinished == 0{
            mission2Button.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
            mission2Button.isEnabled = false
        }else{
            mission2Button.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            mission2Button.isEnabled = true
        }
        
        mission3Label.text = missions[2].description
        mission3Image.image = missions[2].icon
        if missions[2].isFinished == 0{
            mission3Button.backgroundColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
            mission3Button.isEnabled = false
        }else{
            mission3Button.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
            mission3Button.isEnabled = true
        }
        
    }
    
    func getCash(){
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getCash()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if let data = body["data"] as? String{
                            let cash = round(100*(Double(data)!))/100
                                
                            self.cashLabel.text = currencyFormatterTwoDecimals(numberToFormat: cash) + " $"
                            self.anim.hidePlaceholder(view: self.cashLabel)
                        }
                    }
                }
            }
        }
    }
    
    func assigNewMission(parameters:[String:String]){
        missions = []
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.assignNewMission(params: parameters)
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if let data = body["data"] as? [[String:Any]]{
                            
                            for i in 0..<data.count{
                                self.missions.append(Mission(id: data[i]["id"] as! Int, icon: Missions.shared.missions[data[i]["icon"] as! Int], description: data[i]["description"] as! String, isFinished: data[i]["is_finished"] as! Int))
                            }
                            self.setMissions()
                        }
                    }
                }
            }
        }
    }
    
    func updateExp(parameters:[String:Int]){
        missions = []
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.updateExp(params: parameters)
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        print(body)
                        if let message = body["message"] as? [String:Any]{
                            
                            print(message)
                        }
                    }
                }
            }
        }
    }
    
    func deposit(parameters:[String:Double]){
        
        if Service.isConnectedToInternet {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.desposit(params: parameters)
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        self.getCash()
                        Banners.shared.successBanner(title: "You have just received some free Doges", subtitle: "To the mooooon!")
                    }
                }
            }
        }
    }
    
    func calculateReward(level:Int)-> Double{
        
        return startingReward + (Double(level) * startingReward/2)
        
    }
}
