//
//  ViewController.swift
//  browser
//
//  Created by Levan Charuashvili on 11.06.23.
//

import UIKit
import WebKit
import JGProgressHUD

class ViewController: UIViewController,WKNavigationDelegate,TabBarViewControllerDelegate {
    let spinner = JGProgressHUD(style: .dark)
    var webView:WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
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
        // show the spinner
        spinner.show(in: self.view)
        
        if text.lowercased().prefix(12) != "https://www." {
            let newUrl = URL(string: "https://www.\(text)")
            webView.load(URLRequest(url: newUrl!))
            print("first 12 prefix:\(String(describing: newUrl))")
            // web is laoded so spinner hide
            spinner.dismiss()
        } else {
            let newUrl = URL(string: "\(text.lowercased())")
            print("without prefix\(newUrl)")
            webView.load(URLRequest(url: newUrl!))
            spinner.dismiss()
        }
    }
    
    func goBack() {
        spinner.show(in: self.view)
        if webView.canGoBack{
            webView.goBack()
            spinner.dismiss()
        } else {
            print("cant go back")
            // error on screen
            spinner.dismiss()
        }
    }
    
    func goForward() {
        spinner.show(in: self.view)
        if webView.canGoForward {
            webView.goForward()
            spinner.dismiss()
        } else {
            print("cant go forward")
            //also error on screen 
            spinner.dismiss()
        }
    }

}

