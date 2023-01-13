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
            #if GlassAnalyzerPlus
            resultado = calcresultado(Al: Al, Ba: Ba, Mg: Mg, RI: RI, K: K, Ca: Ca)
            #endif
                vm.addEjecucion(usuario: $usuario.wrappedValue, nombre: nombreCaso.isEmpty ? "Caso sin nombre" : $nombreCaso.wrappedValue, fecha: Date.now, descripcion: descripcion.isEmpty ? "Sin detalles añadidos" : $descripcion.wrappedValue, resultado: resultado.isEmpty ? "Flotado edificio" : $resultado.wrappedValue, estado: estadoCaso.isEmpty ? "CERRADO" : $estadoCaso.wrappedValue, al: Al.isNaN ? 0 : $Al.wrappedValue, ba: Ba.isNaN ? 0 : $Ba.wrappedValue, ca: Ca.isNaN ? 0 : $Ca.wrappedValue, k: K.isNaN ? 0 : $K.wrappedValue, mg: Mg.isNaN ? 0 : $Mg.wrappedValue, ri: RI.isNaN ? 0 : $RI.wrappedValue)
                ejecucion = vm.ejecucionArray.last!
              
                
            }
        }
       
}
#if GlassAnalyzerPlus
func calcresultado(Al : Double, Ba : Double, Mg: Double, RI: Double, K: Double, Ca: Double) -> String {

      var valores = [Double](repeating: 0.0, count: 7) //0 = cristalFloat, 1= cristalNoFloat, 2= vehiculoFloat, 3= vehiculoNoFloat, 4= contenedores, 5= vajilla, 6= bombillas
      if( Ba <= 0.27 ) {
          if( Mg <= 2.41 ) {
              valores[0] = -145.54 + RI * 90.16 +  Mg * 1.32 + Al * -4.5 + K * 0.78 + Ca * 0.06 + Ba * -9.19
              valores[1] = -786.27 + RI * 519.68 + Mg * -0.4 + Al * -1.28 + K * 0.8  + Ca * -0.11 + Ba * 8.25
              valores[2] = 460.78 + RI * -316.05 + Mg * 1.76 + Al * -2.75 + K * -2.68 + Ca * 0.87
              valores[3] = -31.08 + Mg * 0.01 + Al * -0
              valores[4] = 871.16 + RI * -584.24 + Mg * -0.57 + Al * 4.56 + K * 0.86 + Ca * 1.09 + Ba * 2.46
              valores[5] = -824.35 + RI * 553.91 + Mg * -0.21 + Al * 4.65 + K * -113.95 + Ca * -1.65 + Ba * -3.04
              valores[6] = -1444.01 + RI * 966.12 + Mg * -0.84 + Al * 0.36 + K * 1.46 + Ca * -2.49 + Ba * -7.47
          } else {
              if( Al <= 1.41 ) {
                  if( RI <= 1.51707) {
                      valores[0] = 87436.25 + RI * -57673.49 + Mg * -0.3 + Al * -3.22 + K * 8.39 + Ca * -0.27 + Ba * -11.98
                      valores[1] = -14792.07 + RI * 9815.19 + Mg * 0.83 + Al * -67.56 + K * -10.17 + Ca * -0.32 + Ba * -7.98
                      valores[2] = 6100.72 + RI * -4073.23 + Mg * 1.52 + Al * 10.93 + K * -3.71 + Ca * 7.25 + Ba * 1.81
                      valores[3] = -51.65 + Mg * 0.01 + Al * -0
                      valores[4] = 17.53 + RI * -38.05 + Mg * -1.25 + Al * 3.98 + K * 0.49 + Ca * 0.46 + Ba * 2.46
                      valores[5] = 154.89 + RI * -118.9 + Mg * -0.21 + Al * 3.9 + K * -112.96 + Ca * -0.54 + Ba * -3.04
                      valores[6] = -3733.18 + RI * 2457.43 + Mg * -6 + Al * 0.36 + K * 29.99 + Ca * -1.31 + Ba * 1.62
                      
                  } else {
                      if ( K <= 0.23 ) {
                          valores[0] = 124.97 + RI * -78.58 + Mg * 1.28 + Al * -3.05 + K * -4.5 + Ca * -0.28 + Ba * -23.86
                          valores[1] = -815.23 + RI * 619.01 + Mg * -36.66 + Al * -3.17 + K * 7.46 + Ca * -0.02 + Ba * -7.98
                          valores[2] = 1151 + RI * -753.53 + Mg * 1.77 + Al * -4.44 + K * -3.4 + Ca * -0.46 + Ba * 19.21
                          valores[3] = -61.93 +  Mg * 0.01 + Al * -0
                          valores[4] = 7.24 + RI * -38.05 + Mg * -1.25 + Al * 3.98 + K * 0.49 + Ca * 0.46 + Ba * 2.46
                          valores[5] = 144.61 +  RI * -118.9 + Mg * -0.21 + Al * 3.9 + K * -112.96 + Ca * -0.54 + Ba * -3.04
                          valores[6] = -5209.15 + RI * 3431.78 + Mg * -10.39 + Al * 0.36 + K * 45.07 + Ca * -1.31 + Ba * 1.62
                          
                      } else {
                          valores[0] = 728.29 + RI * -459.52 + Mg * -5.69 + Al * 4.94 + K * 5.37 + Ca * -1.98 + Ba * 2.64
                          valores[1] = -1617.23 + RI * 1054.98 + Mg * 5.41 + Al * -6.64 + K * -11.03 + Ca * 1.43 + Ba * -22.61
                          valores[2] = 1245.5 + RI * -827.3 + Mg * 0.61 + Al * -4.27 + K * -11.8 + Ca * 0.83 + Ba * 13.29
                          valores[3] = -61.93 + Mg * 0.01 + Al * -0
                          valores[4] = 7.24 + RI * -38.05 + Mg * -1.25 + Al * 3.98 + K * 0.49 + Ca * 0.46 + Ba * 2.46
                          valores[5] = 144.61 + RI * -118.9 + Mg * -0.21 + Al * 3.9  + K * -112.96 + Ca * -0.54 + Ba * -3.04
                          valores[6] = -9775.23 + RI * 6415.58 + Mg * -14.54 + Al * 0.36 + K * 132.96 + Ca * -1.31 + Ba * 1.62
                      }
                  }
                  
              } else {
                  if ( Mg <= 3.45 ) {
                      valores[0] = 727.54 + RI * -493.91 + Mg * 3.48 + Al * -4.86 + K * -0.36 + Ca * 0.82 + Ba * -22.55
                      valores[1] = 70.65 + RI * 41.45 + Mg * -12.14 + Al * -19.31 + K * -4.32 + Ca * -6.88 + Ba * 8.25
                      valores[2] = -275.01 + RI * 58.48 + Mg * 16.96 + Al * 21.12 + K * 1.37 + Ca * 11.22 + Ba * 1.81
                      valores[3] = -51.65 + Mg * 0.01 + Al * -0
                      valores[4] = 17.53 + RI * -38.05 + Mg * -1.25 + Al * 3.98 + K * 0.49 + Ca * 0.46 + Ba * 2.46
                      valores[5] = 154.89 + RI * -118.9 + Mg * -0.21 + Al * 3.9  + K * -112.96 + Ca * -0.54 + Ba * -3.04
                      valores[6] = -2820.83 + RI * 1845.88 + Mg * -1.05 + Al * 0.36 + K * 13.17 + Ca * -1.31 + Ba * 1.62
              
                  } else {
                      valores[0] = 1312.41 + RI * -880.94 + Mg * -0.29 + Al * -4.62 + K * -1.24 + Ca * 4.07 + Ba * -37.59
                      valores[1] = -624.35 + RI * 431.01 + Mg * 2.29 + Al * -4.14 + K * 4.5  + Ca * -3.9 + Ba * 23.09
                      valores[2] = 37.03 + RI * -85.69 + Mg * 4.76 + Al * 5.66 + K * -3.1 + Ca * 6.83 + Ba * 1.81
                      valores[3] = -51.65 + Mg * 0.01 + Al * -0
                      valores[4] = 17.53 + RI * -38.05 + Mg * -1.25 + Al * 3.98 + K * 0.49 + Ca * 0.46 + Ba * 2.46
                      valores[5] = 154.89 + RI * -118.9 + Mg * -0.21 + Al * 3.9  + K * -112.96 + Ca * -0.54 + Ba * -3.04
                      valores[6] = -2820.83 + RI * 1845.88 + Mg * -1.05 + Al * 0.36 + K * 13.17 + Ca * -1.31 + Ba * 1.62
                      }
              }
          }
                  
                                                                                                      
      } else {
          valores[0] = -103.78 + RI * 90.07 + Mg * 3.08 + Al * -19.31 + K * 0.3  + Ba * -11.22
          valores[1] = -276.97 + RI * 158.76 + Mg * 0.28 + Al * -0.38 + K * 0.47 + Ca * 2.43 + Ba * 4.83
          valores[2] = 195.39 + RI * -137.22 + Mg * 1.1  + Al * -2.5 + K * -1.77 + Ca * 0.34
          valores[3] = -20.79 + Mg * 0.01 + Al * -0
          valores[4] = -54.49 + Mg * -0.67 + Al * 15.15 + K * 3.08 + Ca * 0.37 + Ba * 4.04
          valores[5] = 174.85 + RI * -118.9 + Mg * -0.32 + K * -22.56 + Ca * -0.22 + Ba * -3.04
          valores[6] = 121.08 + RI * -66.07 + Mg * -2.54 + Al * -1.06 + Ca * -0.9 + Ba * -1.17
      
          
      }
      var iteracion = 0
      var resultadoIteracion = 0
      var resultadoValor = 0.0
              
      
            for result in valores{
                 if(result > resultadoValor){
                     resultadoValor = result
                     resultadoIteracion = iteracion
                 }
                 iteracion+=1
             }
            
       
             if(resultadoIteracion == 0){
                 return "Flotado edificio"
             }else if (resultadoIteracion == 1){
                 return "No flotado edificio"
             }else if (resultadoIteracion == 2){
                 return "Flotado vehiculo"
             }else if (resultadoIteracion == 3){
                 return "No flotado vehiculo"
             }else if (resultadoIteracion == 4){
                 return "Recipiente"
             }else if (resultadoIteracion == 5){
                 return "Vajilla"
             }else if (resultadoIteracion == 6){
                 return "Faro vehiculo"
             }else{
                 return "Fotado edificio"
             }
}
           
         
        #endif
    
}
