//
//  flagImageView.swift
//  GuessTheFlag
//
//  Created by Arthur Sh on 30.10.2022.
//

import SwiftUI

struct flagImageView: View {
    var countr: [String]
    var number: Int
    

 
    
    var body: some View {
       Image(countr[number])
            .clipShape(Capsule())
            .shadow(radius: 5)
           
    }
}


