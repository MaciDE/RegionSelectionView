//
//  Handles.swift
//
//
//  Created by Marcel Opitz on 25.02.24.
//

import SwiftUI

struct Handles: Shape {
  func path(in rect: CGRect) -> Path {
    let length: CGFloat = 10
    let radius: CGFloat = 16
    let thickness: CGFloat = 10
    
    let t2 = thickness / 2
    
    var path = Path()
    
    // Top mid
    path.move(to: CGPoint(x: rect.width / 2 - 20, y: t2))
    path.addLine(to: CGPoint(x: rect.width / 2 + 20, y: t2))
    
    // Bottom mid
    path.move(
      to: CGPoint(x: rect.width / 2 - 20, y: rect.height - t2))
    path.addLine(
      to: CGPoint(x: rect.width / 2 + 20, y: rect.height - t2))
    
    // Left mid
    path.move(
      to: CGPoint(x: t2, y: rect.height / 2 - 20))
    path.addLine(
      to: CGPoint(x: t2, y: rect.height / 2 + 20))
    
    // Right mid
    path.move(
      to: CGPoint(x: rect.width - t2, y: rect.height / 2 - 20))
    path.addLine(
      to: CGPoint(x: rect.width - t2, y: rect.height / 2 + 20))
    
    // Top left
    path.move(to: CGPoint(x: t2, y: length - 1 + radius + t2))
    path.addLine(to: CGPoint(x: t2, y: radius + t2))
    path.addArc(
      center: CGPoint(x: radius + t2, y: radius + t2),
      radius: radius,
      startAngle: Angle(radians: CGFloat.pi),
      endAngle: Angle(radians: CGFloat.pi * 3 / 2),
      clockwise: false)
    path.addLine(
      to: CGPoint(x: length - 1 + radius + t2, y: t2))
    
    // Top right
    path.move(
      to: CGPoint(x: rect.width - t2, y: length - 1 + radius + t2))
    path.addLine(
      to: CGPoint(x: rect.width - t2, y: radius + t2))
    path.addArc(
      center: CGPoint(x: rect.width - radius - t2, y: radius + t2),
      radius: radius,
      startAngle: Angle(radians: 0),
      endAngle: Angle(radians: CGFloat.pi * 3 / 2),
      clockwise: true)
    path.addLine(to: CGPoint(x: rect.width - length + 1 - radius - t2, y: t2))
    
    // Bottom left
    path.move(
      to: CGPoint(x: t2, y: rect.height - length + 1 - radius - t2))
    path.addLine(
      to: CGPoint(x: t2, y: rect.height - radius - t2))
    path.addArc(
      center: CGPoint(x: radius + t2, y: rect.height - radius - t2),
      radius: radius, startAngle: Angle(radians: CGFloat.pi),
      endAngle: Angle(radians: CGFloat.pi / 2),
      clockwise: true)
    path.addLine(to: CGPoint(x: length - 1 + radius + t2, y: rect.height - t2))
    
    // Bottom right
    path.move(
      to: CGPoint(x: rect.width - t2, y: rect.height - length + 1 - radius - t2))
    path.addLine(
      to: CGPoint(x: rect.width - t2, y: rect.height - radius - t2))
    path.addArc(
      center: CGPoint(x: rect.width - radius - t2, y: rect.height - radius - t2),
      radius: radius,
      startAngle: Angle(radians: 0),
      endAngle: Angle(radians: CGFloat.pi / 2),
      clockwise: false)
    path.addLine(
      to: CGPoint(x: rect.width - length + 1 - radius - t2, y: rect.height - t2))
    
    return path
  }
}
