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
    var ejecucionCurrent : Ejecucion
    let formatofecha = DateFormatter()
    var body: some View {
        HStack{
            Image("Vajilla")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(color: Color.red, radius: 1)
            VStack(alignment: .leading){
                Text(ejecucionCurrent.nombre ?? "Experimento")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(ejecucionCurrent.estado == "cerrado" ? Color("RojoLetras") : Color("AzulLetras"))
                Text(formatofecha.string(from: ejecucionCurrent.fecha!))
                    .font(.caption2)
                    .fontWeight(.medium)
                Text(ejecucionCurrent.resultado!)
                    .font(.caption2)
                    .fontWeight(.thin)
            }
            //Ejemplo para luego el color de los casos abiertos y cerrados
            Spacer()
            Text(">")
                .opacity(0.8)
        }
        .background(.white)
    }
}

struct HistorialView: View {
    @EnvironmentObject var resultadoVM: ViewModel
    @State var query: String = ""
    @State var soloAbiertos:Bool = false
    var body: some View {
        NavigationView{
            VStack{
                BusquedaView(text: $query)
                List(){
                    Toggle(isOn: $soloAbiertos){
                        Text("Mostrar solo los casos abiertos")
                    }
                    ForEach(resultadoVM.ejecucionArray){ejecucion in
                        if (!soloAbiertos || (ejecucion.estado == "Abierto")) && (ejecucion.nombre!.contains(query) || query.isEmpty ) {
                            NavigationLink(destination: ResultadoView()){
                                VistaEjecucion(ejecucionCurrent: ejecucion)
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
    
}

struct HistorialView_Previews: PreviewProvider {
    static var previews: some View {
        HistorialView()
    }
}
