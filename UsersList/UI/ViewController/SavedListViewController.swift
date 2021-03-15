//
//  SavedListViewController.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import UIKit
import CoreData

class SavedListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Saved"
        getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataSource.removeAll()
        getUsers()
    }
    
// MARK: - CoreData
    // Get user by CoreData
    func getUsers(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedUser> = SavedUser.fetchRequest()

        var savedUsers = [SavedUser]()
        do {
            savedUsers = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        for savedUser in savedUsers {
            let user: User = User.init(firstName: savedUser.firstName! , lastName: savedUser.lastName!, ava: savedUser.ava!, avaData: savedUser.avaData!, email: savedUser.email!, phoneNumber: savedUser.phoneNumber!, userID: savedUser.id ?? "")
            
            self.dataSource.append(user)
        }
        self.tableView.reloadData()
    }
}
// Remove user from CoreData
func removeUserFromCoreData(userID: String){
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<SavedUser> = SavedUser.fetchRequest()
    
    if let result = try? context.fetch(fetchRequest) {
        for object in result {
            if let id = object.id{
                if id == userID{
                    context.delete(object)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SavedListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none

        if let cell = cell as? UserCell {
            cell.setup(user: dataSource[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeUserFromCoreData(userID: dataSource[indexPath.row].userID)
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openEditVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openEditVC" {
            if let destinationVC = segue.destination as? EditViewController {
                destinationVC.user = self.dataSource[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}
