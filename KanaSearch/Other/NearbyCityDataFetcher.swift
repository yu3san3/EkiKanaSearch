//
//  NearbyCityDataFetcher.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/28.
//

import Foundation

final class NearbyCityDataFetcher {
    
    func fetchCityData(latitude: Double, longitude: Double) async throws -> [Location] {
        
        let url = URL(string: "https://geoapi.heartrails.com/api/json?method=searchByGeoLocation&x=\(longitude)&y=\(latitude)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.response
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let resultData = try JSONDecoder().decode(NearbyCityData.self, from: data)
                return resultData.nearbyCityResponse.location
            } catch {
                throw APIError.jsonDecode
            }
        default:
            throw APIError.statusCode(statusCode: httpResponse.statusCode.description)
        }
    }
}
