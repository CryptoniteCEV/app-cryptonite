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
    
    private var normalDuration : TimeInterval = 1
    private var longDuration : TimeInterval = 2
    private var normalHeight : CGFloat = 110
    private var smallHeight : CGFloat = 80
    
    func levelUpBanner(title: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "logoNoText"))
        let banner = NotificationBanner(title: title, leftView: leftView, style: .info)
        banner.haptic = .heavy
        banner.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        banner.bannerHeight = self.normalHeight
        banner.titleLabel?.textColor = #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.2078431373, alpha: 1)
        banner.duration = self.longDuration
        
        banner.show()
    }
    
    func errorBanner(title: String, subtitle: String){
        let leftView = UIImageView(image: #imageLiteral(resourceName: "error"))
        let banner = NotificationBanner(title: title, subtitle: subtitle,leftView: leftView, style: .danger)
        banner.haptic = .heavy
        banner.bannerHeight = self.normalHeight
        banner.duration = self.longDuration
        
        banner.show()
    }
    
    func successBanner(title: String, subtitle: String){
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: .success)
        banner.haptic = .heavy
        banner.bannerHeight = self.normalHeight
        banner.duration = self.normalDuration
        banner.backgroundColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        banner.applyStyling(cornerRadius: .none, titleFont: .none, titleColor: #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1), titleTextAlign: .center, subtitleFont: .none, subtitleColor: #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.2784313725, alpha: 1), subtitleTextAlign: .center)
        
        banner.show()
    }
    
    func noConnectionBanner() {
        let banner = StatusBarNotificationBanner(title: "No Internet Connection", style: .danger)
        banner.autoDismiss = false
        banner.bannerHeight = self.smallHeight
        banner.show()
    }
    
    func creatorsBanner(){
           let leftView = UIImageView(image: #imageLiteral(resourceName: "logoNoText"))
           let banner = NotificationBanner(title: "Created by Alex Sergio Jesus and Jose", leftView: leftView, style: .info)
           banner.haptic = .heavy
           banner.dismissOnTap = false
           banner.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           banner.bannerHeight = self.normalHeight
           banner.titleLabel?.textColor = #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.2078431373, alpha: 1)
           banner.duration = self.longDuration
           
           banner.show()
       }
    
}
