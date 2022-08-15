import SwiftUI

struct RowView: View {
    var inventoryItem: InventoryItem
    var body: some View {
        HStack {
            Image(uiImage: inventoryItem.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .leading)
            Text(inventoryItem.description)
                .frame(width: 200, height: 100, alignment: .leading)
        }
        .padding()
    }
}

struct RowView_Previews: PreviewProvider {
    static var inventoryItems = InventoryItems(previewMode: true)
    static var previews: some View {
        RowView(inventoryItem:  inventoryItems.entries[0])
    }
}
