//
//  KeyboardLayoutVStack.swift
//  Cashback
//
//  Created by Giorgos Mparmpas on 6/6/23.
//

import Foundation
import Combine
import UIKit
import SwiftUI

/**
    # KeyboardLayoutVStack
    This VStack is used in order to adapt is size base on keyboard visibility.
 */
public struct KeyboardLayoutVStack <Content: View>: View {
    
    @ObservedObject var keyboardManager = KeyboardManager.shared
    
    public init(@ViewBuilder content: @escaping () -> Content) { self.content = content }
    
    var content: () -> Content
    
    public var body: some View {
        VStack {
            content()
        }.padding(.bottom, keyboardManager.keyboardHeight)
         .edgesIgnoringSafeArea(.bottom)
    }
}
