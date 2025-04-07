//
//  SynchronizedScrollView.swift
//
//  Created by Pete Maiser on 3/8/25.
//

import SwiftUI

struct SynchronizedScrollView<Content: View>: View {
    let viewIndex: Int
    
    @Binding var activeViewIndex: Int
    @Binding var viewScrollPositions: [ScrollPosition]

    @ViewBuilder let content: () -> Content

    var body: some View {
        
        ScrollView {
            content()
        }
        
        .scrollPosition($viewScrollPositions[viewIndex])
        
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            geometry.contentOffset.y + geometry.contentInsets.top
        } action: { oldValue, newValue in
            guard oldValue != newValue else { return }
            for i in viewScrollPositions.indices where i != activeViewIndex {
                viewScrollPositions[i].scrollTo(y: newValue)
            }
        }
        
        .onScrollPhaseChange { _, newPhase in
            if newPhase.isScrolling {
                activeViewIndex = viewIndex
            }
        }
    
    }
}
