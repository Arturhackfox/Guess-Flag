//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Arthur Sh on 28.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingScore: Bool = false
    @State private var scoreTitle = ""
    
    @State private var questionCount = 0
    
    @State private var usersScore = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.63, blue: 0.50), location: 0.3),
                .init(color: Color(red: 0.77, green: 0.33, blue: 0.67), location: 0.3)
                
            ], center: .top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            VStack{
                Spacer()
              
                    Text("Guess the Flag")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
            
                VStack(){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.medium))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            correct(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                            
                        }
                        
                        .alert(scoreTitle, isPresented: $isShowingScore){
                            if questionCount != 8 {
                                Button("Continue", action: askNewQuestion)
                            } else {
                                Button("Start again", action: askNewQuestion)
                            }
                        } message: {
                            if questionCount < 8 {
                                Text("Your score is \(usersScore)")
                            } else {
                                Text("")
                            }
                            
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()

                Text("Your score is: \(usersScore)")
                    .foregroundColor(.white)
                    .font(.title2.weight(.bold))
                Spacer()

            }
            .padding(20)
            
            
        }
        //
    }
    
    func correct (_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            usersScore += 10
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            if usersScore > 0 {
                usersScore -= 5
            }
        }
        questionCount += 1
        isShowingScore = true
        
        if questionCount == 8 {
            scoreTitle = "That's it! Your final score is: \(usersScore)"
            usersScore = 0
            
        }
    }
    
    func askNewQuestion(){
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        
        }
      
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
