//
//  CityListView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/28.
//

import SwiftUI

struct CityListView: View {
    
    let cityData: [Location]
    
    var body: some View {
        if cityData.isEmpty {
            EmptyView()
        }
        ForEach(cityData) { city in
            VStack(alignment: .leading) {
                Text("\(city.prefecture)\(city.city) \(city.town)")
                    .bold()
                Text("\(String(format: "%.0f", city.distance))m \(city.cityKana) \(city.townKana)")
                    .font(.caption)
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(cityData: mockCityData)
    }
}
