//
//  NearbyCityData.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/28.
//

import Foundation

struct NearbyCityData: Codable {
    let nearbyCityResponse: NearbyCityResponse
    
    enum CodingKeys: String, CodingKey {
        case nearbyCityResponse
    }
}

struct NearbyCityResponse: Codable {
    let location: [Location]
    
    enum CodingKeys: String, CodingKey {
        case location
    }
}

struct Location: Codable {
    let city: String
    let cityKana: String
    let town: String
    let townKana: String
    let prefecture: String
    
    enum CodingKeys: String, CodingKey {
        case city
        case cityKana = "city_kana"
        case town
        case townKana = "town_kana"
        case prefecture
    }
}
