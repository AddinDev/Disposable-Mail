//
//  MessageDetail.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import Foundation

struct MessageDetail: Codable {
  let id: Int
  let from, subject, date: String
  let body, textBody, htmlBody: String
}
