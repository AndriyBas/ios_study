//
//  ViewController.m
//  Test10Maps
//
//  Created by Andriy Bas on 2/15/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "ViewController.h"
#import "MapAnnotation.h"
#import <MapKit/MapKit.h>

#import "UIView+MKAnnotationView.h"


@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLGeocoder* geoCoder;
@property (strong, nonatomic) MKDirections* directions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.delegate = self;

    
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionMapAdd:)];
    
    UIBarButtonItem* zoomBarBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(actionMapZoom:)];
    
    self.navigationItem.rightBarButtonItems = @[barButton, zoomBarBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message {

    [[[UIAlertView alloc]
      initWithTitle:title
      message:message
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil]
     show];

    
}

#pragma mark - Actions

- (void)actionMapAdd:(id) sender {
    
    MapAnnotation* annotation = [[MapAnnotation alloc] init];
    
    annotation.title = @"Test title";
    annotation.subtitle = @"Test subtitle";
    annotation.coordinate = self.mapView.region.center;
    
    [self.mapView addAnnotation:annotation];
}

- (void)actionMapZoom:(id) sender {
    
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for( id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 20000.0;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, 2.0 * delta, 2.0 * delta);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];

    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
}

- (void) dealloc {
    if([self.geoCoder isGeocoding]) {
       [self.geoCoder cancelGeocode];
    }
    
    if(self.directions && self.directions.calculating) {
        [self.directions cancel];
    }
}

- (void) actionPinDescription:(UIButton*) sender {
    
    NSLog(@"actionPinDescription");
    
    MKAnnotationView* annotationView = [sender superAnnotataionView];
    
    if(!annotationView) {
        return;
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];

    if(self.geoCoder) {
        [self.geoCoder cancelGeocode];
    } else {
        self.geoCoder = [[CLGeocoder alloc] init];
    }
    
    [self.geoCoder
     reverseGeocodeLocation:location
        completionHandler:^(NSArray *placemarks, NSError *error) {
        
            NSString* message = nil;
        
            if(error) {
            message = error.localizedDescription;
            } else {
            
                if([placemarks count] > 0) {
                
                    CLPlacemark* placemark = [placemarks firstObject];
                
                    message = [placemark.addressDictionary description];
                
                } else {
                    message = @"No placemarks found";
                }
            }
        
            [self showAlertWithTitle:@"Location" andMessage:message];
    }];
    
}

- (void) actionDirection:(UIButton*) sender {
    
    MKAnnotationView* annotationView = [sender superAnnotataionView];
    
    if(!annotationView)
        return;
    
    CLLocationCoordinate2D coordicate = annotationView.annotation.coordinate;
    
//    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordicate.latitude longitude:coordicate.longitude];
    
    MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
    
    
    CLLocationCoordinate2D sourceCoordinate = (CLLocationCoordinate2D){coordicate.latitude + 0.15F, coordicate.longitude - 0.10F};
    MKPlacemark* sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:sourceCoordinate addressDictionary:nil];
    MKMapItem* sourceMapItem = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
//    MKMapItem* sourceMapItem = [MKMapItem mapItemForCurrentLocation];
    
    MKPlacemark* destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:coordicate addressDictionary:nil];
    MKMapItem* destinationMapItem = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];

    request.source = sourceMapItem;
    request.destination = destinationMapItem;
    
    request.transportType =  MKDirectionsTransportTypeAny;
    request.requestsAlternateRoutes = YES;
    
    if(self.directions && self.directions.calculating) {
        [self.directions cancel];
    }
    
    self.directions = [[MKDirections alloc] initWithRequest:request];
    [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        if(error) {
            [self showAlertWithTitle:@"Error" andMessage:[error localizedDescription]];
        } else if(0 == [response.routes count]) {
            [self showAlertWithTitle:@"Oops" andMessage:@"No routes found"];
        } else {
            
            [self.mapView removeOverlays:[self.mapView overlays]];
            
            
            NSMutableArray* polyline = [NSMutableArray array];
            for(MKRoute* r in response.routes) {
                [polyline addObject:r.polyline];
            }
        
            [self.mapView addOverlays:polyline level:MKOverlayLevelAboveLabels];
            
        }
        
    }];
    
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Annotation";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.pinColor = MKPinAnnotationColorPurple;
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
        
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self action:@selector(actionPinDescription:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = button;
        
        
        UIButton* directionBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [directionBtn addTarget:self action:@selector(actionDirection:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.leftCalloutAccessoryView = directionBtn;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState NS_AVAILABLE(10_9, 4_0) {
    
    if(MKAnnotationViewDragStateEnding == newState) {
        CLLocationCoordinate2D coordinate = view.annotation.coordinate;
    
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
    
        NSLog(@"location = {%.1f, %.1f}\npoint = %@", coordinate.latitude, coordinate.longitude, MKStringFromMapPoint(point));
    }
    
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay NS_AVAILABLE(10_9, 7_0) {
    if([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        renderer.strokeColor = [UIColor magentaColor];
        renderer.lineWidth = 2.0F;
        
        return renderer;
    }

    return nil;
}

/*
 
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
     NSLog(@"regionDidChangeAnimated");
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
     NSLog(@"mapViewWillStartLoadingMap");
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
     NSLog(@"mapViewDidFinishLoadingMap");
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
     NSLog(@"mapViewDidFailLoadingMap");
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView NS_AVAILABLE(10_9, 7_0) {
     NSLog(@"mapViewWillStartRenderingMap");
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered NS_AVAILABLE(10_9, 7_0) {
     NSLog(@"mapViewDidFinishRenderingMap");
}
 
 */



@end
