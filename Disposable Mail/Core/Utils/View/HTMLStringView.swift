//
//  HTMLStringView.swift
//  Disposable Mail
//
//  Created by addin on 28/06/21.
//

import SwiftUI
import WebKit

struct HTMLStringView: UIViewRepresentable {
  let htmlContent: String
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    uiView.loadHTMLString(htmlContent, baseURL: nil)
  }
}
