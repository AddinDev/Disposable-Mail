//
//  HomeVM.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import Foundation
import Alamofire

class HomeVM: ObservableObject {
  
  @Published var domains: [String] = []
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMsg = ""

  func getDomains() {
    print("getting domains")
    self.isLoading = true
    guard let url = URL(string: Api.domains) else { return }
    AF.request(url)
      .validate()
      .responseDecodable(of: [String].self) { response in
        switch response.result {
        case .failure(let error):
          self.errorMsg = error.localizedDescription
          self.isError = true
          self.isLoading = false
          print(error)
        case .success(let domains):
          self.domains = domains
          self.isLoading = false
        }
      }
  }
  
}
