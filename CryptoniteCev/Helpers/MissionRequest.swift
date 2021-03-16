//
//  MissionRequest.swift
//  CryptoniteCev
//
//  Created by Alejandro García on 14/3/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import Lottie

func isMissionFinished(parameters:[String:String]){
    if Service.isConnectedToInternet {
        if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
            
            let request = Service.shared.updateMission(params: parameters)
            
            request.responseJSON { (response) in
                print(response.value)
                if(response.response?.statusCode == StatusCodes.shared.OK){
                    Banners.shared.missionCompletedBanner(view: lottieAnim())
                }
            }
        }
    }
}

func lottieAnim() -> UIView {
    
    var animationView: AnimationView?
                
    animationView = .init(name: "gift")
    
    let view  = UIView()
                
    view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            
    animationView!.frame = view.bounds
                
    animationView!.loopMode = .loop
                
    animationView!.animationSpeed = 0.5
                
    view.addSubview(animationView!)
                
    animationView?.play()
    
    return view
    
}
