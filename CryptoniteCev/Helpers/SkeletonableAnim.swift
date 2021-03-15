//
//  SkeletonableAnim.swift
//  CryptoniteCev
//
//  Created by alumnos on 15/03/2021.
//  Copyright © 2021 user177257. All rights reserved.
//

import UIKit
import SkeletonView

class SkeletonableAnim: UIViewController {

   public  func placeholder(view : UIView){
         
         view.isSkeletonable = true
         let animation = GradientDirection.leftRight.slidingAnimation()
         let gradient = SkeletonGradient.init(baseColor: .midnightBlue)
         view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
         
     }
    public func hidePlaceholder(view : UIView){
        view.stopSkeletonAnimation()
        view.hideSkeleton()
    }
}
