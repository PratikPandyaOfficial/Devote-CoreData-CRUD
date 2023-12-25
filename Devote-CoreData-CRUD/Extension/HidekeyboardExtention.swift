//
//  HidekeyboardExtention.swift
//  Devote-CoreData-CRUD
//
//  Created by Drashti on 19/12/23.
//

import SwiftUI

#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
