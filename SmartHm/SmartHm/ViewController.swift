//
//  ViewController.swift
//  SmartHm
//
//  Created by Marvin Herhaus on 31.12.20.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController{
   
    let mqttClient = CocoaMQTT(clientID: "iOS", host: "127.0.0.1", port: 1883)
    
//    let mqttClient = CocoaMQTT(clientID: "iOS", host: "169.254.30.95", port: 1883)
//    let mqttClient = CocoaMQTT(clientID: "iOS", host: "192.168.178.46", port: 1883)
//    let mqttClient = CocoaMQTT(clientID: "iOS", host: "192.168.178.77", port: 1883)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gibt den Connected Status für MQTT zurück:
        mqttClient.didChangeState = {_, state in print("State: \(state)")}
    }
    
    
    @IBOutlet weak var fehlerMeldung: UILabel!
    
    
    @IBAction func onOFF(_ sender: UISwitch) {
        if(mqttClient.connect()){
            fehlerMeldung.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }else{
            fehlerMeldung.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if sender.isOn {
            mqttClient.publish("zigbee2mqtt/Birne/set", withString: "ON")
        }else {
            mqttClient.publish("zigbee2mqtt/Birne/set", withString: "OFF")
            }
        }
    }
    
    @IBAction func connectButton(_ sender: UIButton) {
        if(mqttClient.connect()){}
    }
    
    @IBAction func disconnectButton(_ sender: UIButton) {
        mqttClient.disconnect()
    }
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func slider(_ sender: UISlider) {
        if(mqttClient.connect()){
            fehlerMeldung.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }else{
            fehlerMeldung.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            let value = sender.value
            let wert = value*63.5
            print(wert)
            let Brightness = "{\"brightness\":\(wert)}"
            mqttClient.publish("zigbee2mqtt/Birne/set", withString: (Brightness))
        }
    }
    
    
    
}

    
    
    
    
