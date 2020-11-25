//
//  ContinentTableViewController.swift
//  AnimalsContinents
//
//  Created by Bruno on 14/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class ContinentTableViewController: UITableViewController {

    private let manager = CoreDataManager()
    private var continents = [Continentes]()
    private var continentSelected : Int64 = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        
        manager.initContinents()
        
        continents = manager.getContinents()
    }

    // MARK: - Table view data source

    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.continents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContinentTableViewCell", for: indexPath) as! ContinentTableViewCell;
        
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.cornerRadius = 2
        cell.layer.borderColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1).cgColor
        cell.tintColor = cell.backgroundColor

        cell.nombre.text = continents[indexPath.row].nombre
        cell.nombre.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.clima.text = continents[indexPath.row].clima
        cell.clima.textColor = UIColor.lightGray
        
        cell.ext.text = String(continents[indexPath.row].superficie)
        cell.ext.textColor = UIColor.lightGray
        
        cell.continentImage.image = UIImage(named: continents[indexPath.row].foto!)
        
        return cell;
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnimalsTableViewController {
            let controller = segue.destination as? AnimalsTableViewController
            
            controller?.continent = self.tableView.indexPathForSelectedRow?.row ?? 0
        }
    }
}
