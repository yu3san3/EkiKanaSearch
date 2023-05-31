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
                    HStack {
                        if !contentVM.addressOfSpecifiedLocation.postalCode.isEmpty &&  !contentVM.addressOfSpecifiedLocation.adress.isEmpty {
                            adressText
                        } else {
                            Text("-")
                        }
                        Spacer()
                        searchButton
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
    
    var adressText: some View {
        VStack(alignment: .leading) {
            Text("〒\(contentVM.addressOfSpecifiedLocation.postalCode)")
            Text(contentVM.addressOfSpecifiedLocation.adress)
        }
    }
    
    var searchButton: some View {
        Button(action: {
            contentVM.fetchStationData()
            contentVM.fetchCityData()
            contentVM.regeocoding(latitude: contentVM.region.center.latitude, longitude: contentVM.region.center.longitude) { adress, error in
                guard let adress = adress else {
                    print(error ?? "Unknown error")
                    contentVM.addressOfSpecifiedLocation = (postalCode: "", adress: "")
                    return
                }
                contentVM.addressOfSpecifiedLocation = adress
            }
        }) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                Text("周辺を検索")
            }
        }
        .padding(10)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(30)
    }
    
    var searchTypePicker: some View {
        Picker("SearchType", selection: $contentVM.selectedSearchType) {
            ForEach(SearchType.allCases) { searchType in
                Text(searchType.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(contentVM: ContentViewModel())
    }
}
