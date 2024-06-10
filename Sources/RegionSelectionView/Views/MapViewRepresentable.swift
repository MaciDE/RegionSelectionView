//
//  MapViewRepresentable.swift
//  
//
//  Created by Marcel Opitz on 02.03.24.
//

import MapKit
import SwiftUI

struct MapViewRepresentable: UIViewRepresentable {
    let mapView: MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) { }
}
