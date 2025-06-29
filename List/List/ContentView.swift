//
//  ContentView.swift
//  List
//
//  Created by 落合遼梧 on 2025/06/29.
//

import SwiftUI

struct ContentView: View {
  let array = ["いぬ", "ねこ", "さる", "とり"]
  var body: some View {
    NavigationStack {
      List {
        ForEach(Animal.allCases, id: \.self) { animal in
          NavigationLink(destination: DetailView(animal: animal)) {
            HStack {
              Image(animal.iconName)
              Text(animal.name)
            }
          }
        }
      }
      .navigationTitle("動物")
    }
  }
}

#Preview {
  ContentView()
}
