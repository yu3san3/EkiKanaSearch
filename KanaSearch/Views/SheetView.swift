//
//  SheetView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import SwiftUI

struct SheetView: View {
    
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                Section {
                    if !contentVM.addressOfSpecifiedLocation.postalCode.isEmpty && !contentVM.addressOfSpecifiedLocation.adress.isEmpty {
                        adressSection
                    } else {
                        Text("")
                    }
                } header: {
                    Text("指定された場所")
                }
                Section {
                    searchTypePicker
                    switch contentVM.selectedSearchType {
                    case .station:
                        StationListView(stationData: contentVM.stationData)
                    case .town:
                        CityListView(cityData: contentVM.cityData)
                    }
                } header: {
                    Text("検索結果")
                }
            }
        }
    }
}

private extension SheetView {
    var searchTypePicker: some View {
        Picker("SearchType", selection: $contentVM.selectedSearchType) {
            ForEach(SearchType.allCases) { searchType in
                Text(searchType.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
    
    var adressSection: some View {
        VStack(alignment: .leading) {
            Text("〒\(contentVM.addressOfSpecifiedLocation.postalCode)")
            Text(contentVM.addressOfSpecifiedLocation.adress)
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(contentVM: ContentViewModel())
    }
}
