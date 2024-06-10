//
//  ContentView.swift
//  RegionSelectionViewDemo
//
//  Created by Marcel Opitz on 25.02.24.
//

import MapKit
import RegionSelectionView
import SwiftUI

struct ContentView: View {
    
    @State var selectedRect: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)
    @State var relativeSelectedRect: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200)
    
    private let mapView: MKMapView = MKMapView()
    
    var body: some View {
        RegionSelectionView(
            mapView: mapView,
            selectedRect: $selectedRect,
            relativeSelectedRect: $relativeSelectedRect,
            padding: .init(
                top: 24,
                left: 24,
                bottom: 24,
                right: 24),
            onBeginResizing: {
                mapView.isUserInteractionEnabled = false
            },
            onEndResizing: {
                mapView.isUserInteractionEnabled = true
            }
        ).sheet(isPresented: .constant(true)) {
            HStack(spacing: 8) {
                Button {
                    
                } label: {
                    Text("Cancel")
                        .foregroundStyle(Color.accentColor)
                        .padding()
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(8)
                
                Button {
                    onConfirm()
                } label: {
                    Text("Confirm")
                        .foregroundStyle(.white)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(8)
            }
            .padding()
            .presentationDetents([.height(78), .height(79)])
            .presentationBackgroundInteraction(.enabled)
            .presentationDragIndicator(.hidden)
            .presentationBackground(.regularMaterial)
            .interactiveDismissDisabled()
        }
    }
    
    private func onConfirm() {
        let selectedRegion = convertRectToRegion(
            relativeSelectedRect.inset(
                by: .init(top: 12, left: 12, bottom: 12, right: 12)))
        print("selected region: \(selectedRegion)")
    }
    
    private func convertRectToRegion(_ rect: CGRect) -> MKCoordinateRegion {
        return mapView.convert(rect, toRegionFrom: mapView)
    }
}
