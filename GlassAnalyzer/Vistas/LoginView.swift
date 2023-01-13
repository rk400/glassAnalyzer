//
//  LoginView.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI

struct LoginView: View {
    @State var nombreUsuario: String = ""
    @State var passUsuario: String = ""
    @State var mensajeLogin: String = ""
    @StateObject private var vm: ViewModel = ViewModel()
    @State var sesionIniciada: Bool = false
    @State var irRegistro: Bool = false
    @State var usuarioSesion: Usuario = Usuario()
    
    
    var body: some View {
        VStack{
            HStack{
            Image("logoMain")
                    .resizable()
                    .frame(width: 250, height: 250)
                    //.offset(y: -80)
            }
            }
            Spacer().frame(height: 30)
            VStack{
                VStack{
                    Spacer().frame(height: 60)
                    HStack{
                        Text("Usuario:").foregroundColor(.black).padding()
                        Spacer().frame(width: 35)
                        TextField("Usuario...",text: $nombreUsuario)
                            .autocapitalization(UITextAutocapitalizationType.none)
                            .padding(.leading,10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .frame(width: 165)
                        
                    }.frame(width: 300, alignment: .center)
                       
                    HStack{
                        Text("Contraseña:").foregroundColor(.black).padding()
                        Spacer().frame(width: 5)
                        SecureField("Contraseña...",text: $passUsuario)
                            .autocapitalization(UITextAutocapitalizationType.none)
                            .padding(.leading,10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .frame(width: 165)
                    }.frame(width: 300, alignment: .center)
                }.frame(width: 800, alignment: .center)
                
                Text(mensajeLogin)
                    .font(.custom("Inter", size: 12))
                    .frame(height: 10)
                    .offset(y: -10)
                  
                Spacer().frame(height: 50)
                    Button("Iniciar Sesión"){
                        vm.cargarDatos()
                        if(comprobarSesion(usuarioaux: nombreUsuario, passaux: passUsuario)){
                            sesionIniciada.toggle()
                            nombreUsuario = ""
                            passUsuario = ""
                        }else{
                            mensajeLogin = "*Nombre de usuario o contraseña incorrectos"
                        }
                            
                        
                    }.fullScreenCover(isPresented: $sesionIniciada) {
                        MainView(sesionIniciada: $sesionIniciada, usuario: $usuarioSesion).environmentObject(vm)
                    }
                    .font(.custom("Inter", size: 14))
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: 120, height: 50, alignment: .center)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(20)
                               
               
                    
                Spacer().frame(height: 30)
                
                
                Text("Regístrese en la aplicación")
                    .font(.custom("Inter", size: 16))
                
                Button("Registrarse"){
                    irRegistro.toggle()
                    nombreUsuario = ""
                    passUsuario = ""
                }.fullScreenCover(isPresented: $irRegistro) {
                    RegistroView(irRegistro: $irRegistro).environmentObject(vm)
                }
                .font(.custom("Inter", size: 14))
                .fixedSize(horizontal: true, vertical: true)
                .frame(width: 120, height: 50, alignment: .center)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(20)
                
                
            
                Spacer().frame(height: 50)
                
                
                
            }.background(Color("ColorMoradoApp"))
                .frame(width: 350, height: 400, alignment: .center)
                .cornerRadius(30)
                .offset(y: -30)
                .onAppear(){
                    vm.cargarDatos()
                }
     
        
    }
    func comprobarSesion(usuarioaux: String, passaux: String) -> Bool {
        for usuario in vm.usuarioArray{
            if(usuario.nombre == usuarioaux && usuario.password == passaux){
                usuarioSesion = usuario
                return true
            }
        }
        return false
}
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

