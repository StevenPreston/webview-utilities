# WebView-Utilities

[![CI Status](http://img.shields.io/travis/Steven Preston/WebView-Utilities.svg?style=flat)](https://travis-ci.org/Steven Preston/WebView-Utilities)
[![Version](https://img.shields.io/cocoapods/v/WebView-Utilities.svg?style=flat)](http://cocoapods.org/pods/WebView-Utilities)
[![License](https://img.shields.io/cocoapods/l/WebView-Utilities.svg?style=flat)](http://cocoapods.org/pods/WebView-Utilities)
[![Platform](https://img.shields.io/cocoapods/p/WebView-Utilities.svg?style=flat)](http://cocoapods.org/pods/WebView-Utilities)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

WebView-Utilities is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WebView-Utilities"
```

## Usage

All functions are exposed through an extension of WKWebView. Don't forget that the WKWebView should complete navigation before executing any of these. As a result, waiting for ```didFinishNavigation``` to fire is recommended.

The following functions are available:

### Clear the &lt;head&gt; element
```swift
func clearHead(completionHandler: ((AnyObject?, NSError?) -> Void)?)
```
Removes all HTML from the &lt;head&gt; element of the document currently loaded in the WKWebView.

### Add an element to the &lt;head&gt;
```swift
func addElementToHead(elementHTML: String, completionHandler: ((AnyObject?, NSError?) -> Void)?)
```
Add an element to the &lt;head&gt; element. Specify the HTML of the element, for example: 
```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
```

### Remove an element from the document
```swift
func removeElement(elementId: String, completionHandler: ((AnyObject?, NSError?) -> Void)?)
```
Remove an element with the specified ID from the document.

### Add CSS to the document
```swift
func addCSS(css: String, completionHandler: ((AnyObject?, NSError?) -> Void)?)
```
Injects CSS into the document by appending a &lt;style&gt; element to the &lt;head&gt;. For example:
```swift
webView.addCSS("body { margin: 20px; } .aClass { margin: 20px; }", completionHandler: nil)
```

### Remove all elements withing &lt;body&gt; except for one
```swift
func stripAllOtherElementsFromBody(elementId: String, completionHandler: ((AnyObject?, NSError?) -> Void)?)
```
Strips all elements from the document &lt;body&gt;, with the exeception of the element with the specified ID.

## Chaining methods

You may want to execute multiple functions that manipulate the DOM. Instead of executing multiple functions and chaining them through their completionHandlers, you can access the Javascript for each function and then concatenate each Javascript snippet:
```swift
let js = WKWebView.clearHeadJS() + WKWebView.addCSSJS("body { margin: 20px }")
```
You can then execute this through the provided convenience method:
```swift
webView.executeJavaScript(js, completionHandler: nil)
```
This is preferred over using ```evaluateJavascript``` as it prevents the navigation delegate from firing.

## Author

Steven Preston, stevenpreston@stellar16.com

## License

WebView-Utilities is available under the MIT license. See the LICENSE file for more info.
