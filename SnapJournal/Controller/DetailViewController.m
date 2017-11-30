//
//  DetailViewController.m
//  SnapJournal
//
//  Created by Larry Luk on 2017-11-26.
//  Copyright © 2017 Larry Luk. All rights reserved.
//

#import "DetailViewController.h"
#import "DataHandler.h"
#import <MapKit/MapKit.h>

@interface DetailViewController () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UIImageView *pinIcon;
@property (weak, nonatomic) IBOutlet UILabel *degreesLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    Journal *journal = self.journal;

    NSDate *currentDate = journal.timeStamp;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MMMM dd, YYYY";
    self.dateLabel.text = [dateFormatter stringFromDate: currentDate];
    self.dvcTitleLabel.text = journal.title;
    self.dvcTitleLabel.layer.borderWidth = 0.75f;
    self.dvcTitleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.dvcDetailLabel.text = journal.detail;
    self.dvcDetailLabel.layer.borderWidth = 0.75f;
    self.dvcDetailLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.degreesLabel.text = [NSString stringWithFormat:@"%g°C", round(journal.temp)];
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", journal.city, journal.country];
    self.pinIcon.image = [UIImage imageNamed:@"icon_mappin"];
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:journal.image];
    NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
    self.dvcImageView.image = [[UIImage alloc] initWithData:imageData];
    self.weatherIcon.image = [UIImage imageNamed:journal.condition];
    
    CLLocationCoordinate2D location;
    location.latitude = journal.lattitude;
    location.longitude = journal.longitude;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = location;
    [self.mapView addAnnotation: annotation];
    
    MKMapCamera *camera = [MKMapCamera camera];
    camera.centerCoordinate = location;
    camera.altitude = 700;
    self.mapView.camera = camera;
    
}



- (IBAction)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editButtonPressed:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.isSelected) {
        [sender setImage:[UIImage imageNamed:@"button_snap.png"] forState:UIControlStateNormal];
    } else {
            [sender setImage:[UIImage imageNamed:@"button_edit.png"] forState:UIControlStateNormal];

        }

    }

    


@end
