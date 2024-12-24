//
//  CardModel.swift
//  Aura Cinema
//
//  Created by MacBook Air on 30.12.24.
//
import UIKit

class CardModel {
    private let movieService = MovieService()
    
    func getCardData(kpId: Int) async throws -> MovieCardData {
        do {
            let cardData = try await movieService.fetchMovieCard(id: kpId)
            return cardData
        } catch {
            throw error
        }
    }
    
    func getTrailerData(kpId: Int) async throws -> [TrailerInfo] {
        do {
            let trailersData = try await movieService.fetchTrailers(for: .trailer(kpId))
            return trailersData
        } catch {
            throw error
        }
    }
}
