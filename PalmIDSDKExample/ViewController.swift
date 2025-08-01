//
//  ViewController.swift
//  PalmIDSDKExample
//
//  Created by PalmID on 2025/5/20.
//

import UIKit
import PalmIDNativeSDK

class ViewController: UIViewController {
    private var palmServerEntrypoint: String = "https://api2.palmid.com/saas"
    private var appServerEntrypoint: String = "https://api2.palmid.com/saas"
    private var projectId: String = "" // Replace with your projectId
    private var requiredEnrollmentScans: Int = 1  // Optional. Required number of scans for enrollment

    var palmId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        PalmIDNativeSDK.sharedInstance().initialize(withPalmServerEntrypoint: palmServerEntrypoint, appServerEntrypoint: appServerEntrypoint, projectId: projectId, requiredEnrollmentScans: NSNumber(value: requiredEnrollmentScans)) { success in
            print("init sdk result: \(success)")
            self.showToast(message: "Initialize result: \(success)")
        }
    }
    
    @IBAction func onEnroll(_ sender: Any) {
        var load = PalmIDNativeSDKLoadController()
        PalmIDNativeSDK.sharedInstance().enroll(with: self.navigationController!, loadController: load) { result in
            if result.errorCode == 100004 {
                self.showDialog(title: "Error", message: "Duplicate enrollment, palms are already registered")
            } else {
                print("enroll result: \(result)")
                self.showDialog(title: "Result", message: "enroll result: \(result)")
                self.palmId = result.data.palmId
            }
        }
    }
    
    @IBAction func onIdentify(_ sender: Any) {
        var load = PalmIDNativeSDKLoadController()
        PalmIDNativeSDK.sharedInstance().identify(with: self.navigationController!, loadController: load) { result in
            print("identify result: \(result)")
            self.showDialog(title: "Result", message: "identify result: \(result)")
            self.palmId = result.data.palmId
        }
    }
    
    
    @IBAction func onVerify(_ sender: Any) {
        if palmId.isEmpty {
            self.showDialog(title: "Error", message: "Verification requires an input palmId")
        } else {
            var load = PalmIDNativeSDKLoadController()
            PalmIDNativeSDK.sharedInstance().verify(withPalmId: self.palmId, navigationController: self.navigationController!, loadController: load) { result in
                print("verify result: \(result)")
                self.showDialog(title: "Result", message: "verify result: \(result)")
            }
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        if palmId.isEmpty {
            self.showDialog(title: "Error", message: "DeleteUser requires an input palmId")
        } else {
            PalmIDNativeSDK.sharedInstance().deleteUser(self.palmId) { result in
                print("deleteUser result: \(result)")
                self.showDialog(title: "Result", message: "deleteUser result: \(result)")
                self.palmId = ""
            }
        }
    }
    
    
    @IBAction func onDestory(_ sender: Any) {
        PalmIDNativeSDK.sharedInstance().releaseEngine()
        print("sdk released")
        self.showDialog(title: "Result", message: "sdk released")
    }
    
    // MARK: - Helper Methods
    
    private func showToast(message: String) {
        DispatchQueue.main.async {
            let toastLabel = UILabel()
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.font = UIFont.systemFont(ofSize: 16.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            
            let toastContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 110))
            toastContainer.backgroundColor = UIColor.clear
            toastContainer.addSubview(toastLabel)
            self.view.addSubview(toastContainer)
            
            toastLabel.frame = CGRect(x: 20, y: toastContainer.frame.size.height - 100, width: toastContainer.frame.size.width - 40, height: 35)
            
            UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        }
    }
    
    private func showDialog(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

