//
//  ViewController.swift
//  CoreData8Mar
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var currentIndex = 0
    var coreDataObj : CoreDataManager?
    var userData = [DataEntity]()
    var updateBtnCheck : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        coreDataObj = CoreDataManager(entityName : "DataEntity")
        tableViewOutlet.separatorColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButton(_ sender: UIButton) {
    
       let name = nameTextField.text
     let age = ageTextField.text
        let email = emailTextField.text
        coreDataObj?.save(name: name,age: age,email: email)
         toDisplayAlert(messageToDisplay: "Record Saved")
        tableViewOutlet.reloadData()
    }
    
    
    @IBAction func fetchButton(_ sender: UIButton) {
        userData = (coreDataObj?.fetch() as! [DataEntity])
        tableViewOutlet.reloadData()
    }
    
    @IBAction func updateButton(_ sender: UIButton) {
         if updateBtnCheck == true{
            nameTextField.text = ""
            ageTextField.text = ""
            emailTextField.text = ""
        nameTextField.placeholder = "Enter New Name"
        ageTextField.placeholder = "Enter New Age"
        emailTextField.placeholder = "Enter New Email"
            updateBtnCheck = false
        }
        else{
            let name = nameTextField.text
            let age = ageTextField.text
            let email = emailTextField.text
            coreDataObj?.update(name: name,age: age,email: email,user : userData[currentIndex])
            toDisplayAlert(messageToDisplay: "Record Updated")
            tableViewOutlet.reloadData()
        }
        
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        coreDataObj?.delete(user: userData[currentIndex])
        toDisplayAlert(messageToDisplay: "Selected record delete")
       userData.remove(at: currentIndex)
        self.tableViewOutlet.reloadData()
    }
    
    
    func toDisplayAlert(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Success!", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }

}

extension ViewController : UITableViewDataSource,UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
       let user = self.userData[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.init(displayP3Red: 50.0/255.0, green: 120.0/255.0, blue: 244.0/255.0, alpha: 0.4)
            cell.textLabel?.textColor = UIColor.white
        }
        else{
            //cell.textLabel?.textColor = UIColor.init(displayP3Red: 70.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1)
            cell.textLabel?.textColor = UIColor.black
        }
        cell.textLabel?.text = " Name : \(user.name!) \n Age: \(user.age) \n Email id :\(user.email!)"
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    
}
