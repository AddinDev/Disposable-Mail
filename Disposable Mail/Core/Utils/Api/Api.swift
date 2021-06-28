//
//  Api.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import Foundation

struct Api {
  static let domains = "https://www.1secmail.com/api/v1/?action=getDomainList"
  static let messages = "https://www.1secmail.com/api/v1/?action=getMessages" // &login=asda&domain=1secmail.com
  static let detail = "https://www.1secmail.com/api/v1/?action=readMessage" // &login=asda&domain=1secmail.com&id=214015670
}
