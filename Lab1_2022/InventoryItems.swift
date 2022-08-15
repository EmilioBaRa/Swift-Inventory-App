import SwiftUI
import os

class InventoryItems: ObservableObject  {
    @Published var entries = [InventoryItem]()
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let entriesURL = documentsDirectory.appendingPathComponent("entries")
    
    init(previewMode: Bool) {
        if previewMode {
            entries.append(InventoryItem(image: "hare", description: "Hare", favourite: false))
            entries.append(InventoryItem(image: "tortoise", description: "Tortoise", favourite: false))
        }
    }
    
    init() {
        loadObjects()
    }
    
    func loadObjects() {
        do {
            let data = try Data(contentsOf: InventoryItems.entriesURL)
            let decoder = JSONDecoder()
            entries = try decoder.decode([InventoryItem].self, from: data)
        } catch {
            os_log("Cannot load due to %@", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    }
    
    func saveObjects() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(entries)
            try data.write(to: InventoryItems.entriesURL)
        } catch {
            os_log("Cannot save due to %@", log: OSLog.default, type: .debug, error.localizedDescription)
        }
    }
}
