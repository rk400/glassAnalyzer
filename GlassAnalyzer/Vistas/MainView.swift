//
//  MainView.swift
//  GlassAnalyzer
//
//  Created by Ruth Rodriguez on 24/11/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: ViewModel
    @State var seleccion: Int = 0
    @Binding var sesionIniciada: Bool
    var usuario: Usuario
    var body: some View {
        TabView(selection: $seleccion){
            HistorialView().environmentObject(vm)
                .tabItem{
                    Image(systemName: "bookmark")
                    Text("Historial")
                }
                .tag(0)
            FormularioView()
                .tabItem{
                    Image(systemName: "list.bullet.clipboard")
                    Text("Formulario")
                }
                .tag(1)
            PerfilView(sesionIniciada: $sesionIniciada, usuario: usuario.nombre!, correo: usuario.correo!)
                .tabItem{
                    Image(systemName: "person")
                    Text("Historial")
                }
                .tag(2)
        }
    }
}
