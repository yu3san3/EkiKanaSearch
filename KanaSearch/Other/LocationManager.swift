//
//  LocationManager.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/29.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location = CLLocation()
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization() //位置情報の利用許可アラートを表示
        self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters //位置情報の正確さを指定
        self.manager.distanceFilter = 3 //位置情報の更新頻度(m)
        self.manager.startUpdatingLocation() //追跡を開始
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        print("🌍Location Updated!")
    }
}
