//
//  CoreDataManager.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import CoreData

class CoreDataManager{
    static let instance = CoreDataManager() //singleton
    let contenedor: NSPersistentContainer
    let contexto: NSManagedObjectContext
    init(){
        contenedor = NSPersistentContainer(name: "GlassAnalyzerData")
        contenedor.loadPersistentStores{ (descripcion, error) in
            if let error = error {
                print("Error al cargar datos de CoreData: \(error)")
            }else{
                print("Carga de datos correcta")
            }
        }
        contexto = contenedor.viewContext
    }
    
    func save(){
        do{
            try contexto.save()
            print("Datos almacenados correctamente")
        }catch let error{
            print("Error al guardar datos \(error)")
        }
    }
}
