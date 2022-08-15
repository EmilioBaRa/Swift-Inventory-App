//
//  ImageView.swift
//  Lab1_2022
//
//  Created by Michael Horie on 2021-01-27.
//

import SwiftUI

struct ImageView: UIViewControllerRepresentable {
    
    class ImageViewController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var image: UIImage?
        @Binding var pickerVisible: Bool
        
        init(pickerVisible: Binding<Bool>) {
            _pickerVisible = pickerVisible
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            pickerVisible = false
            image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            pickerVisible = false
        }
    }
    
    @Binding var pickerVisible: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    let action: (UIImage?) -> Void
    
    func makeCoordinator() -> ImageViewController {
        return ImageViewController(pickerVisible: $pickerVisible)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImageView>) {
        action(context.coordinator.image)
    }
}
