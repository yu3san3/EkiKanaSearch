//
//  StationListView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import SwiftUI

struct StationListView: View {
    
    let stationData: [Station]
    
    typealias LineColor = (name: String, color: Color)
    private let conventionalLines: [LineColor] = [
        (name: "東武", color: .blue),
        (name: "西武", color: .cyan),
        (name: "京成", color: .indigo),
        (name: "京王", color: .pink),
        (name: "東急", color: .red),
        (name: "京浜急行", color: .teal),
        (name: "小田急", color: .teal),
        (name: "相模鉄道", color: .cyan),
        (name: "名鉄", color: .red),
        (name: "近鉄", color: .cyan),
        (name: "南海", color: .orange),
        (name: "京阪", color: .indigo),
        (name: "阪神", color: .blue),
        (name: "阪急", color: .red),
        (name: "西鉄", color: .blue)
    ]
    
    var body: some View {
        if stationData.isEmpty {
            EmptyView()
        }
        ForEach(stationData) { station in
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    if station.line.contains("新幹線") {
                        Image(systemName: "train.side.front.car")
                            .foregroundColor(Color.blue)
                    }
                    //電車のImageとその路線色
                    ForEach(conventionalLines, id: \.name) { line in
                        if station.line.contains(line.name) {
                            Image(systemName: "tram.fill")
                                .foregroundColor(line.color)
                        }
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
