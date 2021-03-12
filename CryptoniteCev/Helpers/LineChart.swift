import UIKit
import Charts

class LineChart: UIViewController, ChartViewDelegate{
    
    public func impirmirGrafica(lineChart: LineChartView, screen: UIView, values:[ChartDataEntry], coinSymbol:String){
        
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
        set.drawValuesEnabled = false
        //set.drawCircleHoleEnabled = true
        set.drawCirclesEnabled = false
        set.colors = [Colors.shared.graph[coinSymbol]!]
        set.highlightColor = #colorLiteral(red: 0.262745098, green: 0.8509803922, blue: 0.7411764706, alpha: 1)
        
        //Remove grid lines
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        
        //Removed labels
        lineChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChart.rightAxis.drawLabelsEnabled = false
        
        
        lineChart.legend.enabled = false
        
    
              
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        
    }
    
}
