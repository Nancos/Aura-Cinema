//
//  Filmography.swift
//  Aura Cinema
//
//  Created by MacBook Air on 19.01.25.
//

// MARK: - PersonModelData
struct PersonModelData: Codable {
    let id: Int
    let name: String?
    let enName: String?
    let photo: String?
    let sex: String?
    let growth: Int?
    let birthday: String?
    let death: String?
    let age: Int?
    let movies: [Filmography]?
}

// MARK: - Filmography
struct Filmography: Codable {
    let id: Int?
    let name: String?
    let rating: Double?
    let description: String?
}
