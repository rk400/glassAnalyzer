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
    var values = ["Abierto", "Cerrado"]
    @State private var showToast = false
    @State private var seleccion = "Abierto"
    var body: some View {
        VStack{
            VStack{
                Text(vm.ejecucionArray.last?.nombre ?? "Nombre Experimento")
                    .padding(.bottom)
                
                Image("VidrioNoFlotadoEdificio")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                
                Text(vm.ejecucionArray.last?.resultado ?? "Nombre resultado")
                    .padding(.init(top: 25, leading: 50, bottom: 25, trailing: 50))
                    .border(Color.black, width: 1)
                    .background(Color.white)
                    .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
                
                
                Picker("", selection: $seleccion){
                    ForEach(values, id: \.self){
                        Text($0).background(Color.white)
                    }
                }.pickerStyle(SegmentedPickerStyle())
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
                        BarChartDataEntry(x: 1, y: vm.ejecucionArray.last?.ri ?? 5.5),
                        BarChartDataEntry(x: 2, y: vm.ejecucionArray.last?.mg ?? 7),
                        BarChartDataEntry(x: 3, y: vm.ejecucionArray.last?.al ?? 3),
                        BarChartDataEntry(x: 4, y: vm.ejecucionArray.last?.k ?? 4),
                        BarChartDataEntry(x: 5, y: vm.ejecucionArray.last?.ca ?? 8),
                        BarChartDataEntry(x: 6, y: vm.ejecucionArray.last?.ba ?? 3)
                    ]).frame(width: 400, height: 500)
                }
                
            
        }.frame(width: 390, height: 800, alignment: .center)
        .background(
            Image("Rectangulo")
                .resizable()
                .frame(width: 390, height: 550)
                .offset(x: 0, y: 150)
        )
    }
}
}

