//
//  IGImage.m
//  Instamap
//
//  Created by Raul Andrisan on 6/26/11.
//  Copyright 2011 NextRoot. All rights reserved.
//

#import "IGImage.h"

@implementation IGImage
static NSString* cdnDomain;
static NSString* nonCDNDomain;

+(void)setCDNDomain:(NSString*) theCdnDomain
{
    cdnDomain = theCdnDomain;
}

+(void)setNonCDNDomain:(NSString*) theNonCDNDomain
{
    nonCDNDomain = theNonCDNDomain;
}

+(BOOL)shouldReplaceCDNDomain
{
    BOOL result = NO;
    if (cdnDomain && nonCDNDomain && ![cdnDomain isEqualToString:nonCDNDomain]) {
        result = YES;
    }
    
    return result;
}

+(IGImage*)imageWithDictionary:(NSDictionary*)dict
{
    IGImage* image = [[IGImage alloc]init];
    NSDictionary* thumbnailDictionary = [dict objectForKey:@"thumbnail"];
    NSDictionary* standardDictionary = [dict objectForKey:@"standard_resolution"];
    NSDictionary* lowDictionary = [dict objectForKey:@"low_resolution"];

    image.low_resolution = [self shouldReplaceCDNDomain] ? [[lowDictionary objectForKey:@"url"] stringByReplacingOccurrencesOfString:nonCDNDomain withString:cdnDomain]:[lowDictionary objectForKey:@"url"];
    image.standard_resolution = [self shouldReplaceCDNDomain] ? [[standardDictionary objectForKey:@"url"] stringByReplacingOccurrencesOfString:nonCDNDomain withString:cdnDomain]:[standardDictionary objectForKey:@"url"];
    image.thumbnail = [self shouldReplaceCDNDomain] ? [[thumbnailDictionary objectForKey:@"url"] stringByReplacingOccurrencesOfString:nonCDNDomain withString:cdnDomain]:[thumbnailDictionary objectForKey:@"url"];
    
    return image;
}

@end
