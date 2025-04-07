//
//  BoxData.swift
//  SynchronizedScrollPages
//
//  Created by Pete Maiser on 3/8/25.
//

import Foundation

struct BoxData: Identifiable {
    let id = UUID()
    let textTop: String
    let textBottom: String
    let lineConfiguration: BoxHorizontalLineConfiguration
}

extension BoxData {    
    static func sampleBox(lineConfiguration: BoxHorizontalLineConfiguration) -> BoxData {
        .init(
            textTop: "Top Box",
            textBottom: "Bottom",
            lineConfiguration: lineConfiguration
        )
    }
    
    static func sampleBoxes(count: Int, lineConfiguration: BoxHorizontalLineConfiguration) -> [BoxData] {
        var boxes: [BoxData] = []
        for i in 0..<count {
            boxes.append(.init(
                textTop: "Top \(i+1)",
                textBottom: "Bottom",
                lineConfiguration: lineConfiguration
            ))
        }
        return boxes
    }
}
