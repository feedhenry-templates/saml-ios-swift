import UIKit
import FeedHenry

class LoggedInViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var session: UITextField!

    override func viewDidLoad() {
        print("LoggedInViewController.viewDidLoad");

        super.viewDidLoad();

        let args = ["token": "xxxx"]; //TODO: Replace by: Config.instance.uuid

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
