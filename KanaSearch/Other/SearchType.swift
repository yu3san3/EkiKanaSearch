//
//  SearchType.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/28.
//

import Foundation

enum SearchType: String, CaseIterable, Identifiable {
    case station = "駅名検索"
    case town = "地名検索"
    var id: Self { self }
}
