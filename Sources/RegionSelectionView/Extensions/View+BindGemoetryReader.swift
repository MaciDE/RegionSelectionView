//
//  View+BindGemoetryReader.swift
//
//
//  Created by Marcel Opitz on 25.02.24.
//

import SwiftUI

extension View {
    func readFrame(
        in coordinateSpace: CoordinateSpace = .global,
        for reader: Binding<CGRect>
    ) -> some View {
        readFrame(in: coordinateSpace) { value in
            reader.wrappedValue = value
        }
    }

    func readFrame(
        in coordinateSpace: CoordinateSpace = .global,
        for reader: @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: FramePreferenceKey.self,
                        value: geometryProxy.frame(in: coordinateSpace)
                )
                .onPreferenceChange(FramePreferenceKey.self, perform: reader)
            }
        )
    }
    
    func readSize(
        in coordinateSpace: CoordinateSpace = .global,
        for reader: Binding<CGSize>
    ) -> some View {
        readSize(in: coordinateSpace) { value in
            reader.wrappedValue = value
        }
    }
    
    func readSize(
        in coordinateSpace: CoordinateSpace = .global,
        for reader: @escaping (CGSize) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: SizePreferenceKey.self,
                        value: geometryProxy.size
                )
                .onPreferenceChange(SizePreferenceKey.self, perform: reader)
            }
        )
    }
    
    func readBounds(
        in namedCoordinateSpace: NamedCoordinateSpace,
        for reader: Binding<CGRect?>
    ) -> some View {
        readBounds(in: namedCoordinateSpace) { value in
            reader.wrappedValue = value
        }
    }

    func readBounds(
        in namedCoordinateSpace: NamedCoordinateSpace,
        for reader: @escaping (CGRect?) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(
                        key: BoundsPreferenceKey.self,
                        value: geometryProxy.bounds(of: namedCoordinateSpace)
                )
                .onPreferenceChange(BoundsPreferenceKey.self, perform: reader)
            }
        )
    }
}
    
private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue = CGRect.zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue = CGSize.zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct BoundsPreferenceKey: PreferenceKey {
    static var defaultValue: CGRect? = CGRect.zero

    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
        value = nextValue()
    }
}
