//
//  HistorialView.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import Foundation
import SwiftUI

struct BusquedaView: View {
    @Binding var text: String
    var body: some View {
        
        HStack{
            TextField("Buscar...", text: $text)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .padding()
                .frame(width: 250, height: 30, alignment: .center)
                .background(.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius:25))
            HStack{
                Image(systemName: "magnifyingglass.circle")
                    .opacity(text.isEmpty ? 0.3 : 0.5)
                    .foregroundColor(Color.gray).imageScale(Image.Scale.large).frame(width: 50)
                    .frame(height: 40)
            }
        }
    }
}

struct VistaEjecucion: View {
    @State var ejecucionCurrent : Ejecucion
    var body: some View {
        HStack{
            Image(ejecucionCurrent.resultado ?? "logo")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(color: Color.red, radius: 1)
            VStack(alignment: .leading){
                Text(ejecucionCurrent.nombre ?? "caso")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(ejecucionCurrent.estado == "CERRADO" ? Color("RojoLetras") : Color("AzulLetras"))
                Text(ejecucionCurrent.fecha!, style: .date)
                    .font(.caption2)
                    .fontWeight(.medium)
                Text(ejecucionCurrent.resultado!)
                    .font(.caption2)
                    .fontWeight(.thin)
            }
            //Ejemplo para luego el color de los casos abiertos y cerrados
            Spacer()
            //Text(">")
            //.opacity(0.8)
        }
        .background(.white)
    }
}

struct HistorialView: View {
    @EnvironmentObject var vm: ViewModel
    @State var query: String = ""
    @State var soloAbiertos:Bool = false
    @State var ejecucionesActuales = [Ejecucion]()
    @State var contador: Int = 0
    @State var usuario: Usuario
    @Binding var sesionIniciada: Bool
    @State var showResult: Bool = false
    var body: some View {
        NavigationView{
            VStack{
                BusquedaView(text: $query)
                List(){
                    Toggle(isOn: $soloAbiertos){
                        Text("Mostrar solo los casos abiertos")
                    }
                    if var ejecucionesActuales = usuario.usuarioejecucion?.allObjects as? [Ejecucion]{
                        ForEach(ejecucionesActuales.sorted(){$0.fecha! > $1.fecha!}, id:\.self){ejecucion in
                            if (!soloAbiertos || (ejecucion.estado == "ABIERTO")) && (ejecucion.nombre!.contains(query) || query.isEmpty ) {
                                NavigationLink(destination: ResultadoView(nombreCaso: ejecucion.nombre!, RI: ejecucion.ri , Mg: ejecucion.mg, Al: ejecucion.al, K: ejecucion.k, Ca: ejecucion.ca, Ba: ejecucion.ba, estadoCaso: ejecucion.estado!, resultado: ejecucion.resultado!, descripcion: ejecucion.descripcion ?? "", usuario: $usuario ,sesionIniciada: $sesionIniciada, esNuevo: false, ejecucion: ejecucion, showResult: $showResult).environmentObject(vm)){
                                    VistaEjecucion(ejecucionCurrent: ejecucion)
                                    Image(systemName: "minus.circle")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                        .onTapGesture{
                                            vm.deleteEjecucion(ejecucion: ejecucion)
                                        }
                                    
                                }
                                   
                                
                            }
                      
                        }
                            
                        
                          
                        
                        
                         
                     
                        
                        
                    }
                    
                }
                            //.onMove(perform: move)
            }
            .navigationTitle("Historial")
//                .navigationBarItems(
//                    leading:
//                        Image("logoHeader"))
            
            //.environment(\.editMode, .constant(enEdicion ? EditMode.active : EditMode.inactive))
        }
       
            
    }
}

