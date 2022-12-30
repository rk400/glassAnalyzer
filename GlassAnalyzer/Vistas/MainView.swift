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
    @Binding var usuario: Usuario
    var body: some View {
        TabView(selection: $seleccion){
            HistorialView().environmentObject(vm)
                .tabItem{
                    Image(systemName: "bookmark")
                    Text("Historial")
                }
                .tag(0)
            FormularioView(usuario: $usuario, sesionIniciada: $sesionIniciada)
                .tabItem{
                    Image(systemName: "list.bullet.indent")
                    Text("Formulario")
                }
                .tag(1)
            PerfilView(sesionIniciada: $sesionIniciada, user: usuario, usuario: usuario.nombre!, usuarioNo: usuario.nombre!, correo: usuario.correo!, correoNo: usuario.correo!)
                .tabItem{
                    Image(systemName: "person")
                    Text("Perfil")
                }
                .tag(2)
        }
    }
}
