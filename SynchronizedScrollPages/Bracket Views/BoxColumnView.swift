//
//  BoxColumnView.swift
//  SynchronizedScrollPages
//
//  Created by Pete Maiser on 3/8/25.
//

import SwiftUI

enum BoxColumnVerticalLineConfiguration {
    case left, right, both, none
}

struct BoxColumnView: View {
    let boxes: [BoxData]
    let boxHeight: CGFloat
    let columnHeight: CGFloat
    let lineConfiguration: BoxColumnVerticalLineConfiguration
        
    var body: some View {
    
        // calucate the vertical spacing from whatever will be "left over"
        // of the total height after all boxes have been drawn
        let spacing = ( columnHeight - boxHeight * CGFloat(boxes.count) ) / CGFloat(boxes.count)
        
        ZStack {
            // Draw the vertical line at the edge
            if lineConfiguration != .none {
                GeometryReader { geometry in
                    let columnWidth = geometry.size.width
                    let xPosition: CGFloat = (lineConfiguration == .left) ? 0 : columnWidth
                    let adjustedSpacing = spacing / 2

                    Path { path in
                        for index in stride(from: 0, to: boxes.count - 1, by: 2) { // Every two boxes
                            let yStart = CGFloat(index) * (boxHeight + spacing) + boxHeight / 2 + adjustedSpacing
                            let yEnd = yStart + boxHeight + spacing
                            
                            path.move(to: CGPoint(x: xPosition, y: yStart))
                            path.addLine(to: CGPoint(x: xPosition, y: yEnd))
                        }
                    }
                    .stroke(Color.gray, lineWidth: 2)
                }
            }
            
            VStack(spacing: spacing) {
                ForEach(boxes) { box in
                    BoxView(boxData: box, boxHeight: boxHeight)
                }
            }
            .padding()
            .frame(height: columnHeight)
        }

    }
}

#Preview {
    let boxCount = 16
    
    BoxColumnView(
        boxes: BoxData.sampleBoxes(count: boxCount/2, lineConfiguration: .both),
        boxHeight: boxHeightGlobal,
        columnHeight: boxHeightGlobal * CGFloat(boxCount) + CGFloat(32),
        lineConfiguration: .both
    )
}
