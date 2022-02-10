//
//  AuthVKViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 29.08.2021.
//
import UIKit
import WebKit
import SwiftKeychainWrapper

class AuthVKViewController: UIViewController {
    
    private let dataOperation = DataOperation()
    
    @IBOutlet var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    
    private var canPresent: Bool = false
    private let timeToSecnod: Double = 86400.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
    }
    
    private func checkAuth() {
        
        if let keychainData = KeychainWrapper.standard.string(forKey: "user") {
            let data = Data(keychainData.utf8)
            
            if let decodeUser = decode(json: data, as: KeychainUser.self) {
                
                let now = Date().timeIntervalSince1970
                let isActiveDate = (now - decodeUser.date) < timeToSecnod
                
                if isActiveDate {
                    SessionInfo.shared.token = decodeUser.token
                    SessionInfo.shared.userId = decodeUser.id
                    
                    self.canPresent = true
                    return
                }
            }
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7936945"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webview.load(request)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if self.canPresent {
            moveToTabBarController()
        }
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
            
            let user = KeychainUser(id: SessionInfo.shared.userId,
                                    token: SessionInfo.shared.token,
                                    date: Date().timeIntervalSince1970)
            
            let encodedUser = encode(object: user)
            KeychainWrapper.standard["user"] = encodedUser
            
            moveToTabBarController()
        
        }
    }
    
    func moveToTabBarController() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarController") as? UITabBarController else { return }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        dataOperation.getGroup()
    }
}

extension AuthVKViewController {
    func encode<T: Codable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(object)
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func decode<T: Decodable>(json: Data, as class: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: json)
            
            return data
        } catch {
            print("An error occurred while parsing JSON")
        }
        
        return nil
    }
}
