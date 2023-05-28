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
                .ignoresSafeArea()
            VStack() {
                HStack {
                    searchButton
                    currentLocationButton
                }
                Spacer()
            }
            Image(systemName: "plus.viewfinder")
        }
        .sheet(isPresented: $shouldShowSheet) {
            SheetView(contentVM: contentVM)
                .presentationDetents([.height(85), .medium, .large]) //sheetのサイズを指定
                .presentationContentInteraction(.scrolls) //sheetのリサイズよりListのスクロールを優先
                .presentationBackgroundInteraction(.enabled) //sheetの背景ビューの操作を許可
                .interactiveDismissDisabled() //Dismissを制限
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
            contentVM.regeocoding(latitude: contentVM.region.center.latitude, longitude: contentVM.region.center.longitude) { adress, error in
                guard let adress = adress else {
                    print("Unknown error")
                    contentVM.addressOfSpecifiedLocation = (postalCode: "", adress: "")
                    return
                }
                contentVM.addressOfSpecifiedLocation = adress
            }
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
