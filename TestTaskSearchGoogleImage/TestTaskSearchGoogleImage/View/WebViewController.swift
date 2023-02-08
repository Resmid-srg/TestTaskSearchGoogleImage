//
//  WebViewController.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 08.02.23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var pictureSourceURL: String = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Delegates
        self.webView.navigationDelegate = self
        
        //Setups
        view.activityStartAnimating()
        
        let urlRequest = URLRequest(url: URL(string: pictureSourceURL)!)
        webView.load(urlRequest)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.view.activityStopAnimating()
    }
}
