//
//  Error.swift
//  Aura Cinema
//
//  Created by MacBook Air on 25.12.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case httpError(statusCode: Int)
    case decodingError(error: Error)
    case invalidResponce
    case noData
    case unknown(error: Error)
    case sessionError(error: Error)
}
