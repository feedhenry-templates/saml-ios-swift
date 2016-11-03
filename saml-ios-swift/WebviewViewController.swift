/*
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import UIKit

class WebviewViewController: UIViewController, UIWebViewDelegate {

    internal var url: NSURL?

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView: UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        guard let url = url else {
            return
        }
        webView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight];
        webView.scalesPageToFit = true;
        webView.loadRequest(NSURLRequest(URL: url))
        webView.delegate = self;
        self.view.addSubview(webView)
    }


    @available(iOS 2.0, *) func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        print("Webview fail with error \(error)");
    }

    @available(iOS 2.0, *) func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("shouldStartLoadWithRequest");
        let currentURL = request.URL!.absoluteString
        print("URL: \(currentURL)");
        if currentURL!.hasSuffix("login/ok") {
            presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("WebViewClosed", object: nil)
        }
        return true;
    }

    @available(iOS 2.0, *) func webViewDidStartLoad(webView: UIWebView) {
        print("Webview started Loading")
    }

    @available(iOS 2.0, *) func webViewDidFinishLoad(webView: UIWebView) {
        print("Webview did finish load")
    }

}
