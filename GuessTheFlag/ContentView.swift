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
    
    @State private var selectedFlag = -1
    @State private var ThreeDEffect = 0.0
    
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                        .prominent()
            
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
                            flagTapped(number)
                                                      
                        } label: {
                            flagImageView(countr: countries, number: number)
                                .accessibilityLabel(labels[countries[number]] ?? "Unknown")

                        }
                        .rotation3DEffect(Angle(degrees: selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        .animation(.default, value: selectedFlag)
                        .rotation3DEffect(Angle(degrees: selectedFlag != -1 && selectedFlag != number ? -360 : 0), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeInOut, value: selectedFlag)
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
    
    func flagTapped(_ number: Int){
        selectedFlag = number
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
            selectedFlag = -1
        }
      
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
