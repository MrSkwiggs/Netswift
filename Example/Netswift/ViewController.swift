//
//  ViewController.swift
//  Netswift
//
//  Created by MrSkwiggs on 05/11/2019.
//  Copyright (c) 2019 MrSkwiggs. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15, *) {
            Task {
                let result = await API.YourEndpoint.example.perform()
                guard let html = result.value else { return }
                self.webView.loadHTMLString(html, baseURL: nil)
            }
        } else {
            API.YourEndpoint.example.perform { result in
                guard let html = result.value else {
                    return
                }

                DispatchQueue.main.async {
                    self.webView.loadHTMLString(html, baseURL: nil)
                }
            }
        }
    }
}

