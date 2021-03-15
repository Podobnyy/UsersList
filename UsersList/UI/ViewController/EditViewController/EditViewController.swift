//
//  EditViewController.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet private weak var ava: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    var user: User!
    var dataSource = [Field]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        if (user.avaData != nil) {
            self.ava.image = UIImage(data: user.avaData!)
        } else{
            self.ava.image = UIImage()
        }
        self.ava.layer.cornerRadius = ava.frame.height / 2
        
        dataSource.append(Field.init(label: "First name", textField: user.firstName))
        dataSource.append(Field.init(label: "Last name", textField: user.lastName))
        dataSource.append(Field.init(label: "Email", textField: user.email))
        dataSource.append(Field.init(label: "Phone", textField: user.phoneNumber))
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func hidekeyboard(){
        self.view .endEditing(true)
    }
    
    @IBAction func saveUserAction(_ sender: UIBarButtonItem) {
        if saveUserToCoreData(){
            self.dismiss(animated: false) {
                if let tabbar = UIApplication.shared.windows.first!.rootViewController as? TabBarController{
                    tabbar.selectedIndex = 1
                }
            }
        }else{
            let alert = UIAlertController(title: "Validation is error", message: "Check first name, last name and email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Save to Core Data
    func saveUserToCoreData() -> Bool{
        if let nameCell = tableView.visibleCells[0] as? EditCell, let name = nameCell.textField.text, name.count >= 1 && name.count <= 30, let lastCell = tableView.visibleCells[1] as? EditCell, let lastname = lastCell.textField.text, lastname.count >= 1 && lastname.count <= 30, let emailCell =  tableView.visibleCells[2] as? EditCell, let email = emailCell.textField.text, validateEmail(email: email){
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "SavedUser", in: context) else { return false }
        
            let userObject = SavedUser(entity: entity, insertInto: context)
            
            userObject.firstName = name.replacingOccurrences(of: " ", with: "")
            userObject.lastName = lastname.replacingOccurrences(of: " ", with: "")
            userObject.email = email
            
            if let phoneCell = tableView.visibleCells[3] as? EditCell{
                userObject.phoneNumber = phoneCell.textField.text
            }
            
            userObject.ava = user.ava
            userObject.avaData = user.avaData
            userObject.id = UUID().uuidString

            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            return true
            
        }else{
            return false
        }
    }
    
    
    func validateEmail(email:String) -> Bool {
        let trimemail = email.trimmingCharacters(in: .whitespaces)
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$")
        if regex.firstMatch(in: trimemail, options: [], range: NSRange(location: 0, length: trimemail.utf16.count)) != nil {
            return true
        }else{
            return false
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EditViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "editCell", for: indexPath)
        cell.selectionStyle = .none

        if let cell = cell as? EditCell {
            cell.setup(field: dataSource[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}


