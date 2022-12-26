//
//  PerfilView.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//
import Foundation
import SwiftUI

struct PerfilView: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var sesionIniciada: Bool
    var user: Usuario
    @State var usuario: String = ""
    @State var usuarioNo: String = ""
    @State var correo: String = ""
    @State var correoNo: String = ""
    @State var edicionUser: Bool = false
    @State var edicionMail: Bool = false
    @State var mensajeError: String = ""
    var body: some View {
            VStack{
                HStack{
                    Text("Perfil")
                        .font(Font.title)
                        .bold()
                    Spacer()
                    Button{
                        sesionIniciada.toggle()
                    }label: {
                        Image(systemName: "person.crop.circle.badge.xmark")
                            .resizable()
                            .frame(width: 50, height: 40)
                            .foregroundColor(Color.red)
                    }
                }.frame(alignment: .top)
                Image("logoMain")
                    .resizable()
                    .frame(width: 200, height: 200)
                HStack{
                    Text("Usuario")
                    if(edicionUser) {
                        TextField("Nuevo nombre", text: $usuario)
                    }else{
                        Text(usuario)
                    }
                    Button{
                        edicionUser.toggle()
                    }label: {
                        if(edicionUser) {
                            Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.green)
                            .onTapGesture {
                                if(usuario.isEmpty){
                                    mostrarMensajeError(indexError: 1)
                                }else if(usuarioExiste(usuarioaux: usuario)){
                                    mostrarMensajeError(indexError: 2)
                                }else {
                                    vm.modificarNombreUsuario(usuario: user, nombreUsuario: usuario)
                                    usuarioNo = usuario
                                    mensajeError = "";
                                    edicionUser.toggle()
                                }
                            }
                            Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                usuario = usuarioNo
                                mensajeError = "";
                                edicionUser.toggle()
                            }
                        }else if (!edicionUser || !edicionMail){
                            Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 25, height: 25)
                        }
                    }
                    if(edicionUser){
                        
                    }
                    Spacer()
                }
                HStack{
                    Text("Correo")
                    if(edicionMail) {
                        TextField("Nuevo correo", text: $correo)
                    }else{
                        Text(correo)
                    }
                    Button{
                        edicionMail.toggle()
                    }label: {
                        if(edicionMail) {
                            Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.green)
                            .onTapGesture {
                                if(correo.isEmpty){
                                    mostrarMensajeError(indexError: 1)
                                }else if(correoExiste(correo: correo)){
                                    mostrarMensajeError(indexError: 3)
                                }else if(!isValidEmail(email: correo)){
                                    mostrarMensajeError(indexError: 5)
                                }
                                else {
                                    vm.modificarCorreoUsuario(usuario: user, correo: correo)
                                    correoNo = correo
                                    mensajeError = "";
                                    edicionMail.toggle()
                                }
                            }
                            Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                correo = correoNo
                                mensajeError = "";
                                edicionMail.toggle()
                            }
                        }else if (!edicionUser || !edicionMail){
                            Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 25, height: 25)
                        }
                    }
                    Spacer()
                }
                Spacer().frame(height: 30)
                Text(mensajeError)
                    .font(.custom("Inter", size: 12))
                    .frame(height: 10)
                    .offset(y: -10)
                Spacer()
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
        mensajeError = "El campo no puede estar vacío. Por favor, revíselo"
        case 2:
        mensajeError = "Usuario ya existente. Pruebe con otro o inicie sesión"
        case 3:
        mensajeError = "El correo ya existe";
        case 4:
        mensajeError = "Las contraseñas no coinciden"
        case 5:
        mensajeError = "Escriba el correo correctamente"
        default:
        mensajeError = ""
    }

    }}
