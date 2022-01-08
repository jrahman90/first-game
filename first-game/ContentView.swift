 //
//  ContentView.swift
//  first-game
//
//  Created by Jalilur Rahman on 1/7/22.
//

import SwiftUI

class HapticManger {
    
    static let instance = HapticManger()
    
    func notifications(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct ContentView: View {
    
        //initital state is set to private so it cant be accessed out of scope
    @State private var player1Card = "back"
    @State private var player2Card = "back"
    @State private var player1Score = 0
    @State private var player2Score = 0
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("hilo")

                Spacer()

                HStack{
                    Spacer()
                    Image(player1Card)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Spacer()
                    Image(player2Card)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    Spacer()
                }

                Spacer()
                
                Button(action: {
                    //haptic feedback
                    HapticManger.instance.notifications(type: .success)
                    HapticManger.instance.impact(style: .soft)
                    //generate a random num bet 2 & 14
                    let player1Rand = Int.random(in: 2...14)
                    let player2Rand = Int.random(in: 2...14)
                    //update cards
                    player1Card = "card" + String(player1Rand)
                    player2Card = "card" + String(player2Rand)
                    //update score
                    if player1Rand > player2Rand {
                        player1Score += 1
                    }
                    else if player2Rand > player1Rand {
                        player2Score += 1
                    }
                   
                    
                    
                }, label: {
                    Image("play-now")
                })

                Spacer()

                HStack{
                    Spacer()
                    VStack{
                        Text("Player 1")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text(String(player1Score))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                    VStack{
                        Text("Player 2")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 10.0)
                        Text(String(player2Score))
                            .font(.largeTitle)
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                }
                //reset button
                Button(action: {
                    HapticManger.instance.notifications(type: .warning)
                    HapticManger.instance.impact(style: .soft)
                    player1Card = "back"
                    player2Card = "back"
                    player1Score = 0
                    player2Score = 0
                    
                }, label: {Text("RESET")}).padding(7).background(Color.white.blur(radius: 10))
                Spacer()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro Max")
    }
}
