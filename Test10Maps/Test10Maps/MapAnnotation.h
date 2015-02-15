//
//  MapAnnotation.h
//  Test10Maps
//
//  Created by Andriy Bas on 2/15/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
