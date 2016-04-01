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

        let args = ["token": Config.instance.uuid];

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
