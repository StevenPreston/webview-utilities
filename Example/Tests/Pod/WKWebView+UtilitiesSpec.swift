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

struct WebResult {
    var noError: Bool
    var response: Bool

    init() {
        self.noError = false
        self.response = false
    }

    init(response: Bool, noError: Bool) {
        self.noError = noError
        self.response = response
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
        var webResult = WebResult()

        let resultHandler = { (result: AnyObject?, error: NSError?) -> WebResult in
            let noError = error == nil
            var response = false
            if let tempResult = result as? Bool {
                response = tempResult
            }
            return WebResult(response: response, noError: noError)
        }

        beforeEach {
            webResult = WebResult()
            navigationDelegate.pageLoaded = false
            webView.navigationDelegate = navigationDelegate
            webView.loadHTMLString(html, baseURL: nil)
            expect(navigationDelegate.pageLoaded).toEventually(beTrue())
        }

        describe("clearHeadJS") {
            it("should return a Javascript value of true") {
                webView.clearHead() { webResult = resultHandler($0, $1) }
                expect(webResult.noError).toEventually(beTrue())
                expect(webResult.response).to(beTrue())
            }
        }

        describe("WKWebView.stripAllOtherElementsFromBody") {
            context("when the element to keep exists") {
                it("should return a Javascript value of true") {
                    webView.stripAllOtherElementsFromBody("keep") { webResult = resultHandler($0, $1) }
                    expect(webResult.noError).toEventually(beTrue())
                    expect(webResult.response).to(beTrue())
                }
            }

            context("when the element to keep does not exist") {
                it("should return a Javascript value of true") {
                    webView.stripAllOtherElementsFromBody("nonexistent") { webResult = resultHandler($0, $1) }
                    expect(webResult.noError).toEventually(beTrue())
                    expect(webResult.response).to(beFalse())
                }
            }
        }

        describe("WKWebView.addElementToHead") {
            it("should return a Javascript value of true") {
                let elementHTML = "<style>body{margin: 20px;}</style>"
                webView.addElementToHead(elementHTML) { webResult = resultHandler($0, $1) }
                expect(webResult.noError).toEventually(beTrue())
                expect(webResult.response).to(beTrue())
            }
        }

        describe("WKWebView.removeElement") {
            context("when the element to keep exists") {
                it("should return a Javascript value of true") {
                    webView.removeElement("remove") { webResult = resultHandler($0, $1) }
                    expect(webResult.noError).toEventually(beTrue())
                    expect(webResult.response).to(beTrue())
                }
            }

            context("when the element to keep does not exist") {
                it("should return a Javascript value of true") {
                    webView.removeElement("nonexistent") { webResult = resultHandler($0, $1) }
                    expect(webResult.noError).toEventually(beTrue())
                    expect(webResult.response).to(beFalse())
                }
            }
        }

        describe("WKWebView.addCSS") {
            it("should return a Javascript value of true") {
                let css = "body{margin: 20px;}"
                webView.addCSS(css) { webResult = resultHandler($0, $1) }
                expect(webResult.noError).toEventually(beTrue())
                expect(webResult.response).to(beTrue())
            }
        }
    }
}
