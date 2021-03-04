import UIKit
import Charts

class PieChart: UIViewController, ChartViewDelegate{
    
    public func impirmirGrafica(pieChart: PieChartView, screen: UIView){
        
        pieChart.frame = CGRect(
            x: 0,y: 0,
            width: screen.frame.width,
            height: screen.frame.height
                   
               )
        
        print("está haciendo la funcion")
           
        screen.addSubview(pieChart)
           
        pieChart.topAnchor.constraint(equalTo: screen.topAnchor, constant: screen.frame.height).isActive = true
        pieChart.leadingAnchor.constraint(equalTo: screen.leadingAnchor, constant: screen.frame.width).isActive = true
        pieChart.trailingAnchor.constraint(equalTo: screen.trailingAnchor, constant: -screen.frame.width).isActive = true
        pieChart.heightAnchor.constraint(equalToConstant: screen.frame.height).isActive = true

        var entries = [ChartDataEntry]()
        
        for x in 0...10{
           
            entries.append(ChartDataEntry(
               
               x: Double(x),
               y: Double(x)
               
           ))
           
        }
            
        let set =  PieChartDataSet(entries: entries)

        set.colors = ChartColorTemplates.material()
        set.valueTextColor = UIColor.white
        
      
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        
    }
    
}
