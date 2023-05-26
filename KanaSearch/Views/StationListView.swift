//
//  StationListView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import SwiftUI

struct StationListView: View {
    
    let stationData: [Station]
    
    var body: some View {
        List(stationData, id: \.name) { station in
            Text(station.name)
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView(stationData: mockStationData)
    }
}
