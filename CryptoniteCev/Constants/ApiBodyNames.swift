//
//  ApiBodyNames.swift
//  CryptoniteCev
//
//  Created by Alejandro García on 28/2/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import Foundation

class ApiBodyNames {

    private init() {}

    static let shared = ApiBodyNames()
    
    //nombres pasados por el key en los parametros que recibira la api
    let email = "email"
    let username = "username"
    let password = "password"
    let newPassword = "new_password"
    let apiToken = "Authorization"

}
