//
//  AnimalDetailViewController.swift
//  AnimalsContinents
//
//  Created by Bruno on 18/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var extinctionCauses: UIPickerView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var animalNumber: UITextField!
    @IBOutlet weak var animalDescription: UITextView!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    private let manager = CoreDataManager()
    var continent : Int = 0;
    
    var extinctionCausesData = ["Cambio climatico", "Contaminación", "Caza", "Tráfico", "Causas naturales", "Catastrofes naturales"]
    var extinctionCauseValue = "";
    
    var animal : Animales? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extinctionCauses.delegate = self
        extinctionCauses.dataSource = self
        
        if animal != nil {
            self.name.text = animal!.nombre
            self.animalNumber.text = String(animal!.numero)
            self.extinctionCausesData = [animal!.causa!]
            self.foto.image = UIImage(data: animal!.imagen!)!
            self.animalDescription.text = animal!.descripcion
            
            self.name.isEnabled = false;
            self.animalDescription.isEditable = false;
            // self.btnSave.isEnabled = false;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return extinctionCausesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        return extinctionCausesData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent: Int){
        extinctionCauseValue = extinctionCausesData[row]
    }
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        self.animal = Animales();
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func guardarAnimal(_ sender: UIBarButtonItem) {
        // Implementar selector de imagen
        let img = UIImage(named: "animales")?.pngData()!
        
        if animal == nil {
            manager.addAnimal(name: name.text!, photo: img!, continent: Int64(continent), numero: Int64(animalNumber.text!)!, causa: extinctionCauseValue, descripcion: animalDescription.text)
            dismiss(animated: false, completion: nil)
            return
        }
        
        animal?.numero = Int64(animalNumber.text!)!
        manager.updateAnimal(animal: animal!)
        dismiss(animated: false, completion: nil)
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
