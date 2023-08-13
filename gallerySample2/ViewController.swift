//
//  ViewController.swift
//  gallerySample2
//
//  Created by 82205 on 2023/08/06.
//

import UIKit

protocol SendDataProtocol {
    func receiveData(data:Feed)
}

class ViewController: UIViewController, SendDataProtocol {
    func receiveData(data: Feed) {
        self.feeds.append(data)
    }

    var feed = Feed()
    var feeds = [Feed](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.feeds) {
                UserDefaults.standard.setValue(encoded, forKey: "feeds")
            }
            
            self.tableView.reloadData()
        }
    }
    var picker = UIImagePickerController()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let decoder: JSONDecoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: "feeds") as? Data,
           let feeds = try? decoder.decode([Feed].self, from: data) {
            self.feeds = feeds
            tableView.reloadData()
        }
    }

    @IBAction func addBtn(_ sender: Any) {
        let alert = UIAlertController(title: "alertTitle", message: "alertMessage", preferredStyle: UIAlertController.Style.alert)
        let cameraAction = UIAlertAction(title: "카메라", style: .default){_ in
            self.openCamera()
        }
        let albumAction = UIAlertAction(title: "앨범", style: .default){_ in
            self.openLibrary()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
        
    }
    
    func openLibrary(){
      picker.sourceType = .photoLibrary
      present(picker, animated: true, completion: nil)
    }

    func openCamera(){
      picker.sourceType = .camera
      present(picker, animated: true, completion: nil)
    }
    
    @IBAction func removeBtn(_ sender: Any) {
        self.feeds = []
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        self.feed.photo = image.pngData()
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen // fullscreen으로 해야 viewWillAppear 을 호출함
        vc.feed = self.feed
        self.navigationController?.pushViewController(vc, animated: true)
        self.dismiss(animated: false){
            self.present(vc, animated: false)
        }
    }
}



extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let celldata = self.feeds[indexPath.row]
        
        cell.titleLabel.text = celldata.title
        cell.contentsLabel.text = celldata.contents
        guard let pd = celldata.photo else {return cell}
        cell.photoImageView.image =  UIImage(data: pd)
        
        return cell
    }
    
    
    
}
