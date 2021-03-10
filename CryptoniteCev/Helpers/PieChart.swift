import UIKit
import Charts

class PieChart: UIViewController, ChartViewDelegate{
    
    public func impirmirGrafica(pieChart: PieChartView, screen: UIView){
        
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

        
        let etheriumEntry: Double = 20
        let bitcoinEntry: Double = 20
        let dogeEntry: Double = 20
        let liteEntry: Double = 20
        let tetherEntry: Double = 20
       
            
        var entries : [PieChartDataEntry] = Array()
        //Entrada de etherium
        entries.append(PieChartDataEntry(value: etheriumEntry, label: "ETH"))
        //entrada de Bitcoin
        entries.append(PieChartDataEntry(value: bitcoinEntry, label: "BTC"))
        //entrada de Dogecoin
        entries.append(PieChartDataEntry(value: dogeEntry, label: "DOGE"))
        //entrada de litecoint
        entries.append(PieChartDataEntry(value: liteEntry, label: "LITE"))
        //entrada de tether
        entries.append(PieChartDataEntry(value: tetherEntry, label: "USDT"))
            
        let set =  PieChartDataSet(entries: entries)
        
        
        
        let etheriumColor = NSUIColor(red: 98/255.0, green: 126/255.0, blue: 224/255.0, alpha: 0.95)
        
        let bitcoinColor = NSUIColor(red: 242/255.0, green: 127/255.0, blue: 27/255.0, alpha: 0.95)
        let dogeColor = NSUIColor(red: 244/255.0, green: 245/255.0, blue: 121/255.0, alpha: 0.96)
        let liteColor = NSUIColor(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.75)
        let tetherColor = NSUIColor(red: 80/255.0, green: 175/255.0, blue: 149/255.0, alpha: 0.69)
        
        
        let valueColor = NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.95)
        let labelEntryColor = NSUIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.95)
        
        set.colors = [etheriumColor, bitcoinColor,dogeColor,liteColor,tetherColor]
        set.valueColors =  [valueColor]
        set.entryLabelColor = labelEntryColor
        
        
        
        
      
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        
    }
    
}
