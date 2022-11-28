//
//  CoreDataManager.swift
//  CRUDExamenMobiliario
//
//  Created by Roberto Marco García Hernández on 24/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "CRUDExamenMobiliario")
        persistentContainer.loadPersistentStores(completionHandler: {
            (descripcion, error) in
            if let error = error{
                fatalError("Core data failed to initialize \(error.localizedDescription)")
            }
        })
    }
    
    func guardarMobiliario(id: Int, nombre: String, precio_unitario: Float, existencia: Int, categoria: String){
        let mobiliario = Mobiliario(context: persistentContainer.viewContext)
        mobiliario.id = Int64(id)
        mobiliario.nombre = nombre
        mobiliario.precioUnitario = precio_unitario
        mobiliario.existencia = Int64(existencia)
        mobiliario.categoria = categoria
        
        do{
            try persistentContainer.viewContext.save()
            print("Producto guardado")
        }catch{
            print("Failed to save error in \(error)")
        }
    }
    
    func obtenerMobiliario() -> [Mobiliario]{
        let fetchRequest : NSFetchRequest<Mobiliario> = Mobiliario.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func borrarMobiliario(mobiliario: Mobiliario){
        persistentContainer.viewContext.delete(mobiliario)
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    func actualizarMobiliario(mobiliario: Mobiliario){
        let fetchRequest : NSFetchRequest<Mobiliario> = Mobiliario.fetchRequest()
        let predicate = NSPredicate(format: "id = %i", mobiliario.id)
        fetchRequest.predicate = predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let m = datos.first
            m?.nombre = mobiliario.nombre
            m?.categoria = mobiliario.categoria
            m?.existencia = mobiliario.existencia
            m?.categoria = mobiliario.categoria
            try persistentContainer.viewContext.save()
            print("Producto actualizado")
        }catch{
            print("Failed error: \(error)")
        }
    }
    
}
