import XCTest
import MapKit
@testable import MapView991

final class MapView991Tests: XCTestCase {
    func testUpdateAnnotations() {
        let mapView = MKMapView()
        let initialAnnotations = TestAnnotation.makeList(of: 20)
        mapView.addAnnotations(initialAnnotations)
        XCTAssertEqual(mapView.annotations.count, initialAnnotations.count)
        let newAnnotations = TestAnnotation.makeList(of: 30)
        let sut = AnnotationsOrganizer(old: initialAnnotations, new: newAnnotations)
        sut.updateAnnotationsIfNeeded(for: mapView)
        XCTAssertEqual(mapView.annotations.count, newAnnotations.count)
    }
    
    func testLocationCoordinatesIsNotSpecified() {
        let sut = LocationCoordinates(.init(latitude: 0, longitude: 0))
        XCTAssertFalse(sut.isSpecified)
    }
    
    func testLocationCoordinatesIsSpecified() {
        let sut = LocationCoordinates(
            .init(
                latitude: Double.random(in: 10...100),
                longitude: Double.random(in: 10...100)
            )
        )
        XCTAssertTrue(sut.isSpecified)
    }
    
    func testLocationsNotDiffer() {
        let firstLocation = LocationCoordinates(.init(latitude: 0, longitude: 0))
        let secondLocation = LocationCoordinates(.init(latitude: 0, longitude: 0))
        XCTAssertFalse(firstLocation.differs(from: secondLocation))
    }
    
    func testLocationsDiffer() {
        let firstLocation = LocationCoordinates(.init(latitude: 0, longitude: 0))
        let secondLocation = LocationCoordinates(.init(latitude: 1, longitude: 1))
        XCTAssertTrue(firstLocation.differs(from: secondLocation))
    }
}

private final class TestAnnotation: NSObject, MKAnnotation {
    private let lat: Double
    private let lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: lat, longitude: lon)
    }
    
    static func makeList(of count: Int) -> [TestAnnotation] {
        (0 ..< count).map { _ in
            .init(lat: Double.random(in: 10...50), lon: Double.random(in: 51...99))
        }
    }
}
