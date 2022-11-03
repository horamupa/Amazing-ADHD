//
//  Home.swift
//  Amazing ADHD
//
//  Created by MM on 02.11.2022.
//

import SwiftUI
import AVKit
import Combine

struct HomeView: View {
    
    @State var isPlay: Bool = false
    @State var countTo = 1800
    @State var counter = 0
    @State var progressValue: CGFloat = 0.0
    @State var progressText: String = "30:00"
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common)
    @State var cancellabelTimer: AnyCancellable?
    let futureDate: Date = Calendar.current.date(byAdding: .init(minute: 30), to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remainig = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        let minutes = remainig.minute ?? 0
        let seconds = remainig.second ?? 0
        progressText = "\(minutes):\(seconds)"
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 60) {
                Text("Amazing ADHD")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                ZStack {
                    Button {
                        if !isPlay {
                            SoundManager.instance.playSound(sound: .Binaural40HZ)
                            startTimer()
                            
                        } else {
                            SoundManager.instance.pauseSound()
                            stopTimer()
                        }
                        isPlay.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 200, height: 200)
                            Image(systemName: isPlay ? "pause" : "play")
                                .scaleEffect(4)
                                .foregroundColor(.white)
                        }
                }
                    
                    CircularProgressView(progress: progressValue)
                }
                VStack(spacing: 5) {
                    Text("Time to Best Focus")
                        .foregroundColor(.white)
                        .opacity(0.7)
                    Text(progressText)
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
//            if !isPlay {
//                withAnimation(.easeInOut(duration: 2).repeatForever()) {
//                    HStack {
//                        Image(systemName: "wave.3.right")
//                            .scaleEffect(5)
//                        Spacer()
//                        Image(systemName: "wave.3.left")
//                            .scaleEffect(5)
//                    }
//                    .padding(.horizontal, 50)
//                    .foregroundColor(.white)
//                }
//            }
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
            progress()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension HomeView {
    
    func progress() {
        if counter == countTo {
            progressText = "You got an Amazing Focus"
        }
        let timeSpend = CGFloat(counter) / CGFloat(countTo)
        self.progressValue = timeSpend
        counter += 1
    }
    
    func startTimer() {
        cancellabelTimer = timer.connect() as? AnyCancellable
    }
    
    func stopTimer() {
        cancellabelTimer?.cancel()
    }
}
