//
//  ViewController.swift
//  VK friend list
//
//  Created by Vladimir on 20/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    let networkService = NetworkService()
    
    
    @IBOutlet private weak var wvLogin: WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://oauth.vk.com/authorize?client_id=\(networkService.configuration.applicationId)&display=mobile&redirect_url=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=\(networkService.configuration.apiVersion)"
        
        guard let url = URL(string: urlString) else {
            print("cant convert string to url")
            return
        }
        
        wvLogin.navigationDelegate = self
        
        let request = URLRequest(url: url)
        
        wvLogin.load(request)
    }
}


// MARK: - WKNavigationDelegate
extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url,
            url.absoluteString.contains("access_token"),
            url.absoluteString.contains("user_id") {
            
            var token = ""
            var userId = 0
            
            print(url)
        }
        
        decisionHandler(.allow)
    }
}







