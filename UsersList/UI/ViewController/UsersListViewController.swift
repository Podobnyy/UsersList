//
//  UsersListViewController.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import UIKit

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [User]()
    private var currentPage = 1
    var isLoadingList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        Networking.shared.getUsers(list: 1, usersCount: 20) { [weak self](users) in
            if let users = users{
                self?.dataSource = users
                self?.isLoadingList = false
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func loadMoreItemsForList(){
        Networking.shared.getUsers(list: currentPage+1, usersCount: 10) { [weak self](users) in
            if let users = users{
                self?.dataSource += users
                self?.isLoadingList = false
                self?.currentPage += 1
                DispatchQueue.main.async {
                   self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource{
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
                self.isLoadingList = true
                self.loadMoreItemsForList()
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
