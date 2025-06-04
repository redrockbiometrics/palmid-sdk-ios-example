//
//  ViewController.swift
//  PalmIDSDKExample
//
//  Created by PalmID on 2025/5/20.
//

import UIKit
import PalmIDNativeSDK

class ViewController: UIViewController {
    private var entrypoint: String = "https://api-us-west.redrockbiometrics.com/saas/api/"
    private var accessToken: String = ""  // Optional. If not provided, it will be automatically generated using partnerId and projectId.
    private var requiredEnrollmentScans: Int = 1  // Optional. Required number of scans for enrollment

    var palmId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        PalmIDNativeSDK.sharedInstance().initialize(withEntrypoint: entrypoint, partnerId: partnerId, projectId: projectId, accessToken: nil, requiredEnrollmentScans: NSNumber(value: requiredEnrollmentScans)) { success in
            print("init sdk result: \(success)")
        }
    }
    
    @IBAction func onEnroll(_ sender: Any) {
        var load = PalmIDNativeSDKLoadController()
        PalmIDNativeSDK.sharedInstance().enroll(with: self.navigationController!, loadController: load) { result in
            self.palmId = result.data.palmId
            print("sdk result: \(result)")
        }
    }
    
    @IBAction func onIdentify(_ sender: Any) {
        var load = PalmIDNativeSDKLoadController()
        PalmIDNativeSDK.sharedInstance().identify(with: self.navigationController!, loadController: load) { result in
            self.palmId = result.data.palmId
            print("sdk result: \(result)")
        }
    }
    
    
    @IBAction func onVerify(_ sender: Any) {
        var load = PalmIDNativeSDKLoadController()
        PalmIDNativeSDK.sharedInstance().verify(withPalmId: self.palmId, navigationController: self.navigationController!, loadController: load) { result in
            print("sdk result: \(result)")
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        PalmIDNativeSDK.sharedInstance().deleteUser(self.palmId) { result in
            print("sdk result: \(result)")
            self.palmId = ""
        }
    }
    
    
    @IBAction func onDestory(_ sender: Any) {
        PalmIDNativeSDK.sharedInstance().releaseEngine()
    }
}

