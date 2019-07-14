//
//  ViewController.swift
//  VK friend list
//
//  Created by Vladimir on 20/06/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, LoginController {
    
    let autorizationPathConfiguration = AutorizationPathConfiguration()
    
    let networkService = NetworkService()
    
    let identifier = Identifier()
    
    var friendListConfiguration: FriendListConfiguration?
    
    private var userAccessData = UserAccessData(token: "", userId: "")
    
    
    @IBOutlet private weak var wvLogin: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = autorizationPathConfiguration.url else { return }
        
        wvLogin.navigationDelegate = self

        let request = URLRequest(url: url)

        wvLogin.load(request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? FriendListController else {
            return
        }
        
        guard let friendListConfiguration = friendListConfiguration else {
            fatalError("friendsListConfiguration` must be set prior to `FriendsListController` presentation")
        }
        
        destinationVC.configure(with: friendListConfiguration)
        self.friendListConfiguration = nil
        
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
            
            friendListConfiguration = FriendListConfiguration(userAccessData: userAccessData)
            
            performSegue(withIdentifier: identifier.friendList, sender: self)
        }
        
        decisionHandler(.allow)
    }
}







