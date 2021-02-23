

import UIKit
import Charts

class WalletViewController: UIViewController, ChartViewDelegate

{
    var graph = PieChart()
    
    var pieChart = PieChartView()
    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.delegate = self
        lineChart.delegate = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        lineChart.frame = CGRect(
               
                   x: 0,y: 0,
                   width: 400,
                   height: 300
                   
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
        
        
        /*pieChart.frame = CGRect(
        
            x: 0,y: 0,
            width: self.view.frame.size.width,
            height: self.view.frame.size.height
            
        )
        pieChart.center = view.center
        view.addSubview(pieChart)
        var entries = [ChartDataEntry]()
        
        for x in 0...10{
            
            entries.append(ChartDataEntry(
                
                x: Double(x),
                y: Double(x)
                
            ))
            
        }
        
        let set =  PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        let data = PieChartData(dataSet: set)
        pieChart.data = data*/
    }

}
