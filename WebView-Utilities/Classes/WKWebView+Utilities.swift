//
//  WKWebView+Utilities.swift
//  Pods
//
//  Created by Steven Preston on 9/7/16.
//
//

import WebKit

public extension WKWebView {

    @objc public class func clearHeadJS() -> String {
        return
        "document.head.innerHTML = '';" +
        "true;"
    }

    @objc public class func addElementToHeadJS(elementHTML: String) -> String {
        return
        "var parent = document.head;" +
        "var tempParent = document.createElement('div');" +
        "tempParent.innerHTML = '\(elementHTML)';" +
        "parent.appendChild(tempParent.firstChild);" +
        "true;"
    }

    @objc public class func removeElementJS(elementId: String) -> String {
        return
        "var element = document.getElementById('\(elementId)');" +
        "if (element && element.parentNode) {" +
        "   element.parentNode.removeChild(element);" +
        "   true;" +
        "} else {" +
        "   false;" +
        "}"
    }

    @objc public class func stripAllOtherElementsFromBodyJS(elementId: String) -> String {
        return
        "var element = document.getElementById('\(elementId)');" +
        "if (element) {" +
        "   document.body.innerHTML = '';" +
        "   document.body.appendChild(element);" +
        "   true;" +
        "} else {" +
        "   false;" +
        "}"
    }

    @objc public class func addCSSJS(css: String) -> String {
        return
        "var style = document.createElement('style');" +
        "style.innerHTML = '\(css)';" +
        "document.head.appendChild(style);" +
        "document.getElementsByTagName('head')[0].innerHTML;" +
        "true;"
    }

    @objc public func clearHead(completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let js = WKWebView.clearHeadJS()
        executeJavaScript(js, completionHandler: completionHandler)
    }

    @objc public func stripAllOtherElementsFromBody(elementId: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let js = WKWebView.stripAllOtherElementsFromBodyJS(elementId)
        executeJavaScript(js, completionHandler: completionHandler)
    }

    @objc public func addElementToHead(elementHTML: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let js = WKWebView.addElementToHeadJS(elementHTML)
        executeJavaScript(js, completionHandler: completionHandler)
    }

    @objc public func removeElement(elementId: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let js = WKWebView.removeElementJS(elementId)
        executeJavaScript(js, completionHandler: completionHandler)
    }

    @objc public func addCSS(css: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let js = WKWebView.addCSSJS(css)
        executeJavaScript(js, completionHandler: completionHandler)
    }

    @objc public func executeJavaScript(javascript: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let tempDelegate = self.navigationDelegate
        self.navigationDelegate = nil
        self.evaluateJavaScript(javascript, completionHandler: completionHandler)
        self.navigationDelegate = tempDelegate
    }
}
