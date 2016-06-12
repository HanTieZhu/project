//
//  OrderViewController.swift
//  Salik
//
//  Created by ME on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit


class OrderViewController: BaseViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var carInfoLabel: UILabel!
    
    var result: NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.initView()
    }
    func initData(){
        result = NSMutableDictionary()
    }
    func initView(){
        locationLabel.text = appData.user_location
        phoneNumberLabel.text = appData.user_phone_number
        carInfoLabel.text = appData.car_info[appData.selected_car_index]["car_type"]
    }
    
    func initAppData(){
        appData.selected_car_index = -1
        appData.user_location = ""
        appData.user_comment = ""
        appData.user_phone_number = ""
    }
    
    func goHome() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[0], animated: true);
    }
    
    //MARK: Custom Action
    @IBAction func onBackHome(sender: UIButton) {
        initAppData()
        goHome()
    }
    
    @IBAction func onCall(sender: UIButton) {
        let window = UIApplication.sharedApplication().keyWindow!
        self.appController.showActivityIndicator(window)

        let params: NSMutableDictionary = NSMutableDictionary()
        params.setValue(appController.getUserDefault(USER_ID), forKey: USER_ID)
        params.setValue(appData.selected_car_index+1, forKey: CAR_TYPE)
        params.setValue(appData.user_location, forKey: ORDER_LOCATION)
        params.setValue(appData.user_comment, forKey: ORDER_COMMENT)
        params.setValue(appData.user_phone_number, forKey: ORDER_PHONE_NUMBER)
        
        appController.httpRequest(API_ORDER, params: params, completion: {result in
//            print("result \(result)")
            
            dispatch_async(dispatch_get_main_queue(), {
                self.appController.hideActivityIndicator(window)

            })
            
            let status: Int = result.objectForKey(STATUS) as!  Int
            if status == 1 {
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = self.appController.showAlert("Congratulation!", message: "Your order was accepted!")
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return
                })

            }
            }, errors:{
                dispatch_async(dispatch_get_main_queue(), {
                    self.appController.hideActivityIndicator(window)
                    
                })
                dispatch_async(dispatch_get_main_queue(), {
                    let alertController = self.appController.showAlert("Error!", message: "Check your Internet connection!")
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return
                })
        })
    }
    
}
