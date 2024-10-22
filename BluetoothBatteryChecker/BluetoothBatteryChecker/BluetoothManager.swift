//
//  BluetoothManager.swift
//  BluetoothBatteryChecker
//
//  Created by 주승현 on 10/22/24.
//

import Foundation
import CoreBluetooth

// BluetoothManager 클래스는 CoreBluetooth를 사용해 스캔 및 장치 정보를 관리
class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    @Published var devices: [BluetoothDevice] = [] // 스캔된 기기 정보 저장
    
    var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // 스캔 시작
    func startScan() {
        devices.removeAll() // 기존 목록 초기화
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    // 블루투스 상태 확인
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            startScan()
        } else {
            print("Bluetooth is not available.")
        }
    }
    
    // 장치가 발견되었을 때 호출되는 메서드
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let newDevice = BluetoothDevice(name: peripheral.name, rssi: RSSI.intValue)
        
        if !devices.contains(newDevice) {
            devices.append(newDevice)
        }
    }
}

// BluetoothDevice 구조체 (장치 정보 저장)
struct BluetoothDevice: Hashable {
    var name: String?
    var rssi: Int
}

