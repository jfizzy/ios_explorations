//
//  ViewController.swift
//  AWSTutorial
//
//  Created by James MacIsaac on 2018-01-31.
//  Copyright © 2018 James MacIsaac. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import AWSPinpoint

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            presentAuthUIViewController()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAuthUIViewController() {
        let config = AWSAuthUIConfiguration()
        config.enableUserPoolsUI = true
        //config.addSignInButtonView(class: AWSFacebookSignInButton.self)
        //config.addSignInButtonView(class: AWSGoogleSignInButton.self)
        config.canCancel = true
        
        AWSAuthUIViewController.presentViewController(
            with: self.navigationController!,
            configuration: config, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error == nil {
                    // SignIn succeeded.
                } else {
                    // end user faced error while logging in, take any required action here.
                }
        })
    }
    
    func logEvent() {
        // Custom AWS analytical event which will post to the AWS console
        let pinpointAnalyticsClient =
            AWSPinpoint(configuration:
                AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: nil)).analyticsClient
        
        let event = pinpointAnalyticsClient.createEvent(withEventType: "User Logged In")
        event.addAttribute("DemoAttributeValue1", forKey: "DemoAttribute1")
        event.addAttribute("DemoAttributeValue2", forKey: "DemoAttribute2")
        event.addMetric(NSNumber.init(value: arc4random() % 65535), forKey: "User Logged In")
        pinpointAnalyticsClient.record(event)
        pinpointAnalyticsClient.submitEvents()
        
    }
    
    func sendMonetizationEvent()
    {
        // Custom AWS monetization event which will post to the AWS cloud
        let pinpointClient = AWSPinpoint(configuration:
            AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: nil))
        
        let pinpointAnalyticsClient = pinpointClient.analyticsClient
        
        let event =
            pinpointAnalyticsClient.createVirtualMonetizationEvent(withProductId:
                "DEMO_PRODUCT_ID", withItemPrice: 1.00, withQuantity: 1, withCurrency: "USD")
        pinpointAnalyticsClient.record(event)
        pinpointAnalyticsClient.submitEvents()
    }
}

