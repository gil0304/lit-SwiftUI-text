//
//  ContentView.swift
//  StopWatch
//
//  Created by 落合遼梧 on 2025/06/24.
//

import SwiftUI

struct ContentView: View {
  @State private var timer: Timer?
  @State private var secondsElapsed: Double = 0.0
  @State private var isRunning = false
  @State private var laps: [Double] = []
  
  var body: some View {
    ZStack {
      // 背景グラデーション
      LinearGradient(
        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
        startPoint: .topLeading, endPoint: .bottomTrailing
      )
      .edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 24) {
        Text("StopWatch")
          .font(.system(size: 34, weight: .bold, design: .rounded))
          .foregroundColor(.white)
          .padding(.top, 40)
        
        // 円形プログレスバー＋時間表示
        ZStack {
          Circle()
            .stroke(lineWidth: 12)
            .opacity(0.3)
            .foregroundColor(.white)
          
          Circle()
            .trim(
              from: 0,
              to: CGFloat((secondsElapsed.truncatingRemainder(dividingBy: 60) / 60))
            )
            .stroke(
              LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
              ),
              style: StrokeStyle(lineWidth: 12, lineCap: .round)
            )
            .rotationEffect(.degrees(-90))
            .animation(.easeInOut(duration: 0.2), value: secondsElapsed)
          
          Text(timeString(from: secondsElapsed))
            .font(.system(size: 38, weight: .semibold, design: .monospaced))
            .foregroundColor(.white)
        }
        .frame(width: 220, height: 220)
        .padding()
        
        // コントロールボタン
        HStack(spacing: 32) {
          Button(action: { isRunning ? pause() : start() }) {
            Image(systemName: isRunning ? "pause.fill" : "play.fill")
          }
          .buttonStyle(
            GradientCircleButtonStyle(
              gradient: LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .top, endPoint: .bottom
              ),
              size: 64
            )
          )
          
          if isRunning {
            Button("Lap") { lap() }
              .buttonStyle(CapsuleButtonStyle())
          }
          
          if secondsElapsed > 0 {
            Button(action: stop) {
              Image(systemName: "stop.fill")
            }
            .buttonStyle(
              GradientCircleButtonStyle(
                gradient: LinearGradient(
                  colors: [Color.pink, Color.red],
                  startPoint: .top, endPoint: .bottom
                ),
                size: 64
              )
            )
          }
        }
        .padding(.bottom, 16)
        
        // ラップリスト
        if !laps.isEmpty {
          ScrollView {
            LazyVStack(spacing: 12) {
              ForEach(laps.indices, id: \.self) { idx in
                HStack {
                  Text("Lap \(idx+1)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                  Spacer()
                  Text(timeString(from: laps[idx]))
                    .font(.system(size: 16, design: .monospaced))
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
              }
            }
            .padding(.horizontal)
          }
          .frame(maxHeight: 260)
          .transition(.move(edge: .bottom))
        }
        
        Spacer()
      }
      .padding(.horizontal)
    }
  }
  
  func start() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
      secondsElapsed += 0.01
    }
    isRunning = true
  }
  
  func pause() {
    timer?.invalidate()
    isRunning = false
  }
  
  func stop() {
    timer?.invalidate()
    isRunning = false
    secondsElapsed = 0
    laps.removeAll()
  }
  
  func lap() {
    laps.append(secondsElapsed)
  }
  
  func timeString(from seconds: Double) -> String {
    let centi = Int((seconds - floor(seconds)) * 100)
    let sec = Int(seconds) % 60
    let min = Int(seconds) / 60
    return String(format: "%02d:%02d.%02d", min, sec, centi)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewInterfaceOrientation(.portrait)
  }
}
