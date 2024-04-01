//
//  TruckInfoTableViewCell.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import UIKit

class TruckInfoTableViewCell: UITableViewCell {
    //MARK: - PROPERTIES.
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var truckNumberLbl: UILabel!
    @IBOutlet private weak var lastUpdatedCountLbl: UILabel!
    @IBOutlet private weak var lastUpdatedDaysLbl: UILabel!
    @IBOutlet private weak var truckStateLbl: UILabel!
    @IBOutlet private weak var speedLbl: UILabel!
    
    //MARK: - VIEW's LIFECYCLE METHODS.
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.addShadow(cornerRadius: 5, shadowRadius: 3, shadowOpacity: 1, color: UIColor.lightGray.withAlphaComponent(0.5), shadowOffset: CGSize(width: 0, height: 2))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    /// FUNCTION TO CONFIGURE CELL DATA.
    func configureCell(data: TruckDataModel) {
        speedLbl.text = "\(data.lastWaypoint?.speed ?? 0.0)"
        truckNumberLbl.text = data.truckNumber
        let runningTime = convertTime(miliseconds: data.lastRunningState?.stopStartTime ?? 0)
        truckStateLbl.text = "\(data.lastRunningState?.truckRunningState == 0 ? "Stopped" : "Running") since last \(runningTime.0)"
        lastUpdatedCountLbl.text = "\(runningTime.1)"
    }
    
    /// FUNCTION TO CONVERT MILLISECONDS INTO MINUTES, HOURS, DAYS.
    func convertTime(miliseconds: Int) -> (String, Int) {
        var seconds: Int = 0
        var minutes: Int = 0
        var hours: Int = 0
        var days: Int = 0
        var secondsTemp: Int = 0
        var minutesTemp: Int = 0
        var hoursTemp: Int = 0

        if miliseconds < 1000 {
            return ("", 0)
        } else if miliseconds < 1000 * 60 {
            seconds = miliseconds / 1000
            return ("\(seconds) seconds", seconds)
        } else if miliseconds < 1000 * 60 * 60 {
            secondsTemp = miliseconds / 1000
            minutes = secondsTemp / 60
            seconds = (miliseconds - minutes * 60 * 1000) / 1000
            return ("\(minutes) minutes", minutes)
        } else if miliseconds < 1000 * 60 * 60 * 24 {
            minutesTemp = miliseconds / 1000 / 60
            hours = minutesTemp / 60
            minutes = (miliseconds - hours * 60 * 60 * 1000) / 1000 / 60
            seconds = (miliseconds - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
            return ("\(hours) hours", hours)
        } else {
            hoursTemp = miliseconds / 1000 / 60 / 60
            days = hoursTemp / 24
            hours = (miliseconds - days * 24 * 60 * 60 * 1000) / 1000 / 60 / 60
            minutes = (miliseconds - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000) / 1000 / 60
            seconds = (miliseconds - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
            return ("\(days) days", days)
        }
    }
    
}
