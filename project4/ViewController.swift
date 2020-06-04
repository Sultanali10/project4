//
//  ViewController.swift
//  project4
//
//  Created by Sultan Ali on 03/06/2020.
//  Copyright © 2020 Sultan Ali. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController , WKNavigationDelegate {
    
    var webView: WKWebView!

    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.google.com/")
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }


}

