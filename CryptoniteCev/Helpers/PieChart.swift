import UIKit
import Charts

class PieChart: UIViewController, ChartViewDelegate{
    
    public func impirmirGrafica(pieChart: PieChartView, screen: UIView, percentages: [String:Double]){
        
        pieChart.frame = CGRect(
            x: 0,y: 0,
            width: screen.frame.width,
            height: screen.frame.height
                   
               )
        /*pieChart.rotationAngle = 0
        pieChart.rotationEnabled = false*/
        
        pieChart.drawHoleEnabled = false
        //5print("está haciendo la funcion")
           
        screen.addSubview(pieChart)
           
        pieChart.topAnchor.constraint(equalTo: screen.topAnchor, constant: screen.frame.height).isActive = true
        pieChart.leadingAnchor.constraint(equalTo: screen.leadingAnchor, constant: screen.frame.width).isActive = true
        pieChart.trailingAnchor.constraint(equalTo: screen.trailingAnchor, constant: -screen.frame.width).isActive = true
        pieChart.heightAnchor.constraint(equalToConstant: screen.frame.height).isActive = true

        var entries:[PieChartDataEntry] = []
        var colorsGraph:[NSUIColor] = []
        
        for (name, value) in percentages {
            entries.append(PieChartDataEntry(value: value, label: name))
            colorsGraph.append(Colors.shared.graph[name]!)
        }
        
        let set =  PieChartDataSet(entries: entries)
        
        
        
        let valueColor = NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.95)
        let labelEntryColor = NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.95)
        
        set.colors = colorsGraph
        set.valueColors =  [valueColor]
        set.entryLabelColor = labelEntryColor
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        
        let data = PieChartData(dataSet: set)
        data.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        
        pieChart.data = data
        
    }
    
}
