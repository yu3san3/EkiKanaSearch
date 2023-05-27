//
//  ContentView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shouldShowSheet: Bool = true
    
    var body: some View {
        MapView(station: nil)
            .ignoresSafeArea()
            .sheet(isPresented: $shouldShowSheet) {
                StationListView(stationData: mockStationData)
                    .presentationDetents([.medium, .large])
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
