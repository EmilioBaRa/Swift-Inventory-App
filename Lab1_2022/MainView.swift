//
//  MainView.swift
//  Lab1_2022
//
//  Created by ICS 224 on 2022-01-25.
//

import SwiftUI

func color2array(colour: Color) -> [CGFloat] {
    let uiColor = UIColor(colour)
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return [red, green, blue, alpha]
}

func array2color(array: [CGFloat]) -> Color {
    return Color(Color.RGBColorSpace.sRGB, red: array[0], green: array[1], blue: array[2], opacity:
    array[3])
}

struct MainView: View {
    @State private var showSettings = false
    @State var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    @State var stepperValue = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ?? 150;
    @State var favouriteExists = false;
    @EnvironmentObject var inventoryItems: InventoryItems

    var body: some View {
        NavigationView() {
            VStack {
               if showSettings {
                   SettingsView(colour: $colour, stepperValue: $stepperValue)
               }
               else {
                   List($inventoryItems.entries) {
                       $inventoryItem in
                       NavigationLink(
                        destination: DetailView(colour: colour, stepperValue: stepperValue, inventoryItem: $inventoryItem, favouriteExists: $favouriteExists)
                       ) {
                           RowView(inventoryItem: inventoryItem)
                       }
                       .swipeActions(edge: .trailing) {
                           Button(role: .destructive) {
                               inventoryItems.entries.removeAll(where: { $0.id == inventoryItem.id})
                           } label: {
                               Label("Delete", systemImage: "trash")
                           }
                       }
                   }
               }
            }
            .navigationBarTitle(Text("Inventory"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !showSettings {
                        Button(
                            action: {
                                withAnimation {
                                    let item = InventoryItem(image: "ladybug", description: "Ladybug", favourite: false);
                                    inventoryItems.entries.insert(item, at: 0);
                                }
                            }
                        ) {
                            Image(systemName: "plus")
                        }
                        .accessibilityIdentifier("PlusButton")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(
                        action: {
                            showSettings.toggle()
                        },
                        label: {
                            Image(systemName: showSettings ? "house" : "gear")
                        }
                    )
                    .accessibilityIdentifier("NavigationButton")
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPad (9th generation)", "iPod touch (7th generation)"], id: \.self) { deviceName in
            MainView()
                .previewDevice(PreviewDevice(rawValue: deviceName)).environmentObject(InventoryItems(previewMode: true))
        }
    }
}
