//
//  ContentView.swift
//  Lab1_2022
//
//  Created by ICS 224 on 2022-01-20.
//

import SwiftUI
import Photos

struct DetailView: View {
    var colour: Color;
    var stepperValue: Int;
    
    @State var pickerVisible = false
    @State var showCameraAlert = false
    @State var imageSource = UIImagePickerController.SourceType.camera
    @State var showLibraryAlert = false;
    
    @Binding var inventoryItem: InventoryItem;
    @Binding var favouriteExists: Bool;
    
    var body: some View {
        ZStack{
        VStack {
            //Image(systemName: "pencil.tip")
            Image(uiImage: inventoryItem.image).resizable()
                .gesture(TapGesture(count: 1).onEnded({ value in
                PHPhotoLibrary.requestAuthorization({ status in
                    if status == .authorized {
                        self.showLibraryAlert = false
                        self.imageSource = UIImagePickerController.SourceType.photoLibrary
                        self.pickerVisible.toggle()
                    } else {
                        self.showLibraryAlert = true
                    }
                })
            }))
                .alert(isPresented: $showLibraryAlert) {
                    Alert(title: Text("Error"), message: Text("Photo library not available"), dismissButton: .default(Text("OK")))
                }
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .leading)
                .background(inventoryItem.favourite ? colour : Color.white)
                .border(inventoryItem.favourite ? colour : Color.white, width: 20)
                .accessibilityIdentifier( "DetailImage")
                
            Toggle(isOn: Binding(
                    get: {
                        inventoryItem.favourite
                    },
                    set: {
                        newValue in
                        UserDefaults.standard.set(newValue, forKey: "FavouriteObject")
                        if newValue && !favouriteExists {
                            inventoryItem.favourite = newValue;
                            favouriteExists = newValue
                        }
                        else if !newValue {
                            inventoryItem.favourite = newValue;
                            favouriteExists = newValue
                        }
                    }
                )){
                Text("Favourite")
                    .frame(width: 200, height: 100, alignment: .leading)
            }
                .accessibilityIdentifier( "FavouriteToggle")
            TextEditor(text: Binding(
                get: {
                    inventoryItem.description;
                },
                set: {
                    newValue in
                    UserDefaults.standard.set(newValue, forKey: "DescriptionText")
                    if newValue.count <= stepperValue {
                        inventoryItem.description = newValue;
                    }
                }
            ))
                .accessibilityIdentifier("DetailTextEditor")
            Text(String(inventoryItem.description.count) + "/" + String(stepperValue))
                .accessibilityIdentifier("DetailText")
                .navigationBarItems(trailing:
                    Button(action: {
                        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                            if response && UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                                self.showCameraAlert = false
                                self.imageSource = UIImagePickerController.SourceType.camera
                                self.pickerVisible.toggle()
                            } else {
                                  self.showCameraAlert = true
                            }
                        }
                    }) {
                            Image(systemName: "camera")
                        }
                        .alert(isPresented: $showCameraAlert) {
                            Alert(title: Text("Error"), message: Text("Camera not available"), dismissButton: .default(Text("OK")))
                        }
                )
        }
        .padding(.all, 5.0)
        if pickerVisible {
            ImageView(pickerVisible: $pickerVisible, sourceType: $imageSource, action: { (value) in
                if let image = value {
                    self.inventoryItem.image = image
                }
            })
        }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    @State static var stepperValue = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ?? 150;
    var inventoryItems = InventoryItems()
 
    static var previews: some View {
        SettingsView(colour: $colour, stepperValue: $stepperValue);
    }
}
