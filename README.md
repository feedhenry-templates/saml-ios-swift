# saml-ios-swift [![Build Status](https://travis-ci.org/feedhenry-templates/saml-ios-swift.png)](https://travis-ci.org/feedhenry-templates/saml-ios-swift)

> ObjC version is available [here](https://github.com/feedhenry-templates/saml-ios-app/).

Author: Daniel Passos   
Level: Intermediate  
Technologies: Swift 2.3, iOS, RHMAP, CocoaPods.  
Summary: A demonstration of how to work with [```SAML Service``` connector service](https://github.com/feedhenry-templates/saml-service). To configure the service in your RHMAP platform read the [SAML notes](https://github.com/feedhenry-templates/saml-service/blob/master/NOTES.md)
Project : [Feed Henry](http://feedhenry.org)
Target Product: RHMAP  
Product Versions: RHMAP 3.10.0+   
Source: https://github.com/feedhenry-templates/pushstarter-ios-app  
Prerequisites: fh-ios-swift-sdk : 4.2+, Xcode : 8+, iOS SDK : iOS8+, CocoaPods: 1.1.0+

## What is it?

The ```SAML``` project demonstrates how to how with [```SAML Service``` connector service](https://github.com/feedhenry-templates/saml-service)

If you do not have access to a RHMAP instance, you can sign up for a free instance at [https://openshift.feedhenry.com/](https://openshift.feedhenry.com/).

## How do I run it?  

### RHMAP Studio

This application and its cloud services are available as a project template in RHMAP as part of the "Push Notification Hello World" template.

### Local Clone (ideal for Open Source Development)

If you wish to contribute to this template, the following information may be helpful; otherwise, RHMAP and its build facilities are the preferred solution.

## Build instructions

1. Clone this project

2. Populate ```saml-ios-swift/fhconfig.plist``` with your values as explained [here](http://docs.feedhenry.com/v3/dev_tools/sdks/ios.html#ios-configure).

3. Run ```pod install```

4. Open saml-ios-swift.xcworkspace

4. Run the project

### iOS9 and non TLS1.2 backend

If your RHMAP is depoyed without TLS1.2 support, open as source  ```saml-ios-swift/saml-ios-swift-Info.plist``` add the exception lines:

```
  <key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
  </dict>
```
