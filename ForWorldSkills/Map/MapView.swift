//
//  MapView.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 31.01.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationModel: Identifiable {
    let id: String = UUID().uuidString
    let address: String
    let coordinate: CLLocationCoordinate2D?
    
    init(address: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.address = address
        self.coordinate = coordinate
    }
    
    func setCoordinate(coordinate: CLLocationCoordinate2D) -> LocationModel {
        return LocationModel(address: address, coordinate: coordinate)
    }
}

struct MapView: View {
    @State private var region: MKCoordinateRegion = .init()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    @State private var locations: [LocationModel] = [
        .init(address: "Ереванская улица, 7, Новосибирск")
    ]
    
    var body: some View {
        ZStack {
            if let first = locations.first, let coordinate = first.coordinate {
                Text("TRUE")
            }
            
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, userTrackingMode: $userTrackingMode, annotationItems: locations) { location in
                if let coordinate = location.coordinate {
                    MapMarker(coordinate: coordinate)
                } else {
                    MapMarker(coordinate: .init())
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            locations.forEach { location in
                getCoordinates(location.address) { coordinate in
                    guard let index = locations.firstIndex(where: { $0.id == location.id }) else { return }
                            
                    locations[index] = locations[index].setCoordinate(coordinate: coordinate)
                }
            }
        }
    }
    
    private func getCoordinates(_ address: String,completion: @escaping((CLLocationCoordinate2D) -> ())){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {  return }
            DispatchQueue.main.async {
                completion(location.coordinate)
            }
        }
    }
}



#Preview {
    MapView()
}
