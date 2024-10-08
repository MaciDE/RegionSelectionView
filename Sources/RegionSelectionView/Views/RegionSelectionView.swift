//
//  RegionSelectionView.swift
//
//
//  Created by Marcel Opitz on 02.03.24.
//

import MapKit
import SwiftUI

public struct RegionSelectionView: View {
  
  @Binding var selectedRect: CGRect
  @Binding var relativeSelectedRect: CGRect
  @Binding var showCheckerboard: Bool
  @Binding var showResizableRectangle: Bool
  
  private let mapView: MKMapView
  
  private let padding: UIEdgeInsets?
  
  private let onBeginResizing: (() -> ())?
  private let onEndResizing: (() -> ())?
  
  // MKMapViewDelegate
  private let overlayRendererFor: ((_ mapView: MKMapView, _ overlay: any MKOverlay) -> MKOverlayRenderer)?
  private let mapViewDidChangeVisibleRegion: ((_ mapView: MKMapView) -> Void)?
  
  public var body: some View {
    ZStack {
      MapViewRepresentable(
        mapView: mapView,
        overlayRendererFor: overlayRendererFor,
        mapViewDidChangeVisibleRegion: mapViewDidChangeVisibleRegion
      )
      
      if showCheckerboard {
        ZStack {
          Checkerboard(boxSize: 10)
            .ignoresSafeArea()
            .opacity(0.1)
            .allowsHitTesting(false)
          
          RoundedRectangle(cornerRadius: 22.0)
            .inset(by: 12)
            .opacity(1)
            .frame(
              width: selectedRect.width,
              height: selectedRect.height
            )
            .offset(x: selectedRect.origin.x, y: selectedRect.origin.y)
            .blendMode(.destinationOut)
            .allowsHitTesting(false)
        }.compositingGroup()
      }

      if showResizableRectangle {
        ResizableRectangle(
          rect: $selectedRect,
          relativeRect: $relativeSelectedRect,
          min: .init(width: 110, height: 110),
          padding: padding,
          onBeginResizing: {
            onBeginResizing?()
          },
          onEndResizing: {
            onEndResizing?()
          })
      }
    }
    .ignoresSafeArea()
    .coordinateSpace(name: "resizeTargetArea")
  }
  
  public init(
    mapView: MKMapView,
    selectedRect: Binding<CGRect>,
    relativeSelectedRect: Binding<CGRect>,
    onBeginResizing: (() -> ())? = nil,
    onEndResizing: (() -> ())? = nil,
    padding: UIEdgeInsets? = nil,
    showCheckerboard: Binding<Bool>? = nil,
    showResizableRectangle: Binding<Bool>? = nil,
    overlayRendererFor: ((_ mapView: MKMapView, _ overlay: any MKOverlay) -> MKOverlayRenderer)? = nil,
    mapViewDidChangeVisibleRegion: ((_ mapView: MKMapView) -> Void)? = nil
  ) {
    self.mapView = mapView
    self._selectedRect = selectedRect
    self._relativeSelectedRect = relativeSelectedRect
    self.onBeginResizing = onBeginResizing
    self.onEndResizing = onEndResizing
    self.padding = padding
    self._showCheckerboard = showCheckerboard ?? .constant(true)
    self._showResizableRectangle = showResizableRectangle ?? .constant(true)
    self.overlayRendererFor = overlayRendererFor
    self.mapViewDidChangeVisibleRegion = mapViewDidChangeVisibleRegion
  }
}
