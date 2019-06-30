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
    
    let autorizationPathConfiguration = AutorizationPathConfiguration()
    
    let networkService = NetworkService()
    
    let identifier = Identifier()
    
    var userAccessData = UserAccessData(token: "", userId: "")
    
    
    @IBOutlet private weak var wvLogin: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = autorizationPathConfiguration.url else {
            print("url not received")
            return
        }
        
        wvLogin.navigationDelegate = self

        let request = URLRequest(url: url)

        wvLogin.load(request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ListViewController else {
            return
        }
        
        destinationVC.listViewModel.userAccessData = userAccessData
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
                    userAccessData.token = value
                } else if key == "user_id" {
                    userAccessData.userId = value
                }
            }
            
            print("accessData: ", userAccessData)
            
            performSegue(withIdentifier: identifier.friendList, sender: self)
        }
        
        decisionHandler(.allow)
    }
}







