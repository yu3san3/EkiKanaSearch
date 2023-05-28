//
//  ContentView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    
    @State private var shouldShowSheet: Bool = true
    
    var body: some View {
        ZStack {
            MapView(station: nil, contentVM: contentVM)
            VStack {
                searchButton
                currentLocationButton
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $shouldShowSheet) {
            SheetView(contentVM: contentVM)
                .presentationDetents([.height(65), .medium, .large])
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
        }
        .alert(isPresented: $contentVM.shouldShowAlert, error: contentVM.error) { _ in
            Button("OK", action: {})
        } message: { error in
            Text(error.errorDescription ?? "nil")
        }
    }
}

private extension ContentView {
    var searchButton: some View {
        Button(action: {
            contentVM.fetchStationData()
            contentVM.fetchCityData()
            print("button tapped")
        }) {
            Text("周辺を検索")
        }
        .padding(10)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(30)
    }
    
    var currentLocationButton: some View {
        Button(action: {
            
        }) {
            Image(systemName: "location")
        }
        .padding(10)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
