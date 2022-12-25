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
    @State var usuario: String = ""
    @State var usuarioNo: String = ""
    @State var correo: String = ""
    @State var correoNo: String = ""
    @State var edicionUser: Bool = false
    @State var edicionMail: Bool = false
    var body: some View {
            VStack{
                HStack{
                    Text("Perfil")
                        .font(Font.title)
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
                                usuarioNo = usuario
                                edicionUser.toggle()
                            }
                            Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                usuario = usuarioNo
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
                                correoNo = correo
                                edicionMail.toggle()
                            }
                            Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                correo = correoNo
                                edicionMail.toggle()
                            }
                        }else if (!edicionUser || !edicionMail){
                            Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 25, height: 25)
                        }
                    } //comentario subida
                    Spacer()
                }
                Spacer()
            }
        }
}
