//
//  WordListApp.swift
//  WordList
//
//  Created by 落合遼梧 on 2025/06/29.
//

import SwiftUI
import SwiftData

@main
struct WordListApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Word.self)
    }
  }
}
