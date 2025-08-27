#import <Foundation/Foundation.h>

%hook SessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)task didReceiveData:(NSData *)data {
	NSLog(@"[NotabilityPro] %@", task.currentRequest.URL.absoluteString);

	if ([task.currentRequest.URL.absoluteString containsString:@"/global"]) {
		NSDictionary *dict = @{
			@"data": @{
				@"processAppleReceipt": @{
					@"error": @0,
					@"__typename": @"SubscriptionResult",
					@"subscription": @{
						@"overDeviceLimit": @NO,
						@"__typename": @"AppStoreSubscription",
						@"isInBillingRetryPeriod": @NO,
						@"refundedReason": NSNull.null,
						@"tier": @"pro",
						@"productId": @"com.gingerlabs.Notability.pro_subscription",
						@"user": NSNull.null,
						@"gracePeriodExpiresAt": NSNull.null,
						@"status": @"active",
						@"expirationIntent": NSNull.null,
						@"expirationDate": @"2099-01-01T23:45:47.000Z",
						@"refundedDate": NSNull.null,
						@"originalPurchaseDate": @"2023-08-31T17:27:35.000Z",
						@"originalTransactionId": @"2000000403209609"
					},
					@"isClassic": @YES
				}
			}
		};

		data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
	}

	%orig(session, task, data);
}

%end

%ctor {
	%init(SessionDelegate = objc_getClass("Apollo.URLSessionClient"));
}
