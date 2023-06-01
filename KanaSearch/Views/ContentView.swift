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
            HStack(alignment: .bottom) {
                currentSpeedText
                Spacer()
                moveToCurrentLocationButton
            }
            .padding(.horizontal, 10)
            //offsetの初期値は画面中央かつ、offsetの値が小さくなるほどボタンの位置は上へ動く
            //screenHeight/2: 画面下端の座標を求める
            //-sheetHeight: 画面下端からsheetHeightの分だけ上へ
            //+85: sheetの上端から85だけ上へ
            .offset(y:  screenHeight/2 - sheetHeight - 85 )
            Image(systemName: "plus.viewfinder")
                .loading(isRefleshing: contentVM.shouldShowLoadingIndicator)
        }
        .sheet(isPresented: $shouldShowSheet) {
            GeometryReader { geometry in
                SheetView(contentVM: contentVM)
                    .presentationDetents([ //sheetのサイズを指定
                        .height(geometry.safeAreaInsets.bottom == 0 ? 155 : 145), //sageAreaの有無によって高さを変える
                        .medium,
                        .large
                    ])
                    .presentationBackgroundInteraction(.enabled) //sheetの背景ビューの操作を許可
                    .interactiveDismissDisabled() //Dismissを制限
                    .onChange(of: geometry.size.height) { _ in
                        if geometry.size.height < screenHeight/2 { //sheetが画面サイズの半分を超えたらsheetHeightを更新しない
                            sheetHeight = geometry.size.height
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
            Image(systemName: "info.circle")
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
