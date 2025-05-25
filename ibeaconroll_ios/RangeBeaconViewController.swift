import UIKit
import CoreLocation

class RangeBeaconViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    let defaultUUID = "ADD8CE0A-EF05-4B57-AD8C-7651198EAB2C"
    
    var locationManager = CLLocationManager()
    var beaconConstraints = [CLBeaconIdentityConstraint: [CLBeacon]]()
    var beacons = [CLProximity: [CLBeacon]]()
    
    var tableViewRef: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // ✅ iBeacon 위치 권한 설정 및 delegate 연결
        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization() // background 실행하기 위해
        locationManager.allowsBackgroundLocationUpdates = true



        

        // ✅ SwiftUI에서 안 보이는 문제 방지
        view.backgroundColor = .systemBackground

        // ✅ 테이블 뷰 생성 및 설정
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.view.addSubview(tableView)
        self.tableViewRef = tableView

        // ✅ 앱 실행하자마자 기본 UUID 감지 시작
        if let uuid = UUID(uuidString: defaultUUID) {
            let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 100, minor: 0)
            self.beaconConstraints[constraint] = []

            let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: uuid.uuidString)
            self.locationManager.startMonitoring(for: beaconRegion)

            print("📡 기본 UUID 감지 시작: \(uuid.uuidString)")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // ✅ 백그라운드에서 탐지 종료
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
        for constraint in beaconConstraints.keys {
            locationManager.stopRangingBeacons(satisfying: constraint)
        }
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("🚀 모니터링 시작됨: \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ 위치 매니저 에러: \(error.localizedDescription)")
    }


    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("📍 didDetermineState 호출됨 — state: \(state.rawValue), region: \(region.identifier)")

        guard let beaconRegion = region as? CLBeaconRegion else { return }

        if state == .inside {
            print("📍 Region 안에 있음 → Ranging 시작")
            manager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        } else {
            print("📤 Region 밖에 있음 → Ranging 중단")
            manager.stopRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        }
    }

    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        print("🛰️ 탐지된 비콘 수: \(beacons.count)")
        beaconConstraints[beaconConstraint] = beacons

        self.beacons.removeAll()
        var allBeacons = [CLBeacon]()
        for regionResult in beaconConstraints.values {
            allBeacons.append(contentsOf: regionResult)
        }

        for range in [CLProximity.unknown, .immediate, .near, .far] {
            let proximityBeacons = allBeacons.filter { $0.proximity == range }
            if !proximityBeacons.isEmpty {
                self.beacons[range] = proximityBeacons
            }
        }

        self.tableViewRef?.reloadData()
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return max(beacons.count, 1)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if beacons.isEmpty {
            return 1
        }
        return Array(beacons.values)[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if beacons.isEmpty {
            return nil
        }

        let sectionKeys = Array(beacons.keys)
        let sectionKey = sectionKeys[section]
        switch sectionKey {
        case .immediate: return "Immediate"
        case .near: return "Near"
        case .far: return "Far"
        default: return "Unknown"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if beacons.isEmpty {
            cell.textLabel?.text = "🔍 아직 감지된 비콘이 없습니다."
            cell.detailTextLabel?.text = nil
            return cell
        }

        let sectionKey = Array(beacons.keys)[indexPath.section]
        let beacon = beacons[sectionKey]![indexPath.row]

        cell.textLabel?.text = "UUID: \(beacon.uuid.uuidString)"
        cell.detailTextLabel?.text = "Major: \(beacon.major), Minor: \(beacon.minor), RSSI: \(beacon.rssi)"

        return cell
    }
}

