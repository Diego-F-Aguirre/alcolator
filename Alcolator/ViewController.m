//
//  ViewController.m
//  Alcolator
//
//  Created by Diego Aguirre on 2/9/15.
//  Copyright (c) 2015 Diego Aguirre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>



@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (weak, nonatomic) UILabel *beerCountDisplay;



@end

@implementation ViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}


-(void)loadView {
    
    self.view= [[UIView alloc]init];
    UITextField *textField = [[UITextField alloc]init];
    UISlider *slider = [[UISlider alloc]init];
    UILabel *label = [[UILabel alloc]init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
    
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor brownColor];
    self.beerPercentTextField.backgroundColor = [UIColor colorWithRed:119/255.0 green:155/255.0 blue:224/255.0 alpha:1];
    self.beerCountSlider.backgroundColor = [UIColor colorWithRed:119/255.0 green:155/255.0 blue:224/255.0 alpha:1];
    self.calculateButton.backgroundColor = [UIColor colorWithRed:119/255.0 green:155/255.0 blue:224/255.0 alpha:1];
    self.resultLabel.textColor = [UIColor colorWithRed:119/255.0 green:155/255.0 blue:224/255.0 alpha:1];
    self.beerPercentTextField.textColor = [UIColor whiteColor];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.resultLabel setFont:[UIFont fontWithName:@"Avenir Next Ultra Light" size:16]];
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:20];
    

    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.placeholder = NSLocalizedString(@"Alcohol Content Per Beer", @"Beer percent placeholder text");
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    self.resultLabel.numberOfLines = 0;
    
    self.view.backgroundColor= [UIColor colorWithRed:18/255.0 green:22/255.0 blue:35/255.0 alpha:1];
    
  
    
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.



}


- (void)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }
    
}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    
    self.resultLabel.text = [NSString stringWithFormat:@"%f Beers",self.beerCountSlider.value];
    
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    
    if (sender == _beerCountSlider) {
        _beerCountDisplay.text = [NSString stringWithFormat:@"%f Beers", _beerCountSlider.value];
    }
    
}

- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
     [self.beerPercentTextField resignFirstResponder];
    
}


- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat padding = 20;
    CGFloat itemWidth = self.view.frame.size.width - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, self.navigationController.navigationBar.frame.size.height + padding + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
}





@end
