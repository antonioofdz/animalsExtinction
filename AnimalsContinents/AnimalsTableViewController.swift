//
//  AnimalsTableViewController.swift
//  AnimalsContinents
//
//  Created by Bruno on 16/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class AnimalsTableViewController: UITableViewController {
    
    private let manager = CoreDataManager()
    private var animals = [Animales]()
    var continent:Int = 0;
    var isDetailViewAnimal : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        
        manager.initAnimals()
        
        continent = continent + 1
        animals = manager.getAnimals(continent: Int64(continent))
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    /*@IBAction func cancelar(_ sender: UIBarButtonItem) {
        print("CANCELAR")
        // dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: false);
    }*/
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalsTableViewCell", for: indexPath) as! AnimalsTableViewCell;
        
        cell.layer.borderWidth = 2
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.cornerRadius = 2
        cell.layer.borderColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1).cgColor
        cell.tintColor = cell.backgroundColor
        
        cell.nombre.text = animals[indexPath.row].nombre
        cell.nombre.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.foto.image = UIImage(data: animals[indexPath.row].imagen!)
        cell.foto.layer.backgroundColor = cell.backgroundColor?.cgColor
        
        cell.numero.text = String(animals[indexPath.row].numero)
        cell.numero.textColor = UIColor.lightGray
        
        cell.causa.text = animals[indexPath.row].causa
        cell.causa.textColor = UIColor.lightGray
        
        return cell;
    }

    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {return}
        
        manager.deleteAnimal(animal: animals[indexPath.row])
        animals = manager.getAnimals(continent: Int64(continent) + 1)
        tableView.reloadData()
    }

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AnimalDetailViewController {
            let controller = segue.destination as? AnimalDetailViewController
            controller?.continent = self.continent
            
            if segue.identifier == "viewDetail" {
                let row = tableView.indexPath(for: sender as! AnimalsTableViewCell)?.row
                
                controller?.animal = animals[row!]
            }
        }
    }
}

