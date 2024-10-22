//
//  ContentView.swift
//  BluetoothBatteryChecker
//
//  Created by 주승현 on 10/22/24.
//

import SwiftUI
import CoreBluetooth

struct ContentView: View {
    @StateObject private var bluetoothManager = BluetoothManager() // BluetoothManager 사용
    
    var body: some View {
        VStack {
            // 타이틀 섹션
            Text("🔍 Bluetooth Device Scanner")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 20)
            
            Text("주변의 블루투스 장치를 검색하고 정보를 확인하세요.")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            // 장치 리스트 섹션
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(bluetoothManager.devices, id: \.self) { device in
                        HStack {
                            Image(systemName: "dot.radiowaves.left.and.right")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text(device.name ?? "알 수 없는 기기")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                
                                Text("신호 강도: RSSI \(device.rssi)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 400) // 스크롤 가능한 영역의 최대 높이 설정
            
            // 스캔 버튼
            Button(action: {
                bluetoothManager.startScan()
            }) {
                Text("🔄 블루투스 장치 스캔")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.5)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

        }
        .frame(minWidth: 400, minHeight: 600)
        .background(Color(NSColor.windowBackgroundColor).edgesIgnoringSafeArea(.all)) // macOS 배경 색상 적용
    }
}

#Preview {
    ContentView()
}
