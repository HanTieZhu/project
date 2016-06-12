//
//  UserInfoViewController.swift
//  Salik
//
//  Created by ME on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class UserInfoViewController: BaseViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var commonTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carTypeLabel: UILabel!
    

    var currentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.initView()
    }
    
    override func viewWillAppear(animated: Bool) {
        updateLocation()
    }
    
    func initView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserInfoViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        phoneTextField.keyboardType = UIKeyboardType.DecimalPad
    }
    
    func initUI(){
        carImageView.image = UIImage(named: appData.car_info[appData.selected_car_index]["car_image"]!)
        carTypeLabel.text = appData.car_info[appData.selected_car_index]["car_type"]
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)

    }

    func updateLocation(){
        locationTextField.text = appData.user_location
        locationTextField.userInteractionEnabled = false
    }
    
    func getUserInfo() -> Void {
//        appData.user_location = locationTextField.text
        appData.user_phone_number = phoneTextField.text
        appData.user_comment = commonTextField.text
    }
    
    func goNextView() -> Void {
        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("OrderViewController") as! OrderViewController
        
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    //MARK: Custom Action
    
    @IBAction func onNext(sender: UIButton) {
        if locationTextField.text!.isEmpty {
            let alertController = appController.showAlert("Warning!", message: "Please enter your location.")
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        } else if phoneTextField.text!.isEmpty{
            let alertController = appController.showAlert("Warning!", message: "Please enter your phone number.")
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }else {
            getUserInfo()
            goNextView()
        }
    }
    
    
       
}
