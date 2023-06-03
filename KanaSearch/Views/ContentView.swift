//
//  ContentView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/26.
//
//  2023/05/29 Alpha 1.0.0(1)
//             Alpha 1.0.1(2)
//             Alpha 1.1.0(3)
//             Alpha 1.2.0(4)
//             Alpha 1.3.0(5)
//             Alpha 1.4.0(6)

import SwiftUI

let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let appBuildNum = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

struct ContentView: View {
    
    @StateObject var contentVM = ContentViewModel()
    
    @StateObject var locationManager = LocationManager()
    
    @State private var shouldShowSearchResultView: Bool = true
    
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var sheetHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                MapView(station: nil, contentVM: contentVM)
                    .loading(isRefleshing: contentVM.shouldShowLoadingIndicator)
                    .ignoresSafeArea()
                HStack(alignment: .bottom) {
                    currentSpeedText
                    Spacer()
                    moveToCurrentLocationButton
                }
                .padding(.horizontal, 10)
                //offsetの値が小さくなるほどボタンの位置は上へ動く
                //sheetHeight: 画面下端からsheetHeightの分だけ上へ
                //15: sheetの上端からの移動分
                .offset(y:  -(sheetHeight + 15) )
            }
            VStack {
                HStack {
                    infoButton
                        .padding(.horizontal, 10)
                    Spacer()
                }
                Spacer()
            }
            Image(systemName: "plus.viewfinder")
        }
        .sheet(isPresented: $shouldShowSearchResultView) { //常にtrue
            GeometryReader { geometry in
                SearchResultView(contentVM: contentVM)
                    .presentationDetents([ //sheetのサイズを指定
                        .height(geometry.safeAreaInsets.bottom == 0 ? 155 : 145), //sageAreaの有無によって高さを変える
                        .medium,
                        .large
                    ])
                    .presentationBackgroundInteraction(.enabled) //sheetの背景ビューの操作を許可
                    .interactiveDismissDisabled() //Dismissを制限
                    .onChange(of: geometry.size.height) { height in
                        if height < screenHeight/2 { //sheetが画面サイズの半分を超えたらsheetHeightを更新しない
                            self.sheetHeight = height
                        }
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
    
    var currentSpeedText: some View {
        Text("\(meterPerSecondToKilometerPerHour(speed: locationManager.location.speed)) km/h")
            .font(.title2)
            .foregroundColor(Color.white)
            .padding(6)
            .background(Color.black)
            .opacity(0.6)
    }
    
    var moveToCurrentLocationButton: some View {
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
            Image(systemName: "line.3.horizontal")
        }
        .padding(10)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(30)
    }
    
    func meterPerSecondToKilometerPerHour(speed: Double) -> Int {
        if speed < 0 {
            return 0
        }
        return Int(speed*3.6)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
