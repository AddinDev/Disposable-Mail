//
//  Message.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import Foundation

struct Message: Identifiable, Codable {
  let id: Int
  let from, subject, date: String
}
