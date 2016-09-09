//
//  WKWebView+Utilities.swift
//  Pods
//
//  Created by Steven Preston on 9/7/16.
//
//

import WebKit

public extension WKWebView {
    public func stripAllElementsExcept(elementWithId: String, completionHandler: ((AnyObject?, NSError?) -> Void)?) {
        let tempDelegate = self.navigationDelegate
        self.navigationDelegate = nil
        self.evaluateJavaScript("document.body.innerHTML = document.getElementById('\(elementWithId)').innerHTML;", completionHandler: completionHandler);
        self.navigationDelegate = tempDelegate
    }
}
