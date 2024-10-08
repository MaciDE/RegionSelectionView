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
  let mapViewDidChangeVisibleRegion: ((_ mapView: MKMapView) -> Void)?
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapViewRepresentable
    
    init(parent: MapViewRepresentable) {
      self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
      return parent.overlayRendererFor?(mapView, overlay) ?? MKOverlayRenderer()
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      parent.mapViewDidChangeVisibleRegion?(mapView)
    }
  }
  
  init(
    mapView: MKMapView,
    overlayRendererFor: ((_: MKMapView, _: any MKOverlay) -> MKOverlayRenderer)? = nil,
    mapViewDidChangeVisibleRegion: ((_ mapView: MKMapView) -> Void)? = nil
  ) {
    self.mapView = mapView
    self.overlayRendererFor = overlayRendererFor
    self.mapViewDidChangeVisibleRegion = mapViewDidChangeVisibleRegion
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
