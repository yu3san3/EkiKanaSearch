//
//  MapView.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/27.
//

import SwiftUI
import MapKit

struct PinItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    let station: Station?
    
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        Map(
            coordinateRegion: $contentVM.region,
            showsUserLocation: true,
            userTrackingMode: $contentVM.userTrackingMode,
            annotationItems: generatePinItem()
        ) { item in
            MapMarker(coordinate: item.coordinate)
        }
        .onAppear {
            setTargetRegion()
        }
    }
}

extension MapView {
    private func generatePinItem() -> [PinItem] {
        guard let station = station else {
            return []
        }
        return [PinItem(coordinate: CLLocationCoordinate2D(latitude: station.y, longitude: station.x))]
    }
    
    private func setTargetRegion() {
        guard let station = station else {
            return
        }
        //マップの中央を移動
        contentVM.region.center = CLLocationCoordinate2D(latitude: station.y, longitude: station.x)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(station: mockStationData[0], contentVM: ContentViewModel())
    }
}
