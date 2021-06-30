//
//  DetailView.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import SwiftUI

struct DetailView: View {
  
  @ObservedObject private var vm = DetailVM()
  
  @State private var i = 0
  
//  let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
  
  var username: String
  var domain: String
  
  var body: some View {
    Group {
      if vm.isError {
        errorIndicator
      } else if vm.messages.count == 0 {
        emptyIndicator
      } else {
        content
      }
    }
    .navigationBarTitle("\(username)@\(domain)")
//    .onReceive(timer) { timer in
//      vm.getMessages(username, domain)
//    }
    .onAppear {
      i += 1
      if i == 1 {
        vm.getMessages(username, domain)
      }
    }
  }
  
}

extension DetailView {
  
  var loadingIndicator: some View {
    ProgressView()
  }
  
  var errorIndicator: some View {
    Text(vm.errorMsg)
      .foregroundColor(.red)
  }
  
  var emptyIndicator: some View {
    VStack {
    Text("Empty")
    Button("Refresh") {
      vm.getMessages(username, domain)
    }
    }
  }
  
  var content: some View {
    List(vm.messages, id: \.id) { message in
      NavigationLink(destination: MessageDetailView(username: username, domain: domain, id: message.id)) {
        VStack(alignment: .leading) {
          Text(message.from)
          Text(message.subject)
        }
      }
    }
  }
  
}
