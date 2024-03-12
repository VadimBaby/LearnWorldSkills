//
//  MapView2.swift
//  ForWorldSkills
//
//  Created by Вадим Мартыненко on 31.01.2024.
//

import SwiftUI
import MapKit

enum Locations {
    static let firstLocation: CLLocationCoordinate2D = .init(latitude: 55.051018, longitude: 82.937199)
    static let secondLocation: CLLocationCoordinate2D = .init(latitude: 55.042333, longitude: 82.903369)
    static let thirdLocation: CLLocationCoordinate2D = .init(latitude: 53.327643, longitude: 83.66957)
}

struct MapView2: View {
    @State private var camera: MapCameraPosition = .automatic
    @State private var address: String = ""
    
    @State private var route: MKRoute? = nil
    
    private let locationManager: CLLocationManager = .init()
    
    var body: some View {
        Map(position: $camera) {
            Marker("Marker", coordinate: Locations.firstLocation)
            Annotation("Annotation", coordinate: Locations.secondLocation) {
                Image(systemName: "person.fill")
            }
            UserAnnotation()
            if let route {
                MapPolyline(route.polyline)
                    .stroke(Color.blue, lineWidth: 2)
            }
        }
        .safeAreaInset(edge: .top, content: {
            Text(address)
        })
        .safeAreaInset(edge: .bottom, content: {
            Button("Go To Marker") {
                withAnimation(.easeInOut) {
                    self.camera = .item(.init(placemark: .init(coordinate: Locations.firstLocation)))
                }
            }
        })
        .onAppear {
            if locationManager.authorizationStatus == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            if let location = locationManager.location {
                CLGeocoder().reverseGeocodeLocation(location) { placemark, error in
                    if let placemark,
                       let place = placemark.first {
                        var address = place.name ?? ""
                        address = address + ", "
                        let country = place.country ?? ""
                        address = address + country
                        self.address = address
                    }
                }
            }
            
            let request = MKDirections.Request()
            request.source = .init(placemark: .init(coordinate: Locations.firstLocation))
            request.destination = .init(placemark: .init(coordinate: Locations.secondLocation))
            request.transportType = .automobile
            MKDirections(request: request).calculate { response, error in
                if let response,
                   let first = response.routes.first {
                    self.route = first
                }
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
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
    MapView2()
}
