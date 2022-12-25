import SwiftUI
import Charts
import UIKit
import AlertToast


struct Bar: UIViewRepresentable {
    var entries : [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        
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

struct CountryItem {
    let index: Int
    let country: String
    let birthRate: Double
    
    func transformToBarChartDataEntry() -> BarChartDataEntry {
        let entry = BarChartDataEntry(x: Double(index), y: birthRate)
        return entry
    }
}




struct ResultadoView: View {
    var values = ["Abierto", "Cerrado"]
    @State private var showToast = false
    @State private var seleccion = "Abierto"
    var body: some View {
        VStack{
            VStack{
                Text("Nombre Experimento")
                    .padding(.bottom)
                
                Image("VidrioNoFlotadoEdificio")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                
                Text("Nombre resultado")
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
                        BarChartDataEntry(x: 1, y: 2),
                        BarChartDataEntry(x: 2, y: 5),
                        BarChartDataEntry(x: 3, y: 7),
                        BarChartDataEntry(x: 4, y: 4),
                        BarChartDataEntry(x: 4, y: 5)
                    ])
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

struct ResultadoView_Previews: PreviewProvider {
    static var previews: some View {
        Bar(entries: [
            BarChartDataEntry(x: 1, y: 2),
            BarChartDataEntry(x: 2, y: 5),
            BarChartDataEntry(x: 3, y: 7),
            BarChartDataEntry(x: 4, y: 4)
        ])
    }
}
