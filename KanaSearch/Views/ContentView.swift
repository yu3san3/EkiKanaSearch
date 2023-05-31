//
//  ContentView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/26.
//
//  2023/05/29 Alpha 1.0.0(1)
//             Alpha 1.0.1(2)
//             Alpha 1.1.0(3)

import SwiftUI

//バージョン情報
let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//ビルド情報
let appBuildNum = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    
    @StateObject var locationManager = LocationManager()
    
    @State private var shouldShowSheet: Bool = true
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var sheetHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            MapView(station: nil, contentVM: contentVM)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    infoButton
                        .padding(.horizontal, 10)
                }
                Spacer()
            }
            HStack {
                Spacer()
                currentLocationButton
                    .padding(.horizontal, 10)
                    .offset(y: screenHeight/2 - sheetHeight - 75)
            }
            Image(systemName: "plus.viewfinder")
        }
        .sheet(isPresented: $shouldShowSheet) {
            GeometryReader { geometry in
                SheetView(contentVM: contentVM)
                    .presentationDetents([.height(115), .medium, .large]) //sheetのサイズを指定
                    .presentationBackgroundInteraction(.enabled) //sheetの背景ビューの操作を許可
                    .interactiveDismissDisabled() //Dismissを制限
                    .onChange(of: geometry.size.height) { _ in
                        if geometry.size.height < screenHeight/2 { //sheetが画面サイズの半分を超えたらsheetHeightを更新しない
                            sheetHeight = geometry.size.height
                        }
                        print(sheetHeight)
                    }
                    
            }
        }
        .alert(isPresented: $contentVM.shouldShowAlert, error: contentVM.error) { _ in
            Button("OK", action: {})
        } message: { error in
            Text(error.errorDescription ?? "nil")
        }
    }
}

private extension ContentView {
    
    var currentLocationButton: some View {
        Button(action: {
            withAnimation {
                contentVM.userTrackingMode = .follow
            }
        }) {
            switch contentVM.userTrackingMode {
            case .none:
                Image(systemName: "location")
            case .follow:
                Image(systemName: "location.fill")
            default:
                let _ = print("Unknown userTrackingMode")
            }
        }
        .padding(15)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(30)
    }
    
    var infoButton: some View {
        Button(action: {
            contentVM.addressOfSpecifiedLocation.postalCode = "-"
            contentVM.addressOfSpecifiedLocation.adress = "Version \(appVersion)(\(appBuildNum))"
        }) {
            Image(systemName: "info.circle")
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
