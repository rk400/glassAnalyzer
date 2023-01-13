import SwiftUI
import Charts
import UIKit
import AlertToast
import CoreData



struct Bar: UIViewRepresentable {
    func updateUIView(_ uiView: BarChartView, context: Context) {
    }
    
    let resultados = ["", "Ri", "Mg", "Al", "K", "Ca", "Ba"]
    var entries : [BarChartDataEntry]
    var chart: BarChartView!
    weak var axisFormatDelegate: IAxisValueFormatter?
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: resultados)
        chart.data = addData()
        chart.noDataText = "No hay datos."
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        return chart
    }
    
    
    
    func addData() -> BarChartData {
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = [NSUIColor(Color("ColorMoradoApp"))]
        data.addDataSet(dataSet)
        return data
    }
    
    
    typealias UIViewType = BarChartView
}



struct ResultadoView: View {
    @EnvironmentObject var vm: ViewModel
    var values = ["ABIERTO", "CERRADO"]
    @State var nombreCaso:String = ""
    @State var RI:Double = 0
    @State var Mg:Double = 0
    @State var Al:Double = 0
    @State var K:Double = 0
    @State var Ca:Double = 0
    @State var Ba:Double = 0
    @State var estadoCaso:String
    @State var resultado:String = ""
    @State var descripcion:String = ""
    @Binding var usuario: Usuario
    @Binding var sesionIniciada: Bool
    @State private var showToast = false
    @State private var Img = ""
    @State var esNuevo: Bool
    @State var ejecucion: Ejecucion = Ejecucion()
    @Binding var showResult: Bool
    var body: some View {
        VStack{
            VStack{
                Text(nombreCaso)
                    .padding(.bottom)
                
                
                Image(resultado)
                    .resizable()
                    .frame(width: 150, height: 150)
                
                
                Text(resultado)
                    .padding(.init(top: 25, leading: 50, bottom: 25, trailing: 50))
                    .border(Color.black, width: 1)
                    .background(Color.white)
                    .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
                
                
                Picker("", selection: $estadoCaso){
                    ForEach(values, id: \.self){
                        Text($0).background(Color.white)
                    }
                    
                }.onChange(of: estadoCaso) { _ in
                    ejecucion.estado = estadoCaso
                    vm.guardarDatos()
                }
                        
                .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(width: 300, height: 50)
                
                   
                  
                VStack{
                    Text("Stats")
                        .foregroundColor(.black)
                        .padding(.init(top: 10, leading: 50, bottom: 10, trailing: 50))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.black, lineWidth: 1)
                        )
                }.onTapGesture {
                    showToast.toggle()
                }.popover(isPresented: $showToast) {
                    Bar(entries: [
                        BarChartDataEntry(x: 1, y: RI),
                        BarChartDataEntry(x: 2, y: Mg),
                        BarChartDataEntry(x: 3, y: Al),
                        BarChartDataEntry(x: 4, y: K),
                        BarChartDataEntry(x: 5, y: Ca),
                        BarChartDataEntry(x: 6, y: Ba)
                    ]).frame(width: 400, height: 500)
                }
                
            
        }.frame(width: 390, height: 800, alignment: .center)
        .background(
            Image("Rectangulo")
                .resizable()
                .frame(width: 390, height: 550)
                .offset(x: 0, y: 150)
        )
        }.onAppear(){
            if(esNuevo){
                vm.addEjecucion(usuario: $usuario.wrappedValue, nombre: nombreCaso.isEmpty ? "Caso sin nombre" : $nombreCaso.wrappedValue, fecha: Date.now, descripcion: descripcion.isEmpty ? "Sin detalles añadidos" : $descripcion.wrappedValue, resultado: resultado.isEmpty ? "Flotado edificio" : $resultado.wrappedValue, estado: estadoCaso.isEmpty ? "CERRADO" : $estadoCaso.wrappedValue, al: Al.isNaN ? 0 : $Al.wrappedValue, ba: Ba.isNaN ? 0 : $Ba.wrappedValue, ca: Ca.isNaN ? 0 : $Ca.wrappedValue, k: K.isNaN ? 0 : $K.wrappedValue, mg: Mg.isNaN ? 0 : $Mg.wrappedValue, ri: RI.isNaN ? 0 : $RI.wrappedValue)
                ejecucion = vm.ejecucionArray.last!
                print(ejecucion)
            }
        }
       
}
    
}
