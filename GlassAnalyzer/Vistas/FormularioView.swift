//
//  FormularioView.swift
//  GlassAnalyzer
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI
import AlertToast

struct FormularioView: View {
    @Environment(\.presentationMode) var modoPresentacion
    @EnvironmentObject var vm: ViewModel
    @Environment(\.managedObjectContext) var moc
    @Binding var usuario:Usuario
    @Binding var sesionIniciada:Bool
    @State var nombreCaso:String = ""
    @State var RI:Double = 0
    @State var Mg:Double = 0
    @State var Al:Double = 0
    @State var K:Double = 0
    @State var Ca:Double = 0
    @State var Ba:Double = 0
    @State var estadoCaso:String = "ABIERTO"
    @State var resultado:String = "Flotado edificio"
    @State var descripcion:String = ""
    @State var showingRI = false
    @State var showingMg = false
    @State var showingAl = false
    @State var showingK = false
    @State var showingCa = false
    @State var showingBa = false
    @State var showResult = false
    @State var cancelar:Bool = false
    let estados = ["ABIERTO", "CERRADO"]
    let resultados = ["Flotado edificio", "No flotado edificio", "Faro vehiculo", "Vajilla", "Flotado vehiculo", "No flotado vehiculo", "Recipiente"]
    
    var formatter: Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfUp
        formatter.minimumFractionDigits = 4
        formatter.maximumFractionDigits = 4
        return formatter
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Form(){
                    Section(header: Text("Nombre del caso")){
                        TextField("Escriba nombre de caso...", text: $nombreCaso)
                    }
                    Section(header: Text("Datos")){
                        HStack{
                            Text("RI:").frame(width: 29,alignment: .leading)
                            Slider(value: $RI,
                                   in: 0...5,
                                   step: 0.0001
                            ) {
                                Text("Selecciona X")
                            }
                            .accentColor(Color("ColorMoradoApp"))
                            TextField("0.0000", value: $RI, formatter: formatter)
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width:60)
                                .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.7))
                                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                                .cornerRadius(5)
                                .keyboardType(.decimalPad)
                            Button(){
                                showingRI = true
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }
                        HStack{
                            Text("Mg:").frame(width: 29,alignment: .leading)
                            Slider(value: $Mg,
                                   in: 0...5,
                                   step: 0.0001
                            ) {
                                Text("Selecciona X")
                            }.accentColor(Color("ColorMoradoApp"))
                            TextField("0.0000", value: $Mg, formatter: formatter)
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width:60)
                                .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.7))
                                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                                .cornerRadius(5)
                                .keyboardType(.decimalPad)
                            Button(){
                                showingMg = true
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }
                        HStack{
                            Text("Al:").frame(width: 29,alignment: .leading)
                            Slider(value: $Al,
                                   in: 0...5,
                                   step: 0.0001
                            ) {
                                Text("Selecciona X")
                            }
                            .accentColor(Color("ColorMoradoApp"))
                            TextField("0.0000", value: $Al, formatter: formatter)
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width:60)
                                .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.7))
                                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                                .cornerRadius(5)
                                .keyboardType(.decimalPad)
                            Button(){
                                showingAl = true
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }
                        HStack{
                            Text("K:").frame(width: 29,alignment: .leading)
                            Slider(value: $K,
                                   in: 0...10,
                                   step: 0.0001
                            ) {
                                Text("Selecciona X")
                            }
                            .accentColor(Color("ColorMoradoApp"))
                            TextField("0.0000", value: $K, formatter: formatter)
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width:60)
                                .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.7))
                                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                                .cornerRadius(5)
                                .keyboardType(.decimalPad)
                            Button(){
                                showingK = true
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }
                        HStack{
                            Text("Ca:").frame(width: 29,alignment: .leading)
                            Slider(value: $Ca,
                                   in: 0...20,
                                   step: 0.0001
                            ) {
                                Text("Selecciona X")
                            }
                            .accentColor(Color("ColorMoradoApp"))
                            TextField("0.0000", value: $Ca, formatter: formatter)
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width:60)
                                .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.7))
                                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                                .cornerRadius(5)
                                .keyboardType(.decimalPad)
                            Button(){
                                showingCa = true
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }
                        HStack{
                            Text("Ba:").frame(width: 29,alignment: .leading)
                            Slider(value: $Ba,
                                   in: 0...5,
                                   step: 0.0001
                            ) {
                                Text("Selecciona X")
                            }
                            .accentColor(Color("ColorMoradoApp"))
                            TextField("0.0000", value: $Ba, formatter: formatter)
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width:60)
                                .foregroundColor(Color.init(red: 0, green: 0, blue: 0, opacity: 0.7))
                                .background(Color.init(red: 0, green: 0, blue: 0, opacity: 0.1))
                                .cornerRadius(5)
                                .keyboardType(.decimalPad)
                            Button(){
                                showingBa = true
                            }label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 15, height: 15, alignment: .leading)
                            }
                        }
                    }
                    Section(header: Text("Estado del caso")){
                        withAnimation{
                            Picker("Seleccionar estado actual", selection: $estadoCaso){
                                ForEach(estados, id:\.self){
                                    Text($0)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    Section(header: Text("Seleccionar resultado")){
                        Picker("Seleccionar resultado", selection: $resultado){
                            ForEach(resultados, id:\.self){
                                Text($0)
                            }
                        }.pickerStyle(MenuPickerStyle())
                    }
                    Section(header: Text("Descripción (opcional)")){
                        TextField("Describa el experimento...", text: $descripcion)
                    }
                }.navigationTitle("Formulario")
                
                HStack{
                    Button(){
                        nombreCaso = ""
                        descripcion = ""
                        resultado = ""
                        estadoCaso = ""
                        Al = 0
                        Ba = 0
                        Ca = 0
                        K = 0
                        Mg = 0
                        RI = 0
                        cancelar = true
                    }label: {
                        Text("Cancelar")
                            .fontWeight(.bold)
                            .frame(width: 120, height: 50, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.init(red: 1, green: 0.48, blue: 0.48))
                            .cornerRadius(88)
                    }.fullScreenCover(isPresented: $cancelar) {
                        MainView(sesionIniciada: $sesionIniciada, usuario: $usuario).environmentObject(vm)
                    }
                    
                    Spacer().frame(width: 60)
                    Button(){
                        showResult.toggle()
                    } label: {
                        NavigationLink (isActive: $showResult){
                                    ResultadoView(nombreCaso: nombreCaso, RI: RI, Mg: Mg, Al: Al, K: K, Ca: Ca, Ba: Ba, estadoCaso: estadoCaso, resultado: resultado, descripcion: descripcion, usuario: $usuario ,sesionIniciada: $sesionIniciada, esNuevo: true, showResult: $showResult).environmentObject(vm)
                        }label:{
                                    Text("Procesar\ndatos")
                                    .fontWeight(.bold)
                                    .fixedSize(horizontal: true, vertical: true)
                                    .frame(width: 120, height: 50, alignment: .center)
                                    .foregroundColor(.white)
                                    .background(Color.init(red: 0.35, green: 0.37, blue: 0.58))
                                    .cornerRadius(88)
                                    .multilineTextAlignment(.center)
                        }
                    }
                }
                Spacer()
            }.background(Color.init(red: 0.95, green: 0.95, blue: 0.97, opacity: 1))
        }
        .toast(isPresenting: $showingRI) {
            AlertToast(type: .image("RI", Color.black), title: "índice de Refracción")
        }
        .toast(isPresenting: $showingMg) {
            AlertToast(type: .image("magnesium", Color.black), title: "Magnesio")
        }
        .toast(isPresenting: $showingAl) {
            AlertToast(type: .image("aluminium", Color.black), title: "Aluminio")
        }
        .toast(isPresenting: $showingK) {
            AlertToast(type: .image("potassium", Color.black), title: "Potasio")
        }
        .toast(isPresenting: $showingCa) {
            AlertToast(type: .image("calcium", Color.black), title: "Calcio")
        }
        .toast(isPresenting: $showingBa) {
            AlertToast(type: .image("barium", Color.black), title: "Bario")
        }
    }
    
}

extension Double {
    func redondear(numeroDeDecimales: Int) -> String {
        let formateador = NumberFormatter()
        formateador.maximumFractionDigits = numeroDeDecimales
        formateador.roundingMode = .down
        return formateador.string(from: NSNumber(value: self)) ?? ""
    }
}
