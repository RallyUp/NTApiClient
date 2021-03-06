//
//  NTApiError.m
//
//  Copyright (c) 2011-2012 Ethan Nagel. All rights reserved.
//  See LICENSE for license details
//

#import "NTApiError.h"

// ARC is required

#if !__has_feature(objc_arc)
#   error ARC is required for NTApiClient
#endif



const int NTApiErrorCodeNSError = -1;
const int NTApiErrorCodeInvalidJson = -2;
const int NTApiErrorCodeError = -3;               // generic error


@implementation NTApiError


@synthesize errorCode = mErrorCode;
@synthesize errorMessage = mErrorMessage;
@synthesize nsError = mNsError;


-(id)initWithCode:(int)code message:(NSString *)message
{
    if ( (self=[super init]) )
    {
        self.errorCode = code;
        self.errorMessage = message;
    }
    
    return self;
}


-(id)initWithNSError:(NSError *)nsError
{
    if ( (self=[super init]) )
    {
        self.errorCode = NTApiErrorCodeNSError;
        self.errorMessage = [nsError localizedDescription];
        self.nsError = nsError;
    }
    
    return self;
}


+(NTApiError *)errorWithCode:(int)code message:(NSString *)message
{
    return [[NTApiError alloc] initWithCode:code message:message];
}


+(NTApiError *)errorWithCode:(int)code format:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    
    NTApiError *apiError = [[NTApiError alloc] initWithCode:code 
                                                message:[[NSString alloc] initWithFormat:format arguments:args]];
    
    va_end(args);
    
    return apiError;
}


+(NTApiError *)errorWithNSError:(NSError *)nsError
{
    return [[NTApiError alloc] initWithNSError:nsError];
}


-(NSString *)description
{
    return self.errorMessage;
}


@end
