//
//  DetailVC.swift
//  gallerySample2
//
//  Created by 82205 on 2023/08/06.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextField: UITextField!
    
    
    var testStr = ""
    var feed = Feed()
    var delegate:SendDataProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pd = feed.photo else {return}
        photoImageView.image = UIImage(data: pd)
        print(testStr)
        
    }
    

    @IBAction func addBtn(_ sender: Any) {
        
        self.feed.title = titleTextField.text
        self.feed.contents = contentsTextField.text
        delegate?.receiveData(data: self.feed)
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
