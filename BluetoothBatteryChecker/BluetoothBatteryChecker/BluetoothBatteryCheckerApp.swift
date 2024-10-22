//
//  BluetoothBatteryCheckerApp.swift
//  BluetoothBatteryChecker
//
//  Created by 주승현 on 10/22/24.
//

import SwiftUI

@main
struct BluetoothBatteryCheckerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                // Control + 1 입력 감지
                Button(action: {
                    NotificationCenter.default.post(name: Notification.Name("updateBluetoothInfo"), object: nil)
                }) {
                    Text("Control + 1")
                }
                .keyboardShortcut("1", modifiers: [.control])
            }
        }
    }
}
