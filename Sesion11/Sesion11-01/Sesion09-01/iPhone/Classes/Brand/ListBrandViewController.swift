//
//  ListBrandViewController.swift
//  Sesion09-01
//
//  Created by Kenyi Rodriguez on 6/6/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ListBrandViewController: UIViewController {

    @IBOutlet weak var tlbBrand: UITableView!
    
    var arrayBrand = [Brand]()
    var lastSearchText = ""
    
    func createDeleteOption(indexPath: IndexPath) -> UIContextualAction {
        
        let option = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            
            let objDM = self.arrayBrand[indexPath.row]
            self.arrayBrand.remove(at: indexPath.row)
            BrandBL.delete(objDM)
            self.tlbBrand.deleteRows(at: [indexPath], with: .automatic)
            
        }
        return option
    }
    
    func createWebOption(indexPath: IndexPath) -> UIContextualAction {
        
        let option = UIContextualAction(style: .normal, title: "Ver sitio web") { (_, _, _) in
            let objDM = self.arrayBrand[indexPath.row]
            
            if let url = URL(string: objDM.brand_web ?? ""), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                print("NO SE PUEDE ABRIR EL LINK")
            }
        }
        return option
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.arrayBrand = BrandBL.listAll()
        self.tlbBrand.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? BrandDetailViewController {
            controller.objBrand = sender as? Brand
        }
    }
}

extension ListBrandViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayBrand.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BrandTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BrandTableViewCell
        cell.objBrand = self.arrayBrand[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let objDM = self.arrayBrand[indexPath.row]
        self.performSegue(withIdentifier: "BrandDetailViewController", sender: objDM)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = self.createDeleteOption(indexPath: indexPath)
        let web = self.createWebOption(indexPath: indexPath)
        
        let configuration = UISwipeActionsConfiguration(actions: [delete, web])
        return configuration
    }
}

extension ListBrandViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     
        var arrayResult = [Brand]()
        if searchText.count == 0 {
            arrayResult = BrandBL.listAll()
        }else{
            arrayResult = BrandBL.listAllBySearchKey(searchKey: searchText)
        }
    
        let sectionToReload = IndexSet(integer: 0)
    
        if self.arrayBrand.count == arrayResult.count {
            self.arrayBrand = arrayResult
            self.tlbBrand.reloadSections(sectionToReload, with: .none)
            
        }else{
            
            self.arrayBrand = arrayResult
            
            if self.lastSearchText.count < searchText.count {
                self.tlbBrand.reloadSections(sectionToReload, with: .left)
            }else{
                self.tlbBrand.reloadSections(sectionToReload, with: .right)
            }
        }
  
        self.lastSearchText = searchText
    }
}
