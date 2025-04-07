//
//  BoxView.swift
//  SynchronizedScrollPages
//
//  Created by Pete Maiser on 3/8/25.
//

import SwiftUI

enum BoxHorizontalLineConfiguration {
    case left, right, both, none
}

struct BoxView: View {
    let boxData: BoxData
    let boxHeight: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if boxData.lineConfiguration == .left || boxData.lineConfiguration == .both {
                    Path { path in
                        let midY = geometry.size.height / 2
                        path.move(to: CGPoint(x: 0, y: midY))
                        path.addLine(to: CGPoint(x: -geometry.size.width, y: midY))
                    }
                    .stroke(Color.gray, lineWidth: 1)
                }
                
                if boxData.lineConfiguration == .right || boxData.lineConfiguration == .both {
                    Path { path in
                        let midY = geometry.size.height / 2
                        path.move(to: CGPoint(x: geometry.size.width, y: midY))
                        path.addLine(to: CGPoint(x: geometry.size.width * 2, y: midY))
                    }
                    .stroke(Color.gray, lineWidth: 1)
                }
            }
            
            VStack(spacing: 5) {
                HStack {
                    Text(boxData.textTop)
                        .foregroundColor(.blue)
                        .font(.body.weight(.semibold))
                    Spacer()
                    Image(systemName: "checkmark.rectangle")
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.blue.opacity(0.15))
                .cornerRadius(8)
                
                HStack {
                    Text(boxData.textBottom)
                        .foregroundColor(.gray)
                        .font(.body.weight(.regular))
                    Spacer()
                    Image(systemName: "rectangle")
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)).shadow(radius: 1))
        }
        .frame(height: boxHeight)
    }
}

#Preview {
    VStack {
        BoxView(boxData: BoxData.sampleBox(lineConfiguration: .right), boxHeight: boxHeightGlobal)
            .padding()
        BoxView(boxData: BoxData.sampleBox(lineConfiguration: .none), boxHeight: boxHeightGlobal)
            .padding()
        BoxView(boxData: BoxData.sampleBox(lineConfiguration: .left), boxHeight: boxHeightGlobal)
            .padding()
        BoxView(boxData: BoxData.sampleBox(lineConfiguration: .both), boxHeight: boxHeightGlobal)
            .padding()
    }
}
