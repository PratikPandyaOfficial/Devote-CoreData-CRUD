//
//  BackgroundImageView.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 20/12/23.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
