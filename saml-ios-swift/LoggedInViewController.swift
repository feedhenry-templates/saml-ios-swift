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

class LoggedInViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var session: UITextField!

    override func viewDidLoad() {
        print("LoggedInViewController.viewDidLoad");

        super.viewDidLoad();

        let args = ["token": Config.instance.uuid];

        FH.cloud("sso/session/valid", method: HTTPMethod.POST,
                args: args, headers: nil,
                completionHandler: {
                    (response: Response, error: NSError?) -> Void in
                    if let error = error {
                        print("Request name failure, \(error)");
                        return
                    }

                    let parsedRes: NSDictionary = response.parsedResponse!
                    self.name.text = parsedRes.valueForKey("first_name") as? String;
                    self.email.text = parsedRes.valueForKey("email") as? String;
                    self.session.text = parsedRes.valueForKey("expires") as? String;

                    return;

                });


    }

}
