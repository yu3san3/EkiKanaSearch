//
//  NearbyStationFetcher.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import Foundation

final class NearbyStationFetcher {
    
    func fetchCityData(latitude: Double, longitude: Double) async throws -> [Station] {
        
        let url = URL(string: "https://express.heartrails.com/api/json?method=getStations&x=\(longitude)&y=\(latitude)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.response
        }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let resultData = try JSONDecoder().decode(NearbyStationData.self, from: data)
                print("success!! \(resultData)")
                return resultData.response.station
            } catch {
                print("error")
                throw APIError.jsonDecode
            }
        default:
            throw APIError.statusCode(statusCode: httpResponse.statusCode.description)
        }
    }
}
