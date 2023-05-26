//
//  NearbyStationData.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import Foundation

struct NearbyStationData: Codable {
    let response: Response
}

struct Response: Codable {
    let station: [Station]
}

struct Station: Codable {
    let name: String
    let prefecture: String
    let line: String
    let x: Double
    let y: Double
    let distance: String
    let prev: String?
    let next: String?
}
