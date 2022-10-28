//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Arthur Sh on 28.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3){ number in
                    Button {
                        print("")
                    } label: {
                        Image(countries[number])
                        
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
