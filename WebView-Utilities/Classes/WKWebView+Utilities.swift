//
//  WKWebView+Utilities.swift
//  Pods
//
//  Created by Steven Preston on 9/7/16.
//
//

import WebKit

extension WKWebView {
    func removeAllOtherElements(element: String) {
        let tempDelegate = self.navigationDelegate
        self.navigationDelegate = nil
        self.evaluateJavaScript("document.body.innerHTML = document.getElementById('\(element)').innerHTML;", completionHandler: nil);
        self.navigationDelegate = tempDelegate
    }
}
