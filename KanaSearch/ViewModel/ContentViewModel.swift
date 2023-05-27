//
//  StationListView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import Foundation
import MapKit

final class ContentViewModel: ObservableObject {
    @Published var stationData: [Station] = []
    
    @Published var region = MKCoordinateRegion(  //座標領域
        center: CLLocationCoordinate2D(latitude: 35.4127, longitude: 138.2740),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published var shouldShowLoadingIndicator: Bool = false
    @Published var shouldShowAlert: Bool = false
    @Published var error: APIError?
    
    private let nearbyStationFetcher = NearbyStationFetcher()
    
    func fetchStationData() {
        Task { @MainActor in
            shouldShowLoadingIndicator = true
            defer {
                shouldShowLoadingIndicator = false
            }
            
            do {
                stationData = try await nearbyStationFetcher.fetchCityData(latitude: region.center.latitude, longitude: region.center.longitude)
                print("stationData: \(stationData), region: \(region.center.latitude)")
            } catch {
                if let apiError = error as? APIError {
                    self.error = apiError
                    shouldShowAlert = true
                } else if let error = error as? URLError, error.code == URLError.notConnectedToInternet {
                    self.error = APIError.network
                    shouldShowAlert = true
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
