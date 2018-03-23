//
//  ViewController.swift
//  Patrick_ScreenShoot_Tableview
//
//  Created by Pratik on 3/23/18.
//  Copyright © 2018 Pratik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var dataSource = ["Pratik Panchal","Patrick","David ","Virat Kohli","Dhoni","Raina","Yuvraj","Rohit"]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Burttom Action Save Tableview Image Locally
    @IBAction func downloadButtonAction(_ sender: Any) {
    
        // Store TableView Image Locally
        saveImageToLibrary()
    }
    
}

//MARK:- Tableview DataSource & Delegate
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTableView", for: indexPath) as? cellTableView else{
            return UITableViewCell()
        }
        
        
        
        cell.lblName.text = dataSource[indexPath.row]
        cell.lblNumber.text = ""
        cell.lblBalance.text = ""
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}

//MARK:- Tableview Cell
class cellTableView : UITableViewCell{
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

}

//MARK:- Image Save in Libraray
extension ViewController{
    
    
    func saveImageToLibrary(){
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: tableview.contentSize.width, height: tableview.contentSize.height),false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let previousFrame = tableview.frame
        
        tableview.frame = CGRect(x:tableview.frame.origin.x, y:tableview.frame.origin.y, width:tableview.contentSize.width, height:tableview.contentSize.height);
        
        tableview.layer.render(in: context!)
        
        tableview.frame = previousFrame
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Alert", message: "Your_receipt_has_been_saved_to_your_photos", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
}
