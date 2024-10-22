//
//  BluetoothManager.swift
//  BluetoothBatteryChecker
//
//  Created by 주승현 on 10/22/24.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    @Published var devices: [BluetoothDevice] = [] // 스캔된 기기 정보 저장
    @Published var totalDevicesCount: Int = 0 // 총 검색된 장치 수
    
    var centralManager: CBCentralManager!
    var scanTimer: Timer? // 10초 타이머를 위한 변수
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // 스캔 시작
    func startScan() {
        devices.removeAll() // 기존 목록 초기화
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        
        // 10초 후 스캔 종료 및 장치 수 표시
        scanTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            self.stopScan()
            self.totalDevicesCount = self.devices.count // 총 장치 수 업데이트
        }
    }
    
    // 스캔 종료
    func stopScan() {
        centralManager.stopScan()
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
        
        // 중복된 장치가 리스트에 추가되지 않도록 체크
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

