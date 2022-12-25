//
//  ViewModel.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    let gestorCoreData = CoreDataManager.instance //singleton
    
    @Published var usuarioArray: [Usuario] = []
    @Published var ejecucionArray: [Ejecucion] = []
    
    init(){
        cargarDatos()
        
    }
    
    func cargarDatos(){
        usuarioArray.removeAll()
        ejecucionArray.removeAll()
        let fetchUsuario = NSFetchRequest<Usuario>(entityName: "Usuario")
        let fetchEjecucion = NSFetchRequest<Ejecucion>(entityName: "Ejecucion")
        do{
            self.usuarioArray = try gestorCoreData.contexto.fetch(fetchUsuario)
            self.ejecucionArray = try gestorCoreData.contexto.fetch(fetchEjecucion).sorted(){$0.fecha! > $1.fecha!}
        }catch let error{
            print("Error al cargar los datos: \(error)") }
    }
    
    func guardarDatos(){
        gestorCoreData.save()
        cargarDatos()
    }
    
    func addUsuario(nombre: String, correo: String, password: String){
        let nuevoUsuario = Usuario(context: gestorCoreData.contexto)
        nuevoUsuario.nombre = nombre
        nuevoUsuario.correo = correo
        nuevoUsuario.password = password
        guardarDatos()
        
    }
    
    func deleteUsuario(indexSet: IndexSet) {
        for index in indexSet {
            gestorCoreData.contexto.delete(usuarioArray[index])
        }
    }
    
    func addEjecucion(usuario: Usuario, nombre: String, fecha : Date, descripcion: String, resultado: String, estado: String, al: Double, ba: Double, ca: Double, k : Double, mg : Double, ri: Double) {
        let nuevaEjecucion = Ejecucion(context: gestorCoreData.contexto)
        nuevaEjecucion.nombre = nombre
        nuevaEjecucion.fecha = fecha
        nuevaEjecucion.descripcion = descripcion
        nuevaEjecucion.resultado = resultado
        nuevaEjecucion.estado = estado
        nuevaEjecucion.al = al
        nuevaEjecucion.ba = ba
        nuevaEjecucion.ca = ca
        nuevaEjecucion.k = k
        nuevaEjecucion.mg = mg
        nuevaEjecucion.ri = ri
        nuevaEjecucion.ejecucionusuario = usuario
        guardarDatos()
    }
    
    func deleteEjecucion(ejecucion: Ejecucion){
        gestorCoreData.contexto.delete(ejecucion)
        guardarDatos()
    }
}

