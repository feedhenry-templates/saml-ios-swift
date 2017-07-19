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
        NotificationCenter.default.addObserver(self,
            selector: #selector(HomeViewController.onCloseWebview), name: Notification.Name(rawValue: "WebViewClosed"), object: nil)
    }

    @IBAction func login(_ sender: AnyObject) {

        self.signInButton.isEnabled = false;

        let args = ["token": Config.instance.uuid];

        FH.cloud(path: "/sso/session/login_host", method: HTTPMethod.POST,
                args: args as [String : AnyObject]?, headers: nil,
                completionHandler: {
                    (response: Response, error: NSError?) -> Void in
                    self.signInButton.isEnabled = true;
                    if let error = error {
                        print("Cloud Call Failed, \(error)");
                        let alert = UIAlertController(title: "Cloud Call Failed", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    } else if let parsedRes = response.parsedResponse as? [String:String] {
                        let urlString = parsedRes["sso"];

                        // Display WebView
                        let controller = WebviewViewController()
                        controller.url = NSURL(string: urlString!) as URL?;
                        self.present(controller, animated: true, completion: nil);
                        return;
                    }
                })

    }

    func onCloseWebview() {
        print("onCloseWebview");
        self.performSegue(withIdentifier: "showLoggedIn", sender: self);
    }


}
