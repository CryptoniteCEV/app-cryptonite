

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
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        lineChart.frame = CGRect(
               
                   x: 0,y: 0,
                   width: 400,
                   height: 300
                   
               )
        print("está haciendo la funcion")
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: lineChart, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: lineChart, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: lineChart, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: lineChart, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
       

        lineChart.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
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
    }*/

}
