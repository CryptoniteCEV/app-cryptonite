//
//  Banners.swift
//  CryptoniteCev
//
//  Created by user177260 on 3/10/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

class Banners{
    
    static let shared = Banners()
    
    private init(){}
    
    func levelUpBanner(title: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "logoNoText"))
        let banner = NotificationBanner(title: title, leftView: leftView, style: .info)
        banner.haptic = .heavy
        banner.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        banner.bannerHeight = 110
        banner.titleLabel?.textColor = #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.2078431373, alpha: 1)
        banner.duration = 1
        
        banner.show()
    }
    
    func errorBanner(title: String, subtitle: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "error"))
        let banner = NotificationBanner(title: title, subtitle: subtitle,leftView: leftView, style: .danger)
        banner.haptic = .heavy
        banner.bannerHeight = 110
        banner.duration = 1
        
        banner.show()
    }
    
    func noConnectionBanner() {
        let banner = StatusBarNotificationBanner(title: "No Internet Connection", style: .danger)
        banner.autoDismiss = false
        banner.show()
    }
    
    
    
    
}
