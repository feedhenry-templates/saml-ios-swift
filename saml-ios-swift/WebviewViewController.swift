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

    internal var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView: UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        guard let url = url else {
            return
        }
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        webView.scalesPageToFit = true;
        webView.loadRequest(URLRequest(url: url))
        webView.delegate = self;
        self.view.addSubview(webView)
    }


    @available(iOS 2.0, *) func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview fail with error \(error)");
    }

    @available(iOS 2.0, *) func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("shouldStartLoadWithRequest");
        let currentURL = request.url!.absoluteString
        print("URL: \(currentURL)");
        if currentURL.hasSuffix("login/ok") {
            presentingViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "WebViewClosed"), object: nil)
        }
        return true;
    }

    @available(iOS 2.0, *) func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview started Loading")
    }

    @available(iOS 2.0, *) func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Webview did finish load")
    }

}
