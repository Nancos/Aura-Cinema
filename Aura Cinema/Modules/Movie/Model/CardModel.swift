import UIKit

final class CardModel {
    private let movieService = MovieService.shared
    
    func getCardData(kpId: Int) async throws -> MovieCardData {
        do {
            let cardData: MovieCardData = try await movieService.fetch(.movieCard(kpId))
            return cardData
        } catch {
            throw error
        }
    }
    
    func getTrailerData(kpId: Int) async throws -> [TrailerInfo] {
        do {
            let trailersData: TrailerData = try await movieService.fetch(.trailer(kpId))
            return trailersData.docs
        } catch {
            throw error
        }
    }
}
