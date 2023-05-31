//
//  LoadingViewModifier.swift
//  KanaSearch
//
//  Created by 丹羽雄一朗 on 2023/05/31.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    
    var isRefleshing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(!isRefleshing)
            
            if isRefleshing {
                ProgressView {
                    Text("Loading")
                }
            }
        }
    }
}

extension View {
    func loading(isRefleshing: Bool, safeAreaEdges: Edge.Set = []) -> some View {
        modifier(LoadingViewModifier(isRefleshing: isRefleshing))
    }
}
