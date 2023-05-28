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

let mockCityData: [Location] = [
    Location(city: "西脇市", cityKana: "にしわきし", town: "上比延町", townKana: "かみひえちょう", prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "比延町", townKana: "ひえちょう", prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "大垣内", townKana: "おおがち", prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "嶋", townKana: "しま", prefecture: "兵庫県"),
    Location(city: "西脇市", cityKana: "にしわきし", town: "寺内", townKana: "てらうち", prefecture: "兵庫県")
]
