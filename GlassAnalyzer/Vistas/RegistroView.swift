//
//  RegistroView.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI
import AlertToast

struct RegistroView: View {
        @State var nombreUsuario: String = ""
        @State var passUsuario: String = ""
        @State var cpassUsuario: String = ""
        @State var correoUsuario: String = ""
        @State var indexError: Int16 = 0
        @State var mensajeError: String = ""
        @StateObject private var vm: ViewModel = ViewModel()
        @Binding var irRegistro: Bool
        @State var opacidadUsuario: Double = 0.0
        @State var opacidadCorreo: Double = 0.0
        @State var showingPass : Double = 0.0
        @State var showingConfPass : Double = 0.0
        
        var body: some View {
            VStack{
                HStack{
                Image("logoMain")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .leading)
                        
                Text("Registro")
                        .font(.custom("Inter-Bold", size: 30))
                        
                }.offset(x: -80, y: -40)
                Spacer().frame(height: 30)
                VStack{
                    VStack{
                        Spacer().frame(height: 100)
                        HStack{
                            Text("Usuario:").foregroundColor(.black)
                            Spacer().frame(width: 35)
                            TextField("Usuario...",text: $nombreUsuario)
                                .autocapitalization(UITextAutocapitalizationType.none)
                                .padding(.leading,10)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .frame(width: 165)
                            Button(){
                                if(opacidadUsuario == 0.0){
                                    opacidadUsuario = 1
                                }else{
                                    opacidadUsuario = 0
                                }
                               
                            }label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                                .opacity(0.5)
                                .frame(width: 15, height: 15, alignment: .leading)
                            }
                            
                        }.frame(width: 300, alignment: .center)
                        
                        Text("Indique su usuario aqui (Minimo 4 caracteres)")
                            .font(.custom("Inter", size: 10))
                            .frame(height: 10)
                            .offset(x: 30, y: -5)
                            .opacity(opacidadUsuario)
                     
                    
                        HStack{
                            Text("Correo:").foregroundColor(.black).padding(.trailing, 30)
                            Spacer().frame(width: 10)
                            TextField("Correo...",text: $correoUsuario)
                                .autocapitalization(UITextAutocapitalizationType.none)
                                .padding(.leading,10)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .frame(width: 165)
                            Button(){
                                if(opacidadCorreo == 0.0){
                                    opacidadCorreo = 1
                                }else{
                                    opacidadCorreo = 0
                                }
                               
                            }label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                                .opacity(0.5)
                                .frame(width: 15, height: 15, alignment: .leading)
                            }
                            
                        }.frame(width: 300, alignment: .center)
                        
                        Text("Indique su correo aqui")
                            .font(.custom("Inter", size: 10))
                            .frame(height: 10)
                            .offset(x: 30, y: -5)
                            .opacity(opacidadCorreo)
                        
                        HStack{
                            Text("Contraseña:").foregroundColor(.black).padding(.trailing, 1)
                            Spacer().frame(width: 5)
                            SecureField("Contraseña...",text: $passUsuario)
                                .autocapitalization(UITextAutocapitalizationType.none)
                                .padding(.leading,10)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .frame(width: 165)
                            Button(){
                                if(showingPass == 0.0){
                                    showingPass = 1
                                }else{
                                    showingPass = 0
                                }
                               
                            }label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.gray)
                                .opacity(0.5)
                                .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }.frame(width: 300, alignment: .center)
                            
                                        
                        Text("Indique su contraseña aqui (Minimo 6 caracteres)")
                            .font(.custom("Inter", size: 10))
                            .frame(height: 10)
                            .offset(x: 30, y: -5)
                            .opacity(showingPass)
                       
                    HStack{
                        VStack{
                            Text("Confirmar contraseña:").foregroundColor(.black).padding(.trailing,1)
                        }.frame(height: 40)
                        Spacer().frame(width: 10)
                        SecureField("Contraseña...",text: $cpassUsuario)
                            .autocapitalization(UITextAutocapitalizationType.none)
                            .padding(.leading,10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .frame(width: 165)
                        Button(){
                            if(showingConfPass == 0.0){
                                showingConfPass = 1
                            }else{
                                showingConfPass = 0
                            }
                           
                        }label: {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(width: 15, height: 15, alignment: .leading)
                        }
                        
                    }.frame(width: 300, alignment: .center)
                    
                    Text("Indique su contraseña aqui (Minimo 6 caracteres)")
                        .font(.custom("Inter", size: 10))
                        .frame(height: 10)
                        .offset(x: 30, y: -5)
                        .opacity(showingConfPass)
                   

                        
                    }.frame(width: 800, alignment: .center)
                    
                    Spacer().frame(height: 40)
                    
                    Text(mensajeError)
                        .font(.custom("Inter", size: 12))
                        .frame(height: 10)
                        .offset(y: -10)
                      
                    
                        Button("Registrarse"){
                            
                            if(nombreUsuario.isEmpty || correoUsuario.isEmpty || passUsuario.isEmpty || cpassUsuario.isEmpty){
                                mostrarMensajeError(indexError: 1)
                            }else if(usuarioExiste(usuarioaux: nombreUsuario)){
                                mostrarMensajeError(indexError: 2)
                            }else if(!isValidEmail(email: correoUsuario)){
                                mostrarMensajeError(indexError: 5)
                            }else if(correoExiste(correo: correoUsuario)){
                               mostrarMensajeError(indexError: 3)
                            }else if(cpassUsuario != passUsuario ){
                                mostrarMensajeError(indexError: 4)
                            }else if(nombreUsuario.count < 4){
                                mostrarMensajeError(indexError: 6)
                            }else if(passUsuario.count < 6){
                                mostrarMensajeError(indexError: 7)
                            }else {
                                vm.addUsuario(nombre: nombreUsuario, correo: correoUsuario, password: passUsuario)
                                irRegistro.toggle()
                            }
                        }
                        .font(.custom("Inter", size: 14))
                        .fixedSize(horizontal: true, vertical: true)
                        .frame(width: 120, height: 50, alignment: .center)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(20)
                            
                    Spacer().frame(height: 20)
                    
                    Button("Volver atrás"){
                        irRegistro.toggle()
                    }
                    .font(.custom("Inter", size: 14))
                    .fixedSize(horizontal: true, vertical: true)
                    .frame(width: 120, height: 50, alignment: .center)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
                    Spacer().frame(height: 50)
                    
                }.background(Color("ColorMoradoApp"))
                    .frame(width: 350, height: 450, alignment: .center)
                    .cornerRadius(30)
                    .offset(y: -30)
            }
    }
    func usuarioExiste(usuarioaux: String) -> Bool {
        for usuario in vm.usuarioArray{
            if(usuario.nombre == usuarioaux){
                return true
            }
        }
        return false
            
    }
    func correoExiste(correo: String) -> Bool {
        for usuario in vm.usuarioArray{
            if(usuario.correo == correo){
                return true
            }
        }
        return false
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func mostrarMensajeError(indexError: Int16){
    switch(indexError){
        case 1:
        mensajeError = "Existen campos sin rellenar. Por favor, revíselo"
        case 2:
        mensajeError = "Usuario ya existente. Pruebe con otro o inicie sesión"
        case 3:
        mensajeError = "El correo ya existe";
        case 4:
        mensajeError = "Las contraseñas no coinciden"
        case 5:
        mensajeError = "Escriba el correo correctamente"
        case 6:
        mensajeError = "La longitud del usuario minima es de 4 caracteres"
        case 7:
        mensajeError = "La longitud de la contraseña minima es de 6 caracteres"
        default:
        mensajeError = ""
    }

    }
}




