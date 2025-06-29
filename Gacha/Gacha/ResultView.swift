//
//  ResultView.swift
//  Gacha
//
//  Created by 落合遼梧 on 2025/06/29.
//

import SwiftUI

struct ResultView: View {
  @Environment(\.dismiss) var dismiss
  @State var backGroundImageName: String = "bgRed"
  @State var characterImageName: String = "iphone"
  @State var star: String = "⭐️⭐️"
  var body: some View {
    ZStack {
      Image(backGroundImageName)
        .resizable()
        .ignoresSafeArea()
      Image(characterImageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 350, height: 350)
        .offset(y: -50)
      VStack {
        HStack {
          Button("閉じる") {
            dismiss()
          }
          .padding(40)
          .foregroundStyle(.white)
          .fontWeight(.bold)
          .font(.title)
          Spacer()
        }
        Spacer()
        Text(star)
          .font(.largeTitle)
          .padding(.bottom, 50)
      }
    }
    .onAppear {
      let number = Int.random(in: 0..<9)
      switch number {
      case 9:
        //乱数が9だった時の処理
        backGroundImageName = "bgBlue"
        characterImageName = "IoTMesh"
        star = "⭐️⭐️⭐️⭐️⭐️"
      case 8:
        //乱数が8だった時の処理
        backGroundImageName = "bgGreen"
        characterImageName = "camera"
        star = "⭐️⭐️⭐️⭐️"
      case 0..<7:
        //乱数が0から7だった時の処理
        backGroundImageName = "bgRed"
        characterImageName = "iphone"
        star = "⭐️⭐️"
      default:
        //デフォルトの処理(今回は使わないよ！)
        backGroundImageName = "bgRed"
        characterImageName = "iphone"
        star = "⭐️⭐️"
      }
    }
  }
}

#Preview {
  ResultView()
}
