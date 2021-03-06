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
import BLTNBoard
import Lottie

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
    
    
    @IBOutlet var toWalletButton: UIButton!
    
    @IBOutlet var logoutButton: UIButton!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var onDoneBlock : (() -> Void)?
    
    var didLogout : (() -> Void)?
    
    var mainClass:MainScreenController?
    
    var experience : Double = 0
    
    let experiencePerMission : Double = 200
    
    let startingReward:Double = 250
    
    var level : Int = 0
    
    var prevLevel : Int = 0
    
    var cash:Double = 0
    
    var prevBalance:Double = 0
    
    var missions:[Mission] = []
    
    let anim = SkeletonableAnim()
    
    
    //Al pulsar el boton de completar mision se realiza la peticion de asignar nueva mision, se recibe la nueva experiencia, se comprueba el nivel, realiza la peticion de actualizar la experiencia del usuario, comprueba el nivel y coloca la barra de progreso
    @IBAction func mission1Cleared(_ sender: UIButton) {
        assigNewMission(parameters: ["id":String(missions[0].id)])
        getExperience()
        level = levelManagement()
        updateUser()
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    //Al pulsar el boton de completar mision se realiza la peticion de asignar nueva mision, se recibe la nueva experiencia, se comprueba el nivel, realiza la peticion de actualizar la experiencia del usuario, comprueba el nivel y coloca la barra de progreso
    @IBAction func mission2Cleared(_ sender: UIButton) {
        assigNewMission(parameters: ["id":String(missions[1].id)])
        getExperience()
        level = levelManagement()
        updateUser()
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    //Al pulsar el boton de completar mision se realiza la peticion de asignar nueva mision, se recibe la nueva experiencia, se comprueba el nivel, realiza la peticion de actualizar la experiencia del usuario, comprueba el nivel y coloca la barra de progreso
    @IBAction func mission3Cleared(_ sender: UIButton) {
        assigNewMission(parameters: ["id":String(missions[2].id)])
        getExperience()
        level = levelManagement()
        updateUser()
        checkHasLeveledUp()
        setProgressLabel()
    }
    
    //actualiza la experiencia del user y realiza la peticion de depositar doges si se ha subido de nivel
    func updateUser() {
        updateExp(parameters: ["new_exp" : Int(experience)])
        if level != prevLevel  {
            deposit(parameters: ["quantity":calculateReward(level: level)])
        }
    }
    
    //Boton que te conduce hacia la pantalla de wallet
    @IBAction func toWalletButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.onDoneBlock!()
        }
    }
    
    //este boton te redirige a la pantalla de login
    @IBAction func logout(_ sender: UIButton) {       
        UserDefaults.standard.removeObject(forKey: Identifiers.shared.auth)
        self.dismiss(animated: true) {
            self.didLogout!()
        }
    }
    
    //AL iniciarse el view imprime la barra de progreso, redondea los botones, se colocan los textos en los labels y crea el view de confetti
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rewards"
        circleProgressBar.setProgress(0.0, animated: false)
        
        roundButton(button: mission1Button)
        roundButton(button: mission2Button)
        roundButton(button: mission3Button)
        roundButton(button: toWalletButton)
        roundButton(button: logoutButton)
        
        self.levelLabel.text = String(Int(level))
        
        self.viewConfetti = SwiftConfettiView(frame: self.view.bounds)
        self.viewConfetti?.tag = 200
        
        missionsCard.layer.cornerRadius = 7
        walletCard.layer.cornerRadius = 7
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.borderWidth = 4
        profileImage.layer.borderColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        
        anim.placeholder(view: cashLabel)
        anim.placeholder(view: mission1Label)
        anim.placeholder(view: mission2Label)
        anim.placeholder(view: mission3Label)
        
    }
    //Al aparecer el view se realizan las peticiones de cash y gamificacion que rellenaran los datos de los labels de usuario y misiones
    override func viewDidAppear(_ animated: Bool) {
        getCash(fromMain: true)
        getGamification()
        bulletinManager.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bulletinManager.backgroundViewStyle = .dimmed
    }
    
    //redondea un boton
    func roundButton(button: UIButton) {
        button.layer.cornerRadius = 7
    }
    
    //inicia el confetti
    func startConfetti(view: SwiftConfettiView){
        
        self.view.addSubview(self.viewConfetti!)
        view.startConfetti()
    }
    //apaga el confetti
    func stopConfetti(view: SwiftConfettiView){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            view.stopConfetti()
            let confeti = self.view.viewWithTag(200)
            confeti!.removeFromSuperview()
            self.setProgressLabel()
        }
    }
    
    //al reclamar el premio se ejecuta el confetti
    func claimRewards() {
        self.startConfetti(view: self.viewConfetti!)
        self.stopConfetti(view: self.viewConfetti!)
    }    
    
    //experiencia necesaria para subir de nivel
    func neededExperience(level: Int) -> Double {
        if level != 0 {
            return neededExperience(level: level-1) + Double(level)  *  self.experiencePerMission
        }
        return 0
    }
    
    //nueva experiencia al subir de nivel
    func getExperience(){
        experience += experiencePerMission
    }
    
    //devuelve nivel del user
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
    
    //devuelve nivel del user
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
    
    //si el usuario ha subido de nivel se modifica el progress bar con animacion y el label de nivel
    func checkHasLeveledUp(){
        if level != prevLevel  {
            self.claimRewards()
            prevLevel = level
            DispatchQueue.main.async {
                self.circleProgressBar.setProgress(CGFloat(1), animated: true)
                Banners.shared.levelUpBanner(title: "Congrats! You have just reached level " + String(Int(self.level)))
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.bulletinManager.showBulletin(above: self)
                }
            }            
        }
        self.levelLabel.text = String(Int(level))
    }
    
    //se coloca la experiencia en el progress bar
    func setProgressLabel() {
        let progress = (experience - neededExperience(level: level-1)) / (neededExperience(level: level) - neededExperience(level: level - 1))
        self.circleProgressBar.setProgress(CGFloat(progress), animated: true)
    }
    
    //funcion que realiza la peticion para recibir los datos de la pantalla de gamificacion, tanto missiones como user
    func getGamification(){
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                
                let request = Service.shared.gamification()
                
                request.responseJSON { (response) in
                   
                    if let body = response.value as? [String:Any] {
                        
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
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
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    //Coloca las misiones en los labels e imagenes
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
    //peticion que recibe el cash del usuario logged
    func getCash(fromMain:Bool){
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.getCash()
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? String{
                                
                                if fromMain{
                                    
                                    self.cash = Double(data)!
                                    self.prevBalance = self.cash
                                    self.cashLabel.text = currencyFormatterTwoDecimals(numberToFormat: Double(self.cash)) + " $"
                                    
                                }else{
                                    
                                    self.prevBalance = self.cash
                                    self.cash = Double(data)!
                                        
                                    for i in 1...Int(self.calculateReward(level: self.level)) {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01 * Double(i) ) {
                                            if self.cash > self.prevBalance {
                                                self.prevBalance += 0.5
                                                self.cashLabel.textColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
                                                self.cashLabel.text = currencyFormatterTwoDecimals(numberToFormat: Double(self.prevBalance)) + " $"
                                            }else{
                                                self.cashLabel.text = currencyFormatterTwoDecimals(numberToFormat: Double(self.cash)) + " $"
                                                self.cashLabel.textColor = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1)
                                            }
                                        }
                                        
                                    }
                                }
                                
                                self.cashLabel.text = currencyFormatterTwoDecimals(numberToFormat: self.cash) + " $"
                                self.anim.hidePlaceholder(view: self.cashLabel)
                            }
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //asigna una nueva mision al hacer claim rewards
    func assigNewMission(parameters:[String:String]){
        missions = []
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.assignNewMission(params: parameters)
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if let data = body["data"] as? [[String:Any]]{
                                
                                for i in 0..<data.count{
                                    self.missions.append(Mission(id: data[i]["id"] as! Int, icon: Missions.shared.missions[data[i]["icon"] as! Int], description: data[i]["description"] as! String, isFinished: data[i]["is_finished"] as! Int))
                                }
                                self.setMissions()
                            }
                        }else{
                            attemptsMaxed = true
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //peticion que actualiza la experiencia al terminar una mision
    func updateExp(parameters:[String:Int]){
        missions = []
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.updateExp(params: parameters)
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode != StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //peticion que deposita doges en el wallet del usuario al subir de nivel
    func deposit(parameters:[String:Double]){
        
        if isConnected {
            if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
                let request = Service.shared.desposit(params: parameters)
                request.responseJSON { (response) in
                    if let body = response.value as? [String:Any] {
                        if(response.response?.statusCode != StatusCodes.shared.OK){
                            attemptsMaxed = false
                            if !unknownBanner.isDisplaying{
                                unknownBanner.show()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //calcula el premio recibido
    func calculateReward(level:Int)-> Double{
        
        return startingReward + (Double(level) * startingReward/2)
    }
    //muestra el bulletin de doge al subir de nivel
    lazy var bulletinManager: BLTNItemManager = {
        let page = showClaimLevelBanner()
        return BLTNItemManager(rootItem: page)
    }()
    
    //muestra el banner de reclamar doges al subir de nivel, ademas de recibir el nuevo dinero actualizado
    func showClaimLevelBanner() -> BLTNPageItem  {
        let page = BLTNPageItem(title: "To the moooon!!")
        page.image = #imageLiteral(resourceName: "dogecoin128")
        page.appearance.titleTextColor = #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.2078431373, alpha: 1)
        page.appearance.descriptionTextColor = #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.2078431373, alpha: 1)
        page.appearance.actionButtonColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        page.appearance.actionButtonCornerRadius = 7
        page.requiresCloseButton = false

        page.descriptionText = "Congratulations you have just received some DOGES. Keep digging!"
        page.actionButtonTitle = "Shut up and give me my money!"
        
        page.actionHandler = { (item: BLTNActionItem) in
            self.getCash(fromMain: false)
            self.bulletinManager.dismissBulletin()
        }
        
        return page
        
    }
}

