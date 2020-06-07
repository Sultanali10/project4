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
    var websites = ["Youtube.com" , "Dailymotion.com" , "Google.com" ]
    var newSite  = "facebook.com"

    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(openTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(adding))
        
        let fSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton , fSpace, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[2])
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func adding() {
        
        let alert = UIAlertController(title: "Add new website", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your site"
            
        }
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let textfield = (alert.textFields?.first)! as UITextField
            self.newSite = textfield.text ?? "twitter.com"
            self.websites += [self.newSite]
            
            }
            
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert , animated: true)
    }
    

    
    @objc func openTapped() {
        
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for website in websites {
             ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancel)
        
        present(ac , animated: true)
        
    }

    func openPage(action: UIAlertAction){
        
        progressView.isHidden = false
        let url = URL(string: "https://www." + action.title!)!
        webView.load(URLRequest(url: url))
    
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        title = webView.title
        progressView.isHidden = true
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            progressView.progress = Float(webView.estimatedProgress)
            
        }
        
    }

}

