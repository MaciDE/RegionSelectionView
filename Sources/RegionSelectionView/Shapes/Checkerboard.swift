//
//  Checkerboard.swift
//  
//
//  Created by Marcel Opitz on 02.03.24.
//

import SwiftUI

struct Checkerboard: Shape {
    
    let boxSize: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let rows = Int(ceil(rect.height / boxSize))
        let columns = Int(ceil(rect.width / boxSize))

        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = boxSize * Double(column)
                    let startY = boxSize * Double(row)

                    let rect = CGRect(
                        x: startX,
                        y: startY,
                        width: boxSize,
                        height: boxSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}
