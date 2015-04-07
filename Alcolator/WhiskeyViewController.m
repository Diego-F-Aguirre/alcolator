//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Diego Aguirre on 2/11/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "WhiskeyViewController.h"
#import "ViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Whiskey", nil);
    }
    
    return self;
}


- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    
    self.beerPercentTextField.backgroundColor = [UIColor colorWithRed:217/255.0 green:84/255.0 blue:72/255.0 alpha:1];
    self.beerCountSlider.backgroundColor = [UIColor colorWithRed:217/255.0 green:84/255.0 blue:72/255.0 alpha:1];
    self.resultLabel.textColor = [UIColor colorWithRed:217/255.0 green:84/255.0 blue:72/255.0 alpha:1];
    self.calculateButton.backgroundColor = [UIColor colorWithRed:217/255.0 green:84/255.0 blue:72/255.0 alpha:1];

    self.beerPercentTextField.textColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:89/255.0 green:2/255.0 blue:2/255.0 alpha:1];
    
    
    
    
   
    
    }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
