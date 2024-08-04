//
//  ToggleBookMark.swift
//  SampleProject
//
//  Created by Valeh Amirov on 29.05.24.
//

import SwiftUI

struct ToggleBookMark: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            
            if configuration.isOn {
                Image("bookMarkFill")
            } else {
                Image("bookMark")
            }
        }
    }
}
