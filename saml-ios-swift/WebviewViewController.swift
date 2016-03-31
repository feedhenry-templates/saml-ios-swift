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


    @available(iOS 2.0, *) func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Webview fail with error \(error)");
    }

    @available(iOS 2.0, *) func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("shouldStartLoadWithRequest");
        let currentURL = request.URL!.absoluteString
        print("URL: \(currentURL)");
        if currentURL.hasSuffix("login/ok") {
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
