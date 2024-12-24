//
//  MovieServiceError.swift
//  Aura Cinema
//
//  Created by MacBook Air on 4.01.25.
//

import Foundation

enum MovieServiceError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingFailed
    case apiError(message: String)
}
