//
//  HomeView.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject private var vm = HomeVM()
  
  @State var showMessages: Bool = false
  
  @State var username: String = ""
  @State var selected: Int = 0
  
  private let screen = UIScreen.main.bounds
  
  var body: some View {
    Group {
      if vm.isError {
        errorIndicator
      } else if vm.isLoading {
        loadingIndicator
      } else {
        content
      }
    }
    .sheet(isPresented: $showMessages, content: {
      NavigationView {
      DetailView(username: username, domain: vm.domains[selected])
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
      }
    })
    .onAppear {
      if vm.domains.count == 0 {
        vm.getDomains()
      }
    }
  }
  
}

extension HomeView {
  
  var loadingIndicator: some View {
    ProgressView()
  }
  
  var errorIndicator: some View {
    Text(vm.errorMsg)
      .foregroundColor(.red)
  }
  
  var content: some View {
    Form {
      
      if vm.domains.count != 0 {
        Button(action: {
          showMessages = true
        }) {
          Text("\(username == "" ? "username" : username)@\(vm.domains[selected])")
        }
        .contextMenu {
          Button(action: {
            UIPasteboard.general.string = "\(username)@\(vm.domains[selected])"
          }) {
            Text("Copy to clipboard")
            Image(systemName: "doc.on.doc")
          }
        }
        .disabled(username == "" ? true : false)
      }
      
      //      Section {
      //        Button(action: {
      //          UIPasteboard.general.string = "\(username)@\(vm.domains[selected])"
      //        }) {
      //          HStack {
      //          Text("Copy Email")
      //            Spacer()
      //          Image(systemName: "doc.on.doc")
      //          }
      //        }
      //        .disabled(username == "" ? true : false)
      //      }
      
      Section {
        TextField("username", text: $username, onCommit: {
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
        .autocapitalization(.none)
        .disableAutocorrection(true)
      }
      
      Section {
        Picker("domain", selection: $selected) {
          ForEach(0 ..< vm.domains.count) { i in
            Text(vm.domains[i])
          }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(height: screen.height / 6)
      }
      
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
