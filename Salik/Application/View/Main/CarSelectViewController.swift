//
//  CarSelectViewController.swift
//  Salik
//
//  Created by ME on 6/7/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class CarSelectViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posX: Int!
    var isSelectedCar: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }
    
    func initUI(){
        self.collectionView.backgroundColor = UIColor.whiteColor()
    }
    
    func goNextView() -> Void {
        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("UserInfoViewController") as! UserInfoViewController
        
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    //MARK: Custom Action
    @IBAction func onNext(sender: UIButton) {
        if appData.selected_car_index == -1 {
            let alertController = appController.showAlert("Warning!", message: "Please select your ride.")
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        } else{
            goNextView()
        }
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var cellSize: CGSize!
        
        let kCellForRow: CGFloat = 2
        let kCellForLine: CGFloat = 2
        
        let width: CGFloat = (collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right - 10)/kCellForRow
        let height: CGFloat = (collectionView.frame.size.height - collectionView.contentInset.top - collectionView.contentInset.bottom - 10)/kCellForLine
        cellSize = CGSizeMake(width, height)
        
        return cellSize // The size of one cell
    }
    
    // #MARK: - CollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var num: Int!
        
        num = appData.car_info.count;
        
        return num
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: CarCollectionViewCell!
        cell = collectionView.dequeueReusableCellWithReuseIdentifier("carCollectionViewCell", forIndexPath: indexPath) as! CarCollectionViewCell
        cell.car_image.image = UIImage(named: appData.car_info[indexPath.row]["car_image"]!)
        cell.car_name.text = appData.car_info[indexPath.row]["car_type"]

        if indexPath.row == appData.selected_car_index {
            cell.setBoarder()
        } else{
            cell.resetBorder()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        // Select operation
        appData.selected_car_index = indexPath.row
        self.collectionView.reloadData()
        
//        print("AppData:", appData.car_info)
        
    }
    
}
