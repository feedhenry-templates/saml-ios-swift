import UIKit
import FeedHenry

class HomeViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO replace by #selector Swift2.2 syntax once BF uses Xcode7.3
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "onCloseWebview", name: "WebViewClosed", object: nil)
    }

    @IBAction func login(sender: AnyObject) {

        self.signInButton.enabled = false;

        let args = ["token": "xxxx"]; //TODO: Replace by: Config.instance.uuid

        FH.cloud("/sso/session/login_host", method: HTTPMethod.POST,
                args: args, headers: nil,
                completionHandler: {
                    (response: Response, error: NSError?) -> Void in
                    self.signInButton.enabled = true;
                    if let error = error {
                        print("Cloud Call Failed, \(error)");
                        return
                    } else if let parsedRes = response.parsedResponse as? [String:String] {
                        let urlString = parsedRes["sso"];

                        // Display WebView
                        let controller = WebviewViewController()
                        controller.url = NSURL(string: urlString!);
                        self.presentViewController(controller, animated: true, completion: nil);
                        return;
                    }
                })

    }

    func onCloseWebview() {
        print("onCloseWebview");
        self.performSegueWithIdentifier("showLoggedIn", sender: self);
    }


}
