//
//  ViewController.swift
//  WebView-Utilities
//
//  Created by Steven Preston on 09/07/2016.
//  Copyright (c) 2016 Steven Preston. All rights reserved.
//

import UIKit
import WebKit
import WebView_Utilities

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()

        if let url = NSURL(string: "http://www.stellar16.com") {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }

    private func setupView() {
        webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
    }

    private func setupConstraints() {
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[webView]|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: ["webView": webView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webView]|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: ["webView": webView]))
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        webView.stripAllOtherElementsFromBody("masthead") {_, _ in
            self.clearHead()
        }
    }

    func clearHead() {
        webView.clearHead() { _, _ in
            self.addElementToHead()
        }
    }

    func addElementToHead() {
        let viewport = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" >"
        webView.addElementToHead(viewport) { _, _ in
            self.addCSS()
        }
    }

    func addCSS() {
        webView.addCSS("#masthead { color: red; }", completionHandler: nil)
    }
}
