//
//  BoxColumnPagesTabView.swift
//  SynchronizedScrollPages
//
//  Created by Pete Maiser on 3/8/25.
//

import SwiftUI

struct BoxColumnPagesTabView: View {
    let boxCountByPage: (Int, Int)
    let lineConfigurationByPage: (BoxColumnVerticalLineConfiguration, BoxColumnVerticalLineConfiguration)
    
    @State var pageIndex: Int
    
    @State private var scrollPositions: [ScrollPosition] = [ScrollPosition(), ScrollPosition()]
    
    var body: some View {
        let boxHeight = boxHeightGlobal
        let maxBoxCount = max(boxCountByPage.0, boxCountByPage.1)
        let padding = paddingGlobal
        let totalHeight = boxHeight * CGFloat(maxBoxCount) + CGFloat(padding)
        
        TabView(selection: $pageIndex) {

            // First Page
            SynchronizedScrollView(viewIndex: pageIndex,
                                   activeViewIndex: $pageIndex,
                                   viewScrollPositions: $scrollPositions)
            {
                BoxColumnView(
                    boxes: BoxData.sampleBoxes(count: boxCountByPage.0, lineConfiguration: .right),
                    boxHeight: boxHeight,
                    columnHeight: totalHeight,
                    lineConfiguration: lineConfigurationByPage.0
                )
            }
            .tag(0) // End First Page
            
            // Second Page
            SynchronizedScrollView(viewIndex: pageIndex,
                                   activeViewIndex: $pageIndex,
                                   viewScrollPositions: $scrollPositions)
            {
                BoxColumnView(
                    boxes: BoxData.sampleBoxes(count: boxCountByPage.1, lineConfiguration: .left),
                    boxHeight: boxHeight,
                    columnHeight: totalHeight,
                    lineConfiguration: lineConfigurationByPage.1
                )
            }
            .tag(1) // End Second page
            
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

