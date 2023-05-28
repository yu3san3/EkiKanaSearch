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
        if stationData.isEmpty {
            EmptyView()
        }
        List(stationData) { station in
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    if station.line.contains("新幹線") {
                        Image(systemName: "train.side.front.car")
                            .foregroundColor(Color.blue)
                    }
                    Text("\(station.name)駅")
                        .bold()
                }
                Text("\(station.distance) \(station.line)")
                    .font(.callout)
            }
        }
    }
}

struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView(stationData: mockStationData)
    }
}
