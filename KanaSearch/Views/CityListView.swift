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
        List(cityData, id: \.town) { city in
            Text(city.town)
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(cityData: mockCityData)
    }
}
