//
//  SettingsView.swift
//  Lab1_2022
//
//  Created by ICS 224 on 2022-01-25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var colour: Color
    @Binding var stepperValue: Int
    
    let stepperRange:  ClosedRange<Int> = 10...300
    let stepperStep: Int = 10
    
    var body: some View {
        ColorPicker("Background", selection: Binding(
            get: {
                colour
            },
            set: {
                newValue in
                UserDefaults.standard.set(color2array(colour: colour), forKey:
                "BackgroundColour")
                colour = newValue
            })
        )
        .accessibilityIdentifier("BackgroundColorPicker")
        
        Stepper(value: Binding(
            get: {
                stepperValue
            },
            set: {
                newValue in
                UserDefaults.standard.set(newValue, forKey:
                "MaxCharacterCount")
                stepperValue = newValue
            }
        ), in: stepperRange, step: stepperStep){
            Text("Max Character Count:\n" + String(stepperValue));
        }
        .accessibilityIdentifier("MaxCountStepper")
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var colour = array2color(array: UserDefaults.standard.object(forKey: "BackgroundColour") as? [CGFloat] ?? color2array(colour: Color.yellow))
    @State static var stepperValue = UserDefaults.standard.object(forKey: "MaxCharacterCount") as? Int ??
    150;
    
    static var previews: some View {
        SettingsView(colour: $colour, stepperValue: $stepperValue)
    }
}
