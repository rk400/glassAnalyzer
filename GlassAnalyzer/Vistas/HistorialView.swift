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
            //    .opacity(0.8)
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
    var body: some View {
        NavigationView{
            VStack{
                BusquedaView(text: $query)
                List(){
                    Toggle(isOn: $soloAbiertos){
                        Text("Mostrar solo los casos abiertos")
                    }
                    if let ejecucionesActuales = usuario.usuarioejecucion?.allObjects as? [Ejecucion]{
                        ForEach(ejecucionesActuales){ejecucion in
                            if (!soloAbiertos || (ejecucion.estado == "ABIERTO")) && (ejecucion.nombre!.contains(query) || query.isEmpty ) {
                                NavigationLink(destination: ResultadoView()){
                                    VistaEjecucion(ejecucionCurrent: ejecucion)
                                }
                            }
                        }
                    }
                    //.onDelete { indexSet in
                    //amigoVM.datos.remove(atOffsets: indexSet)
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
    func buscarEjecucion() -> Void {
        
        for ejecucion in vm.ejecucionArray{
            if ejecucion.ejecucionusuario == usuario{
                ejecucionesActuales[contador] = ejecucion
                contador+=1
            }
        }
        contador = 0
    }
}
