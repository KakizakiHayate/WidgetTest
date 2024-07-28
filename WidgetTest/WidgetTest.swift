//
//  WidgetTest.swift
//  WidgetTest
//
//  Created by 柿崎 on 2024/07/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let userDefaults = UserDefaults(suiteName: "group.com.hayate.dev.WidgetTanzamTest")
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), shouldChangeUI: false)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), shouldChangeUI: userDefaults?.bool(forKey: "shouldChangeUI") ?? false)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // 現在の日時を取得
        let currentDate = Date()
//        // 次の23時の日時を計算
//        let nextUpdateDate = Calendar.current.date(bySettingHour: 20, minute: 25, second: 0, of: currentDate)!

        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        let targetHour = 20
        let targetMinute = 39
        var dateComponents = DateComponents()
            dateComponents.hour = targetHour
            dateComponents.minute = targetMinute
        let nextUpdateDate = calendar.nextDate(after: currentDate, matching: dateComponents, matchingPolicy: .nextTime)!

        // UserDefaultsからフラグを取得
        let shouldChangeUI = userDefaults?.bool(forKey: "shouldChangeUI") ?? false

        // エントリを作成
        let entry = SimpleEntry(date: nextUpdateDate, shouldChangeUI: shouldChangeUI)
        entries.append(entry)

        // タイムラインを作成
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let shouldChangeUI: Bool
}

struct WidgetTestEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            if entry.shouldChangeUI {
                Text("UI Changed")
            } else {
                Text("UI Not Changed")
            }
            Text(entry.date, style: .time)
        }
    }
}

@main
struct WidgetTest: Widget {
    let kind: String = "WidgetTest"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetTestEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//#Preview(as: .systemSmall) {
//    WidgetTest()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
