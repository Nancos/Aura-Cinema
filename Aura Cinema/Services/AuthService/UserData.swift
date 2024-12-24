//
//  UserData.swift
//  Aura Cinema
//
//  Created by MacBook Air on 16.01.25.
//

import Foundation

struct UserData: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    let name: String?
    let surname: String?
}
