import UIKit
import Charts

class LineChart: UIViewController, ChartViewDelegate{
    
    public func impirmirGrafica(lineChart: LineChartView, screen: UIView, values:[ChartDataEntry]){
        
        lineChart.frame = CGRect(
            x: 0,y: 0,
            width: screen.frame.width,
            height: screen.frame.height
                   
               )
           
        screen.addSubview(lineChart)
           
        lineChart.topAnchor.constraint(equalTo: screen.topAnchor, constant: screen.frame.height).isActive = true
        lineChart.leadingAnchor.constraint(equalTo: screen.leadingAnchor, constant: screen.frame.width).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: screen.trailingAnchor, constant: -screen.frame.width).isActive = true
        lineChart.heightAnchor.constraint(equalToConstant: screen.frame.height).isActive = true

            
        let set =  LineChartDataSet(entries: values)

        set.colors = ChartColorTemplates.material()
        set.valueTextColor = UIColor.white
        set.circleRadius = 5
      
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        
    }
    
}
