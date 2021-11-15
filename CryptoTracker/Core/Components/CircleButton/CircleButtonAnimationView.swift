//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 15/11/2021.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animated: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animated ? 1.0 : 0.0)
            .opacity(animated ? 0.0 : 1.0 )
            .animation(animated ? .easeInOut(duration: 1.0) : .none,
                       value: animated)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animated: .constant(true))
    }
}
