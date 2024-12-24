import Foundation

/*
 "C15YW36-A6F4SJ5-GZT90VW-HQ101Z4",
 "9XT7THK-V10M2RQ-NK75S9R-4FH54WN",
 "WPPQ8GB-46G44MM-MP8SDTD-A5SBYQF",
 "D81DBMK-5QYME3D-PBJ4EZT-XXZSXS7",
 "7DHV54B-H2X4ZZH-M30MAXA-MB2SXRT",
 "FEATHCQ-H1V4VQ3-K7DX2GN-8ZXPSKE",
 "RJZEC8T-XH2466H-GFBBAHE-VDTG3GJ",
 "ENCQSC1-NWEM7CV-JG01HJ3-W6GJBXD"
 */

final class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private let apiKey = "WPPQ8GB-46G44MM-MP8SDTD-A5SBYQF"
    private let baseURL = "https://api.kinopoisk.dev"
    
    private let session = URLSession.shared
    
    func createRequest(for fetchType: FetchesMovie) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + fetchType.path) else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = fetchType.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = ["X-API-KEY": apiKey]
        
        return request
    }
    
    func fetchData<T: Decodable>(from request: URLRequest) async throws -> T {
        do {
            let (data, responce) = try await session.data(for: request)
            
            guard let httpResponse = responce as? HTTPURLResponse else {
                throw NetworkError.invalidResponce
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error: error)
            }
        }
    }
}
