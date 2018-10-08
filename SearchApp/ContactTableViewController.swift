//
//  ContactTableViewController.swift
//  SearchApp
//
//  Created by Hanif Salafi on 05/10/18.
//  Copyright © 2018 Telkom University. All rights reserved.
//

import UIKit
import Foundation

struct Model {
    let name : String
    let image : String
}

class ContactTableViewController: UITableViewController {
    
   
    @IBOutlet weak var Navbar: UINavigationItem!
    
    
    var models = [Model]()
    var filteredModel = [Model]()
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        models = [
            Model(name:"Hulk", image:"user1"),
            Model(name:"Batman", image:"user2"),
            Model(name:"Superman", image:"user3"),
            Model(name:"Captain America", image:"user1"),
            Model(name:"Iron man", image:"user2"),
            Model(name:"Wonder Woman", image:"user3"),
            Model(name:"Aquaman", image:"user1"),
            Model(name:"Batman", image:"user2"),
            Model(name:"Superman", image:"user3"),
            Model(name:"Captain America", image:"user1"),
            Model(name:"Iron man", image:"user2"),
            Model(name:"Wonder Woman", image:"user3")
        ]
        
        tableView.dataSource = self
        
        searchController = UISearchController(searchResultsController: nil)
        
        setupSearchController()
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        
        let model: Model
        if searchController.isActive && searchController.searchBar.text != "" {
            model = filteredModel[indexPath.row]
        } else {
            model = models[indexPath.row]
        }
        
//        if filteredModel.count == 0 {
//            cell.lineSeparator.isHidden = true
//        }
        
//        cell.textLabel?.text = model.name
//        cell.imageView?.image = UIImage(named: model.image)
        
        cell.lblName.text = model.name
        cell.imgProfile.image = UIImage(named: model.image)
        cell.btnAdd.layer.borderColor = UIColor.sea.cgColor
        cell.lineSeparator.backgroundColor = UIColor.seaBreeze
        cell.imgProfile.layer.borderColor = UIColor.seaBreeze.cgColor
    
        cell.btnAdd.tag = indexPath.row

        let tapAction = UITapGestureRecognizer(target: self, action: #selector(addFriend(gesture:)))
        cell.btnAdd.addGestureRecognizer(tapAction)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    @objc func addFriend(gesture: UITapGestureRecognizer) {
        if let index = gesture.view?.tag {
            print(index)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredModel.count
        }
        return models.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func setupSearchController(){
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 255.0 / 255.0, alpha: 1.0)
        searchController.searchBar.placeholder = "Cari nama teman kamu"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor(red: 56.0 / 255.0, green: 58.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
        searchController.searchBar.setValue("Batal", forKey: "_cancelButtonText")
        if let txfSearchField = searchController.searchBar.value(forKey: "_searchField") as? UITextField {
            txfSearchField.backgroundColor =  UIColor(white: 241.0 / 255.0, alpha: 1.0)
        }
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredModel = models.filter({( model : Model) -> Bool in
            return model.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
}

extension ContactTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
        
    }
}
