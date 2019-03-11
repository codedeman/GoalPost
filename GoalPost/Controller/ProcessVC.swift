//
//  ProcessVC.swift
//  GoalPost
//
//  Created by Kien on 3/11/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import QuartzCore

class ProcessVC: UIViewController,LineChartDelegate {
    var lineChart: LineChart!

      var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        var views: [String: AnyObject] = [:]
        label.text = "..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        let data: [CGFloat] = [3, 4, -2, 11, 13, 15]
        let data2: [CGFloat] = [1, 3, 5, 13, 17, 20]
        
        let xLabels: [String] = ["M", "T", "W", "T", "F", "S"]
        
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = true
        lineChart.x.labels.visible = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 5
        lineChart.addLine(data)
        lineChart.addLine(data2)
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
    
        self.view.addSubview(lineChart)
        views["chart"] = lineChart

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))
        
        
        // Do any additional setup after loading the view.
    }
    func didSelectDataPoint(_ x: CGFloat, yValues: [CGFloat]) {
        label.text = "x: \(x)     y: \(yValues)"
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
