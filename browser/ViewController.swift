//
//  ViewController.swift
//  browser
//
//  Created by Levan Charuashvili on 11.06.23.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate,TabBarViewControllerDelegate {

    var webView:WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        let url = URL(string: "https://roblox.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        if let tabBarController = self.tabBarController as? TabBar {
            tabBarController.tabBarDelegate = self
        }
    }
    
    
    
    // delegates from tabbar below
    
    func textFieldDidReturn(withText text: String) {
        var newUrl = URL(string: "\(text)")
        webView.load(URLRequest(url: newUrl!))
        }
    
    func goBack() {
        if webView.canGoBack{
            webView.goBack()
        } else {
            print("cant go back")
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        } else {
            print("cant go forward")
        }
    }

}

