//
//  Place.swift
//  Cat
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import MapKit

class Place: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(latitude: Double, longitude: Double) {
        self.coordinate = CLLocationCoordinate2D()
        self.coordinate.latitude = latitude
        self.coordinate.longitude = longitude
    }
}
