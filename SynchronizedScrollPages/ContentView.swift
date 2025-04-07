//
//  ContentView.swift
//  SynchronizedScrollPages
//
//  Created by Pete Maiser on 3/8/25.
//

import SwiftUI

let maxBoxCount: Int = 16
let boxHeightGlobal: CGFloat = 72
let paddingGlobal = 450

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var pageIndexLeft = 0    // initialize to desired start page index
    @State private var pageIndexRight = 1   // initialize to desired start page index
       
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // Left Tab
            BoxColumnPagesTabView(
                boxCountByPage: (maxBoxCount, maxBoxCount/2),
                lineConfigurationByPage: (.right, .none),
                pageIndex: pageIndexLeft
            )
            .tabItem { Label("P1-P2 from Left", systemImage: "text.alignleft") }
            .tag(0)
            
            // Middle Tab
            TabView {
                VStack {
                    BoxColumnView(
                        boxes: BoxData.sampleBoxes(count: 4, lineConfiguration: .none),
                        boxHeight: boxHeightGlobal,
                        columnHeight: boxHeightGlobal * CGFloat(4) + CGFloat(paddingGlobal/2),
                        lineConfiguration: .none
                    )
                }
            }
            .tabItem { Label("P3", systemImage: "text.justify") }
            .tabViewStyle(PageTabViewStyle())
            .tag(1)    // End Middle Tab

            // Right Tab
            BoxColumnPagesTabView(
                boxCountByPage: (maxBoxCount/2, maxBoxCount),
                lineConfigurationByPage: (.none, .left),
                pageIndex: pageIndexRight
            )
            .tabItem { Label("P5-P4 from Right", systemImage: "text.alignright") }
            .tag(2)
            
        }
    }
}

#Preview {
    ContentView()
}
