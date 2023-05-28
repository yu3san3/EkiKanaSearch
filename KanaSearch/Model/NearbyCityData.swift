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
        case nearbyCityResponse = "response"
    }
}

struct NearbyCityResponse: Codable {
    let location: [Location]
    
    enum CodingKeys: String, CodingKey {
        case location
    }
}

struct Location: Codable, Identifiable {
    let id = UUID()
    let city: String
    let cityKana: String
    let town: String
    let townKana: String
    let distance: Double
    let prefecture: String
    
    enum CodingKeys: String, CodingKey {
        case city
        case cityKana = "city_kana"
        case town
        case townKana = "town_kana"
        case distance
        case prefecture
    }
}

let mockCityData: [Location] = [
    Location(city: "西脇市", cityKana: "にしわきし", town: "上比延町", townKana: "かみひえちょう", distance: 491.18291654385115, prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "比延町", townKana: "ひえちょう", distance: 570.5714194119806, prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "大垣内", townKana: "おおがち", distance: 604.951823953359, prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "嶋", townKana: "しま", distance: 914.7175105156429, prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "寺内", townKana: "てらうち", distance: 1027.7956369195333, prefecture: "兵庫県")
]
