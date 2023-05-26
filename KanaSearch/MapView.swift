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
    @State private var region = MKCoordinateRegion() //座標領域
    @State private var userTrackingMode: MapUserTrackingMode = .none
    var coordinate: CLLocationCoordinate2D? //中心位置
    var latitude: Double
    var longitude: Double
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: [
                PinItem(coordinate: .init(latitude: latitude, longitude: longitude))
            ],
            annotationContent: { item in
                MapMarker(coordinate: item.coordinate)
            }
        )
        .onAppear {
            setRegion(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }
    }
    
    private func setRegion(coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0009, longitudeDelta: 0.0009))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(latitude: 35, longitude: 135)
    }
}
