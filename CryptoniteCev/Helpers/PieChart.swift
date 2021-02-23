import UIKit
import Charts



class PieChart: UIViewController, ChartViewDelegate{
    
    
        
    func impirmirGrafica(lineChart: LineChartView){
        
        
            
        lineChart.frame = CGRect(
        
            x: 0,y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.width
            
        )
        print("está haciendo la funcion")
        lineChart.center = view.center
        view.addSubview(lineChart)
        var entries = [ChartDataEntry]()
        
        for x in 0...10{
            
            entries.append(ChartDataEntry(
                
                x: Double(x),
                y: Double(x^2)
                
            ))
            
        }
        
        
        let set =  LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        
        print("Llega al final")
    }
    
    
}
