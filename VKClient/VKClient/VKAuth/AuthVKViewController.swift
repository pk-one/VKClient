//
//  AuthVKViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.08.2021.
//
import UIKit
import WebKit

class AuthVKViewController: UIViewController {
    
    @IBOutlet var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
    }
    
    private func checkAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7936945"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webview.load(request)
    }
    
}

extension AuthVKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params["access_token"],
              let userId = params["user_id"],
              let intUserId = Int(userId) else {
                decisionHandler(.allow)
                return
        }
        SessionInfo.shared.token = token
        SessionInfo.shared.userId = Int(intUserId)
        decisionHandler(.cancel)
        
        if SessionInfo.shared.token != "",
           SessionInfo.shared.userId != 0 {
            
            moveToTabBarController()
        }
    }
    
    func moveToTabBarController() {
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else { return }
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
}

