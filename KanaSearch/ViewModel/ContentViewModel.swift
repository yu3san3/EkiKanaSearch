//
//  StationListView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import SwiftUI
import MapKit

final class ContentViewModel: ObservableObject {
    
    @Published var stationData: [Station] = []
    @Published var cityData: [Location] = []
    @Published var selectedSearchType: SearchType = .station
    @Published var addressOfSpecifiedLocation: (postalCode: String, adress: String) = (postalCode: "", adress: "") //指定された場所の住所
    
    @Published var region = MKCoordinateRegion(  //座標領域
        center: CLLocationCoordinate2D(latitude: 35.6814, longitude: 139.7657),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Published var userTrackingMode: MapUserTrackingMode = .none
    
    @Published var shouldShowLoadingIndicator: Bool = false
    @Published var shouldShowAlert: Bool = false
    @Published var error: APIError?
    
    private let nearbyStationDataFetcher = NearbyStationDataFetcher()
    private let nearbyCityDataFetcher = NearbyCityDataFetcher()
    
    func fetchStationData() {
        Task { @MainActor in
            shouldShowLoadingIndicator = true
            defer {
                shouldShowLoadingIndicator = false
            }
            
            do {
                stationData = try await nearbyStationDataFetcher.fetchNearbyStationData(latitude: region.center.latitude, longitude: region.center.longitude)
            } catch {
                if let apiError = error as? APIError {
                    print(error)
                    self.error = apiError
                    shouldShowAlert = true
                } else if let error = error as? URLError, error.code == URLError.notConnectedToInternet {
                    print(error)
                    self.error = APIError.network
                    shouldShowAlert = true
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchCityData() {
        Task { @MainActor in
            shouldShowLoadingIndicator = true
            defer {
                shouldShowLoadingIndicator = false
            }
            
            do {
                cityData = try await nearbyCityDataFetcher.fetchNearbyCityData(latitude: region.center.latitude, longitude: region.center.longitude)
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
    
    func regeocoding(latitude: Double, longitude: Double, completion: @escaping ((postalCode: String, adress: String)?, Error?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil,
                  let administrativeArea = placemark.administrativeArea, // 都道府県
                  let locality = placemark.locality, // 市区町村
                  let thoroughfare = placemark.thoroughfare, // 地名(丁目)
                  let subThoroughfare = placemark.subThoroughfare, // 番地
                  let postalCode = placemark.postalCode // 郵便番号
            else {
                Task { @MainActor in
                     completion(nil, error)
                }
                return
            }
            Task { @MainActor in
                completion((postalCode: postalCode, adress: "\(administrativeArea)\(locality)\n\(thoroughfare)\(subThoroughfare)"), nil)
            }
        }
    }
}
