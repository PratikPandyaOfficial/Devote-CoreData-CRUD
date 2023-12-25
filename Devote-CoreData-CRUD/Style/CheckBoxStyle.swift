//
//  CheckBoxStyle.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 20/12/23.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                    if configuration.isOn{
                        playSound(sound: "sound-rise", type: "mp3")
                    }
                    else{
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        }//: Hstack
    }
}

#Preview {
    Toggle("place holder", isOn: .constant(true))
        .toggleStyle(CheckBoxStyle())
}
