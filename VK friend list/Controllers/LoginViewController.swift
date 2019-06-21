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
    
    let identifier = Identifier()
    
    var accessData = AccessData(token: "", userId: "")
    
    
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
            
            print(url)
            
            guard let query = url.absoluteString.components(separatedBy: "#").last else {
                print("No query")
                return
            }
            
            print(query)
            
            query.components(separatedBy: "&").forEach {
                
                let pair = $0.components(separatedBy: "=")
                
                guard pair.count == 2 else {
                    print("No pair")
                    return
                }
                
                guard let key = pair.first,
                    let value = pair.last else {
                        return
                }
                
                if key == "access_token" {
                    accessData.token = value
                } else if key == "user_id" {
                    accessData.userId = value
                }
            }
            
            print("accessData: ", accessData)
            
            performSegue(withIdentifier: identifier.friendList, sender: self)
            
        }
        
        decisionHandler(.allow)
    }
}







