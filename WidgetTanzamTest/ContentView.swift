//
//  ContentView.swift
//  WidgetTanzamTest
//
//  Created by 柿崎 on 2024/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            // ボタンを追加してフラグを変更する
            Button(action: {
                let defaults = UserDefaults(suiteName: "group.com.hayate.dev.WidgetTanzamTest")
                let currentValue = defaults?.bool(forKey: "shouldChangeUI") ?? false
                defaults?.set(true, forKey: "shouldChangeUI")
                if let shouldChangeUI = defaults?.bool(forKey: "shouldChangeUI") {
                    print("shouldChangeUI: \(shouldChangeUI)")
                } else {
                    print("キー 'shouldChangeUI' が見つかりませんでした。")
                }
            }) {
                Text("Toggle UI Change")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
