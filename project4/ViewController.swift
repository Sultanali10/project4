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
    var progressView: UIProgressView!

    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(openTapped))
        
        let fSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton , fSpace, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://www.google.com/")
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openYoutube = UIAlertAction(title: "Youtube.com", style: .default, handler: openPage)
        let openDailymotion = UIAlertAction(title: "Dailymotion.com", style: .default, handler: openPage)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(openYoutube)
        ac.addAction(openDailymotion)
        ac.addAction(cancel)
        
        present(ac , animated: true)
        
    }

    func openPage(action: UIAlertAction){
        
        let url = URL(string: "https://www." + action.title!)!
        webView.load(URLRequest(url: url))
    
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

}

