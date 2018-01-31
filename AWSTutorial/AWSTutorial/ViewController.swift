//
//  ViewController.swift
//  AWSTutorial
//
//  Created by James MacIsaac on 2018-01-31.
//  Copyright © 2018 James MacIsaac. All rights reserved.
//

import UIKit
import AWSCore
import AWSPinpoint

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logEvent()
        print("Custom analytics event happened!")
        sendMonetizationEvent()
        print("Custom monetization event happened!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logEvent() {
        // Custom AWS analytical event which will post to the AWS console
        let pinpointAnalyticsClient =
            AWSPinpoint(configuration:
                AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: nil)).analyticsClient
        
        let event = pinpointAnalyticsClient.createEvent(withEventType: "EventName")
        event.addAttribute("DemoAttributeValue1", forKey: "DemoAttribute1")
        event.addAttribute("DemoAttributeValue2", forKey: "DemoAttribute2")
        event.addMetric(NSNumber.init(value: arc4random() % 65535), forKey: "EventName")
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

