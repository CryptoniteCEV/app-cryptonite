//
//  userMessages.swift
//  Agenda
//
//  Created by alumnos on 05/02/2021.
//  Copyright © 2021 Alejandro García. All rights reserved.
//

import Foundation


class UserMessages {
    
    static let shared = UserMessages()
    private init(){}
 
    //mensajes para mostrar al user
    let noMatchingPasswords = "Passwords do not match"
    let unknownUser = "This user does not exist"
    let passwordChanged = "Password succesfully changed"
    let invalidEmail = "Please enter a valid email"
    let invalidName = "Please enter a valid name"
    let invalidPass = "Please enter a valid password"
    let invalidUsername = "Please enter a valid username"
}
