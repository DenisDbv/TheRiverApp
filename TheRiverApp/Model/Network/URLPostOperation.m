//
//  URLPostOperation.m
//  TheGameApp
//
//  Created by DenisDbv on 21.07.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "URLPostOperation.h"

@implementation URLPostOperation
{
    SuccessBlockDownloader successBlockDownloader;
    FailedBlockDownloader failedBlockDownloader;
    NSString *_eTagValue;
}

@synthesize url = _url;
@synthesize param = _param;
@synthesize header = _header;

- (id)initWithUrlString:(NSString *)urlPath
               andParam:(id)params
              andHeader:(id)headers
       withSuccessBlock:(SuccessBlockDownloader) succesBlock
         andFailedBlock:(FailedBlockDownloader) failedBlock
{
    self = [super init];
    if (self == nil)
        return nil;
    
    _url = [urlPath copy];
    _param = [params copy];
    _header = [headers copy];
    _eTagValue = @"";
    
    successBlockDownloader = [succesBlock copy];
    failedBlockDownloader = [failedBlock copy];
    
    _isExecuting = NO;
    _isFinished = NO;
    
    return self;
}

- (id)initWithUrlString:(NSString *)urlPath
               andParam:(id)params
              andHeader:(id)headers
                   eTag:(NSString*)eTagValue
       withSuccessBlock:(SuccessBlockDownloader) succesBlock
         andFailedBlock:(FailedBlockDownloader) failedBlock
{
    self = [super init];
    if (self == nil)
        return nil;
    
    _url = [urlPath copy];
    _param = [params copy];
    _header = [headers copy];
    _eTagValue = [eTagValue copy];
    
    successBlockDownloader = [succesBlock copy];
    failedBlockDownloader = [failedBlock copy];
    
    _isExecuting = NO;
    _isFinished = NO;
    
    return self;
}

- (BOOL)isConcurrent
{
    return YES;
}

- (void)start
{
    NSLog(@"<UpdateManager> Post opeartion for <%@> started.", _url);
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self entryJSONToUrl:_url param:_param header:_header eTag:_eTagValue];
}

- (void)finish
{
    NSLog(@"<UpdateManager> Post operation for <%@> finished. ", _url);
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

-(void) entryJSONToUrl:(NSString*)urlString param:(id)parameters header:(id)headers eTag:(NSString*)eTagValue
{
    NSMutableDictionary *requestHeaders = headers;
    if(requestHeaders == nil)  {
        requestHeaders = [[NSMutableDictionary alloc] init];
        //[requestHeaders setObject:@"application/json" forKey:@"Content-Type"];
    }
    
    if(eTagValue.length > 0)    {
        [requestHeaders setObject:eTagValue forKey:@"If-None-Match"];
    }
    
    [[LRResty client] post:urlString payload:parameters headers:requestHeaders withBlock:^(LRRestyResponse *response) {
        if(response.status == 200)  {

            [self finish];
            
            NSDictionary *resultJSON = [[response asString] objectFromJSONString];
            if( ([[resultJSON objectForKey:@"status"] boolValue] == NO) &&
               ([[resultJSON objectForKey:@"code"] integerValue] == 1))    {
                NSLog(@"Oops!!! Server error: %@", resultJSON);
                [AppDelegateInstance() showServerErrorMessage];
            }
            
            successBlockDownloader(response);
        }
        else
        {
            [self finish];
            failedBlockDownloader(response);
        }
    }];
}

@end
