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

let mockStationData: [Station] = [
    Station(name: "日本へそ公園", prefecture: "兵庫県", line: "JR加古川線", x: 134.997633, y: 35.002069, distance: "320m", prev: Optional("比延"), next: Optional("黒田庄")),
    Station(name: "比延", prefecture: "兵庫県", line: "JR加古川線", x: 134.995733, y: 34.988773, distance: "1310m", prev: Optional("新西脇"), next: Optional("日本へそ公園")),
    Station(name: "黒田庄", prefecture: "兵庫県", line: "JR加古川線", x: 134.992522, y: 35.022689, distance: "2620m", prev: Optional("日本へそ公園"), next: Optional("本黒田"))
]
