//
//  CurvesTableViewController.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

import UIKit

class CurvesTableViewController: UITableViewController {
    
    private let curves = AnimationDataManager.shared.curves

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func closeButton() {
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curves.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "curveCell", for: indexPath)
        let curve = curves[indexPath.row]
        
        cell.textLabel?.text = curves[indexPath.row]
        
        let selectCurve = AnimationDataManager.shared.selectCurve
        if curve == selectCurve {
            cell.backgroundColor = .systemTeal
        }
        
        return cell
        
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        AnimationDataManager.shared.selectCurve = curves[indexPath.row]
        dismiss(animated: true)
    }
}
