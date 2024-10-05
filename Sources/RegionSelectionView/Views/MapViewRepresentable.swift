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
  let overlayRendererFor: ((_ mapView: MKMapView, _ overlay: any MKOverlay) -> MKOverlayRenderer)?
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapViewRepresentable
    
    init(parent: MapViewRepresentable) {
      self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
      return parent.overlayRendererFor?(mapView, overlay) ?? MKOverlayRenderer()
    }
  }
  
  init(mapView: MKMapView, overlayRendererFor: ((_: MKMapView, _: any MKOverlay) -> MKOverlayRenderer)? = nil) {
    self.mapView = mapView
    self.overlayRendererFor = overlayRendererFor
  }
  
  func makeUIView(context: Context) -> MKMapView {
    mapView.delegate = context.coordinator
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(parent: self)
  }
}
