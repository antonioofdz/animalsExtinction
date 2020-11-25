//
//  CoreDataManager.swift
//  AnimalsContinents
//
//  Created by Bruno on 14/11/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    private let container : NSPersistentContainer!
    
    init(){
        container = NSPersistentContainer(name: "AnimalsContinents")
        setupDatabase()
    }
    
    private func setupDatabase() {
        container.loadPersistentStores {(desc, error) in
            if let error = error {
                print("Error loading store \(desc) - \(error)")
                return
            }
            print("Database ready")
        }
    }
    
    func initContinents() {
        if self.getContinents().count == 0 {
            self.addContinent(id: 1, name: "África1", photo: "africa", clime: "Mayormente cálido", ext: 52000000)
            self.addContinent(id: 2, name: "Europa", photo: "europa", clime: "Mayormente cálido", ext: 52000000)
            self.addContinent(id: 3, name: "Oceania", photo: "oceania", clime: "Mayormente cálido", ext: 52000000)
            self.addContinent(id: 4, name: "America", photo: "america", clime: "Mayormente cálido", ext: 52000000)
            self.addContinent(id: 5, name: "Asia", photo: "asia", clime: "Mayormente cálido", ext: 52000000)
        }
    }
    
    func addContinent(id: Int64, name: String, photo: String, clime: String, ext: Int64) {
        let ctx = container.viewContext
        
        let continent = Continentes(context: ctx)
        continent.id = id
        continent.nombre = name
        continent.foto = photo
        continent.clima = clime
        continent.superficie = ext
        
        do {
            try ctx.save()
            print("Continente \(name) creado correctamente")
        } catch {
            print("Error guardando continente - \(error)")
        }
    }
    
    func getContinents() -> [Continentes] {
        let req : NSFetchRequest<Continentes> = Continentes.fetchRequest()
        do {
            let result = try container.viewContext.fetch(req)
            return result
        } catch {
            print("Error al obtener continentes \(error)")
        }
        return []
    }
    
    func getContinent(id: Int64) -> Continentes? {
        let req : NSFetchRequest<Continentes> = Continentes.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id as NSNumber)
        do {
            let result = try container.viewContext.fetch(req).first
            return result!
        } catch {
            print("Error al obtener continentes \(error)")
        }
        return nil
    }
    
    func initAnimals() {
        if self.getAnimals(continent: 1).count == 0 {
            self.addAnimal(name: "Lemur cola anillada", photo: UIImage(named: "lemur")!.pngData()!, continent: 1, numero: 3000, causa: "Factor humano",descripcion: "En peligro de extinción debido a la agricultura de tala y quema, a la tala ilegal, la producción de carbón y la minería, pero lo más alarmante es que recientemente se ha reportado que la caza y la captura en vivo se ha vuelto la amenaza más seria.")
        }
    }
    
    func addAnimal(name : String, photo: Data, continent: Int64, numero: Int64, causa: String, descripcion: String) {
        let ctx = container.viewContext
        
        let animal = Animales(context: ctx)
        animal.nombre = name
        animal.imagen = photo
        animal.numero = numero
        animal.causa = causa
        animal.descripcion = descripcion
        animal.id = Int64.random(in: 1..<Int64.max)
        animal.addToContinentes(getContinent(id: continent)!)
        
        do {
            try ctx.save()
            print("Animal \(name) creado correctamente")
        } catch {
            print("Error guardando animal - \(error)")
        }
    }
    
    func getAnimals(continent : Int64) -> [Animales] {
        let req : NSFetchRequest<Continentes> = Continentes.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", continent as NSNumber)
        
        do {
            let result = try container.viewContext.fetch(req).first
            if let animals = result?.animales, animals.count != 0 {
                let arr = animals.allObjects as NSArray
                return arr as! [Animales]
            }
            return []
        } catch {
            print("Error al obtener animales \(error)")
        }
        return []
    }
    
    func deleteAnimal(animal: Animales){
        container.viewContext.delete(animal as NSManagedObject)
        do {
            try container.viewContext.save()
        } catch {
            print("Error al borrar animal \(error)")
        }
    }
    
    func updateAnimal(animal: Animales) {
        let req : NSFetchRequest<Animales> = Animales.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", animal.id as NSNumber)
        let ctx = container.viewContext
        do {
            let results = try ctx.fetch(req)
            if let a = results.first {
                a.numero = animal.numero
            }
            try ctx.save()
        } catch {
            print("Error al actualizar animal \(error)")
        }
    }
    
    func clearData() {
        let delContinentsReq = NSBatchDeleteRequest(fetchRequest: Continentes.fetchRequest())
        let delAnimalsReq = NSBatchDeleteRequest(fetchRequest: Continentes.fetchRequest())
        do {
            try container.viewContext.execute(delContinentsReq);
            try container.viewContext.execute(delAnimalsReq);
        } catch {
            print("Error al borrar data \(error)")
        }
    }
}
