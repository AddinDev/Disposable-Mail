//
//  MessageDetailView.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import SwiftUI

struct MessageDetailView: View {
  
  @ObservedObject private var vm = DetailVM()
  
  @State private var i = 0
  
  private let screen = UIScreen.main.bounds
  
  var username: String
  var domain: String
  var id: Int
  
  var body: some View {
    Group {
      if vm.isErrorDetail {
        errorIndicator
      } else if vm.isLoadingDetail {
        loadingIndicator
      } else {
        content
      }
    }
    .onAppear {
      i += 1
      if i == 1 {
        vm.getDetail(username, domain, id)
      }
    }
  }
  
}

extension MessageDetailView {
  
  var message: MessageDetail {
    vm.messageDetail
  }
  
  var loadingIndicator: some View {
    ProgressView()
  }
  
  var errorIndicator: some View {
    Text(vm.errorMsgDetail)
      .foregroundColor(.red)
  }
  
  var content: some View {
    ScrollView {
      VStack(alignment: .leading) {
        Text("from: \(message.from)")
        Text("subject: \(message.subject)")
        Text("date: \(message.date)")
        HTMLStringView(htmlContent: message.htmlBody)
          .frame(height: screen.height / 3)
      }
    }
  }
  
}
