//
//  DetailVM.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import Foundation
import Alamofire

class DetailVM: ObservableObject {
  
  @Published var messages: [Message] = []
  @Published var messageDetail: MessageDetail
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMsg = ""
  
  // detail
  @Published var isLoadingDetail = false
  @Published var isErrorDetail = false
  @Published var errorMsgDetail = ""
  
  init() {
    self.messageDetail = msgdetail
  }
  
  let msgdetail = MessageDetail(id: 1, from: "", subject: "", date: "", body: "", textBody: "", htmlBody: "")
  
  func getMessages(_ username: String, _ domain: String) {
    print("getting messages")
    self.isLoading = true
    guard let url = URL(string: Api.messages + "&login=" + username + "&domain=" + domain) else { return }
    AF.request(url)
      .validate()
      .responseDecodable(of: [Message].self) { response in
        switch response.result {
        case .failure(let error):
          self.errorMsg = error.localizedDescription
          self.isError = true
          self.isLoading = false
          print(error)
        case .success(let messages):
          self.messages = messages
          self.isLoading = false
        }
      }
  }
  
  func getDetail(_ username: String, _ domain: String, _ id: Int) {
    print("getting detail")
    self.isLoadingDetail = true
    guard let url = URL(string: Api.detail + "&login=" + username + "&domain=" + domain + "&id=" + "\(id)") else { return }
    AF.request(url)
      .validate()
      .responseDecodable(of: MessageDetail.self) { response in
        switch response.result {
        case .failure(let error):
          self.errorMsgDetail = error.localizedDescription
          self.isErrorDetail = true
          self.isLoadingDetail = false
          print(error)
        case .success(let detail):
          self.messageDetail = detail
          self.isLoadingDetail = false
        }
      }
  }
  
}
