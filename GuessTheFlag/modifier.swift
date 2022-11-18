//
//  modifier.swift
//  GuessTheFlag
//
//  Created by Arthur Sh on 30.10.2022.
//

import SwiftUI



struct  Prominent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(.blue)
            .cornerRadius(7)
            
    }
}


extension View {
    func prominent() -> some View {
        modifier(Prominent())
    }
}
