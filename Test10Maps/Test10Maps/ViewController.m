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


@interface ViewController () <MKMapViewDelegate>

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
