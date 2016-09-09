//
//  WKWebView+UtilitiesSpec.swift
//  WebView-Utilities
//
//  Created by Steven Preston on 9/8/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import WebView_Utilities
import WebKit

class NavigationDelegate: NSObject, WKNavigationDelegate {
    var pageLoaded = false
    @objc func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        pageLoaded = true
    }
}

class WKWebView_UtilitiesSpec: QuickSpec {
    override func spec() {
        let webView = WKWebView(frame: CGRectMake(0, 0, 320, 640))
        let navigationDelegate = NavigationDelegate()
        let html =
            "<!DOCTYPE html>" +
            "<html>" +
            "  <head></head>" +
            "  <body>" +
            "    <div id='keep'>keep</div>" +
            "    <div id='remove'>remove</div>" +
            "  </body>" +
            "</html>"

        beforeEach {
            navigationDelegate.pageLoaded = false
            webView.navigationDelegate = navigationDelegate
            webView.loadHTMLString(html, baseURL: nil)
        }

        describe("WKWebView.stripAllElementsExcept") {
            it ("should not return a JavaScript error") {
                expect(navigationDelegate.pageLoaded).toEventually(beTrue())

                var noError = false
                webView.stripAllElementsExcept("keep", completionHandler: { (result: AnyObject?, error: NSError?) in
                    noError = error == nil
                })
                expect(noError).toEventually(beTrue())
            }
        }
    }
}
