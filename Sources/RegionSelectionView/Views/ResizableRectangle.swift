//
//  ResizableRectangle.swift
//
//
//  Created by Marcel Opitz on 25.02.24.
//

import SwiftUI

struct ResizableRectangle: View {
  
  enum Position {
    case top, left, bottom, right
  }
  
  @Binding public var rect: CGRect
  @State private var previousRect: CGRect?
  @Binding public var relativeRect: CGRect
  @State private var isResizing: Bool = false
  
  private let maxRect: CGSize?
  private let minRect: CGSize
  private let padding: UIEdgeInsets?
  
  private let onBeginResizing: (() -> ())?
  private let onEndResizing: (() -> ())?
  
  public init(
    rect: Binding<CGRect>,
    relativeRect: Binding<CGRect>,
    max: CGSize? = nil,
    min: CGSize,
    padding: UIEdgeInsets? = nil,
    onBeginResizing: (() -> ())? = nil,
    onEndResizing: (() -> ())? = nil
  ) {
    self._rect = rect
    self._relativeRect = relativeRect
    self.maxRect = max
    self.minRect = min
    self.padding = padding
    self.onBeginResizing = onBeginResizing
    self.onEndResizing = onEndResizing
  }
  
  private let size: CGFloat = 50
  
  public var body: some View {
    ZStack {
      Group {
        Handles()
          .stroke(lineWidth: 10)
          .opacity(0.9)
        RoundedRectangle(cornerRadius: 12.0)
          .stroke(style: StrokeStyle(lineWidth: 6.0))
          .padding(10)
          .readFrame(in: .global, for: $relativeRect)
      }
      .frame(width: rect.width, height: rect.height)
      .offset(x: rect.origin.x, y: rect.origin.y)
      .shadow(radius: 8)
      
      Group {
        makeGhost(for: [.top, .left])
        makeGhost(for: [.top, .right])
        makeGhost(for: [.bottom, .left])
        makeGhost(for: [.bottom, .right])
        makeGhost(for: [.top])
        makeGhost(for: [.left])
        makeGhost(for: [.right])
        makeGhost(for: [.bottom])
      }
    }
  }
  
  @ViewBuilder
  private func makeGhost(for positions: [Position]) -> some View {
    GeometryReader { reader in
      Rectangle()
        .opacity(0)
        .contentShape(Rectangle())
        .foregroundStyle(Color.red)
        .offset(getOffset(for: positions))
        .highPriorityGesture(
          DragGesture()
            .onChanged({ value in
              if !isResizing {
                isResizing = true
                onBeginResizing?()
              }
              guard let bounds = reader.bounds(of: .named("resizeTargetArea")) else {
                return
              }
              moving(with: value, for: positions, in: bounds)
            })
            .onEnded({ _ in
              previousRect = rect
              isResizing = false
              onEndResizing?()
            })
        )
    }.frame(width: 50, height: 50)
  }
  
  private func getOffset(for positions: [Position]) -> CGSize {
    var width = rect.origin.x
    var height = rect.origin.y
    for position in positions {
      switch position {
      case .top:
        height -= rect.height / 2
      case .bottom:
        height += rect.height / 2
      case .left:
        width -= rect.width / 2
      case .right:
        width += rect.width / 2
      }
    }
    return CGSize(width: width, height: height)
  }
  
  private func moving(
    with value: DragGesture.Value,
    for positions: [Position],
    in bounds: CGRect
  ) {
    if previousRect == nil {
      previousRect = rect
    }
    guard let previousRect else { return }
    
    let topEnd    = -(bounds.height / 2) + (padding?.top ?? 0)
    let leftEnd   = -(bounds.width / 2) + (padding?.left ?? 0)
    let rightEnd  = (bounds.width / 2) - (padding?.right ?? 0)
    let bottomEnd = (bounds.height / 2) - (padding?.bottom ?? 0)
    
    for position in positions {
      switch position {
      case .top:
        let newHeight = max(
          previousRect.height - value.translation.height,
          minRect.height
        )
        guard newHeight != minRect.height else { return }
        let newY = previousRect.origin.y + value.translation.height / 2
        guard newY >= topEnd + (newHeight / 2) else { return }
        rect.origin.y = newY
        rect.size.height = newHeight
      case .bottom:
        let newHeight = max(
          previousRect.height + value.translation.height,
          minRect.height
        )
        guard newHeight != minRect.height else { return }
        let newY = previousRect.origin.y + value.translation.height / 2
        guard newY <= bottomEnd - (newHeight / 2) else { return }
        rect.size.height = newHeight
        rect.origin.y = newY
      case .left:
        let newWidth = max(
          previousRect.width - value.translation.width,
          minRect.width
        )
        guard newWidth != minRect.width else { return }
        let newX = previousRect.origin.x + value.translation.width / 2
        guard newX >= leftEnd + (newWidth / 2) else { return }
        rect.size.width = newWidth
        rect.origin.x = newX
      case .right:
        let newWidth = max(
          previousRect.width + value.translation.width,
          minRect.width
        )
        guard newWidth != minRect.width else { return }
        let newX = previousRect.origin.x + value.translation.width / 2
        guard newX <= rightEnd - (newWidth / 2) else { return }
        rect.size.width = newWidth
        rect.origin.x = newX
      }
    }
  }
}
