//
//  MissionRequest.swift
//  CryptoniteCev
//
//  Created by Alejandro García on 14/3/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation

func isMissionFinished(parameters:[String:String]){
    if Service.isConnectedToInternet {
        if (UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil) {
            
            let request = Service.shared.updateMission(params: parameters)
            
            request.responseJSON { (response) in
                print(response.value)
                if(response.response?.statusCode == StatusCodes.shared.OK){
                    Banners.shared.successBanner(title: "Mission Accomplished", subtitle: "Claim Your Rewards")
                    
                }
            }
        }
    }
}