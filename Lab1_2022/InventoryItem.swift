import SwiftUI;


struct InventoryItem: Identifiable, Codable {
    let id = UUID()
    var description: String
    var favourite: Bool
    var image: UIImage {
            get {
                UIImage(data: self.imageAsData) ?? UIImage(systemName: "questionmark")!
            }
            set {
                self.imageAsData = newValue.pngData() ?? UIImage(systemName: "questionmark")!.pngData()!
            }
        }
    
    var imageAsData: Data
    
    init(image: String, description: String) {
        self.imageAsData = (UIImage(systemName: image) ?? UIImage(systemName: "questionmark")!).pngData()!
        self.description = description
        self.favourite = false
    }
    
    init(image: String, description: String, favourite: Bool) {
        self.imageAsData = (UIImage(systemName: image) ?? UIImage(systemName: "questionmark")!).pngData()!
        self.description = description
        self.favourite = favourite
    }
    
    init(image: UIImage, favourite: Bool, description: String){
        self.imageAsData = image.pngData() ?? UIImage(systemName: "questionmark")!.pngData()!
        self.favourite = favourite;
        self.description = description;
    }
    
}
