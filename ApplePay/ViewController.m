//
//  ViewController.m
//  ApplePay
//
//  Created by Hunk on 14/10/24.
//  Copyright (c) 2014年 Hunk. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <PKPaymentAuthorizationViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)payAction:(id)sender
{
    if([PKPaymentAuthorizationViewController canMakePayments])
    {
        PKPaymentSummaryItem *item0 = [PKPaymentSummaryItem summaryItemWithLabel:@"Price-0"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"0.99"]];
        PKPaymentSummaryItem *item1 = [PKPaymentSummaryItem summaryItemWithLabel:@"Price-1"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"1.99"]];
        PKPaymentSummaryItem *item2 = [PKPaymentSummaryItem summaryItemWithLabel:@"Price-2"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"2.99"]];
        PKPaymentSummaryItem *item  = [PKPaymentSummaryItem summaryItemWithLabel:@"Price"
                                                                          amount:[NSDecimalNumber decimalNumberWithString:@"5.97"]];
        
        PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
        [paymentRequest setCountryCode:@"US"];
        [paymentRequest setCurrencyCode:@"USD"];
        [paymentRequest setSupportedNetworks:@[PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa]];
        [paymentRequest setMerchantIdentifier:@"merchant.com.hunk.assistant"];
        [paymentRequest setMerchantCapabilities:PKMerchantCapabilityEMV];
        [paymentRequest setPaymentSummaryItems:@[item0, item1, item2, item]];
        
        PKPaymentAuthorizationViewController *paymentAuthorizationViewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];
        [paymentAuthorizationViewController setDelegate:self];
        [self presentViewController:paymentAuthorizationViewController animated:YES completion:^{
        }];
        
    }
}

#pragma mark -
#pragma mark PKPaymentAuthorizationViewController Delegate Methods
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
