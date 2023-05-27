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
            .sheet(isPresented: $shouldShowSheet) {
                StationListView(stationData: mockStationData)
                    .presentationDetents([.height(50), .medium, .large])
                    .presentationBackgroundInteraction(.enabled)
                    .interactiveDismissDisabled()
            }
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
