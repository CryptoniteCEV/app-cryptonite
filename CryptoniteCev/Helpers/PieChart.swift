import UIKit
import Charts



class PieChart: UIViewController, ChartViewDelegate{
    
    
        
    public func impirmirGrafica(lineChart: LineChartView, screen: UIView){
        
        
        lineChart.frame = CGRect(
               
                   x: 0,y: 0,
            width: screen.frame.width,
                   height: 200
                   
               )
        
        print("está haciendo la funcion")
           
          
        screen.addSubview(lineChart)
           
                lineChart.topAnchor.constraint(equalTo: screen.topAnchor, constant: screen.frame.height).isActive = true
                lineChart.leadingAnchor.constraint(equalTo: screen.leadingAnchor, constant: screen.frame.width).isActive = true
                lineChart.trailingAnchor.constraint(equalTo: screen.trailingAnchor, constant: -screen.frame.width).isActive = true
                lineChart.heightAnchor.constraint(equalToConstant: screen.frame.height).isActive = true

             var entries = [ChartDataEntry]()
        
               for x in 0...10{
                   
                   entries.append(ChartDataEntry(
                       
                       x: Double(x),
                       y: Double(-x^3)
                       
                   ))
                   
               }
               
               
               let set =  LineChartDataSet(entries: entries)
        
               set.colors = ChartColorTemplates.material()
               set.valueTextColor = UIColor.white
               set.circleRadius = 5
          
               let data = LineChartData(dataSet: set)
               lineChart.data = data
       
        
        
    }
    
    
}
