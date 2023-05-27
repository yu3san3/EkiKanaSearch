//
//  SheetView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import SwiftUI


enum SearchType: String, CaseIterable, Identifiable {
    case station = "駅名検索"
    case town = "地名検索"
    var id: Self { self }
}

struct SheetView: View {
    
    let stationData: [Station]
    
    @State private var selectedSearchType: SearchType = .station
    
    var body: some View {
        VStack(spacing: 0) {
            searchTypePicker
            StationListView(stationData: stationData)
        }
    }
}

private extension SheetView {
    var searchTypePicker: some View {
        Picker("SearchType", selection: $selectedSearchType) {
            ForEach(SearchType.allCases) { searchType in
                Text(searchType.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(stationData: mockStationData)
    }
}
