//
//  ContentView.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationView {
      HomeView()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
