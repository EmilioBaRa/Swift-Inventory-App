//
//  Lab1_2022App.swift
//  Lab1_2022
//
//  Created by ICS 224 on 2022-01-20.
//

import SwiftUI

@main
struct Lab1_2022App: App {
    @StateObject var inventoryItems = InventoryItems()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(inventoryItems)
        }
        .onChange(of: scenePhase, perform: {
            phase in
            switch phase {
            case .background:
                inventoryItems.saveObjects()
            default:
        break
            }
        })
    }
}
