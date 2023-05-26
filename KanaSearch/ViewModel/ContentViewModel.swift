//
//  StationListView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import Foundation

final class ContentViewModel: ObservableObject {
    @Published var stationData: [Station] = []
    
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
                stationData = try await nearbyStationFetcher.fetchCityData()
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
