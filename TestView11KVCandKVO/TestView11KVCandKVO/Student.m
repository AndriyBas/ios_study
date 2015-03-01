//
//  Student.m
//  TestView11KVCandKVO
//
//  Created by Andriy Bas on 3/1/15.
//  Copyright (c) 2015 Andriy Bas. All rights reserved.
//

#import "Student.h"

@implementation Student


- (NSString*) description {
    return [NSString stringWithFormat:@"Student {\n\tname : %@,\n\tage : %ld\n}", _name, _age];
}


- (BOOL) validateValue:(inout __autoreleasing id *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing *)outError {
    
    if([inKey isEqualToString:@"name"]) {
        
        NSString* newVal = *ioValue;
        
        if(![newVal isKindOfClass:[NSString class]]) {
            *outError = [[NSError alloc] initWithDomain:@"Not a NSStiong" code:111 userInfo:nil];
            return FALSE;
        } else if([newVal containsString:@"1"]) {
            
            *outError = [[NSError alloc] initWithDomain:@"Wow, a number ?" code:112 userInfo:nil];
            return FALSE;
            
        }
    }
    
    return TRUE;
}

@end
