//
//  BookViewController.swift
//  WorldTrotter
//
//  Created by Lauren Phan on 1/22/21.
//

import Foundation
import UIKit
import WebKit

class BookViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"https://bignerdranch.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}
