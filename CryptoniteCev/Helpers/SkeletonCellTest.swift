

import UIKit
import SkeletonView
class SkeletonCellTest: UIViewController, SkeletonTableViewDataSource  {
    
    
    
    

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var text: UILabel!
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.rowHeight = 120
        myTableView.estimatedRowHeight = 120
        myTableView.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            
            for _ in 0..<20{
                self.data.append("Some text")
            }
            self.myTableView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            self.myTableView.reloadData()
        })
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myTableView.isSkeletonable = true
        myTableView.showSkeleton(usingColor: .asbestos, transition: .crossDissolve(0.25))
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tTableViewTableViewCell.identifier, for: indexPath) as! tTableViewTableViewCell
        
        if  !data.isEmpty {
            cell.myLabel.text = data[indexPath.row]
        }
        
        return cell
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return tTableViewTableViewCell.identifier
    }
}
