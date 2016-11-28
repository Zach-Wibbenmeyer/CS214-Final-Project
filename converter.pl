######################################################################################
### converter.pl - Basic program that implements a GUI to convert                  ###
###					between five common measurements                               ###
### by: Zach Wibbenmeyer                                                           ###
### For: CS214, Calvin College													   ###
### Due: May 12, 2016                                                              ###
######################################################################################

#Syntax for Perl taken from http://www.tutorialspoint.com/perl/perl_syntax.htm

#!/usr/bin/perl -w
require 5.002;
use warnings;

#
use Tk;
use Tk::DialogBox;
use Scalar::Util qw(looks_like_number); #taken from http://www.perlmonks.org/?node_id=955846

# use strict;

# implement the method
sub convertMeasurement;

# Main program

# create a list of the multiples of the different measurements
my %multiple = ('m' => 1.0, 'c' => 0.01, 'i' => 0.0254, 'f' => 0.3048, 'y' => 0.9144);
my %measurements = ('m' => "Meters",
					'c' => "Centimeters",
					'i' => "Inches",
					'f' => "Feet",
					'y' => "Yards");

# all Tk creations taken from https://metacpan.org/release/Tk
# start creating the Tk::Perl box
my $mw = MainWindow->new;

# create a header and footer
$mw->title("Measurement Converter!");
$mw->Label(-text => 'Written by Zach Wibbenmeyer')->pack(-side => 'bottom');

# create a global variable for storing a user's answer
my $answer;

# create a quit button
my $quit = $mw->Button(-text => 'Quit', -command => sub { exit; });
$quit->pack(-side => 'bottom', -expand => '1', -fill => 'both');

# Create a button for converting between measurements
my $convert = $mw->Button(-text => 'Convert!', -command => sub { convertMeasurement; });
$convert->pack(-side => 'bottom', -expand => '1', -fill => 'both');

# Create a frame for the answer
my $answerFrame = $mw->Frame()->pack(-expand => '1', -fill => 'both', -side => 'bottom');
$answerFrame->Label(-text => "Outputed Value:")->pack(-side => 'left');

# Create an entry box for the outputed answer
my $answerValue = $answerFrame->Entry(-width => '15', -relief => 'sunken')->pack(-side => 'right');

# create a new frame and label for entering a value to convert
my $frameValue = $mw->Frame()->pack(-expand => '1', -fill => 'both', -side => 'bottom');
$frameValue->Label(-text => "Enter a value to convert:")->pack(-side => 'left');

#pack the convert value
my $convertValue = $frameValue->Entry(-width => '10', -relief => 'sunken')->pack(-side => 'right');

# create frame for displaying the dimensions of the from portion of the Tk box
my $fromFrame = $mw->Frame(-relief => 'raised', -width => '100', -height => '200');
$fromFrame->pack(-side => 'left', -expand => '1', -fill => 'both');

# create frame for displaying the dimensions of the to portion of the Tk box
my $toFrame = $mw->Frame(-relief => 'raised', -width => '100', -height => '200');
$toFrame->pack(-side => 'right', -expand => '1', -fill => 'both');

# pack the fromFrame
$fromFrame->Label(-text => "Convert From")->pack();

# create a radiobutton for converting from meters
my $fromMeters = $fromFrame->Radiobutton(-variable => \$from, -value => 'm',
											-text => 'Meters');
$fromMeters->pack(-side => 'top', -anchor => 'w');	

# create a radiobutton for converting from centimeters
my $fromCentimeters = $fromFrame->Radiobutton(-variable => \$from, -value => 'c',
												-text => 'Centimeters');
$fromCentimeters->pack(-side => 'top', -anchor => 'w');

# create a radiobutton for converting from inches
my $fromInches = $fromFrame->Radiobutton(-variable => \$from, -value => 'i',
											-text => 'Inches');
$fromInches->pack(-side => 'top', -anchor => 'w');

# create a radiobutton for converting from feet
my $fromFeet = $fromFrame->Radiobutton(-variable => \$from, -value => 'f',
											-text => 'Feet');
$fromFeet->pack(-side => 'top', -anchor => 'w');

# create a radiobutton for converting from yards
my $fromYards = $fromFrame->Radiobutton(-variable => \$from, -value => 'y',
											-text => 'Yards');
$fromYards->pack(-side => 'top', -anchor => 'w');

# create a label that indicates the user to pick a unit to start with
$toFrame->Label(-text => "Convert To")->pack();

# create a radiobutton for converting to meters
my $toMeters = $toFrame->Radiobutton(-variable => \$to, -value => 'm',
										    -text => 'Meters');
$toMeters->pack(-side => 'top', -anchor => 'w');

# create a radiobutton for converting to centimeters
my $toCentimeters = $toFrame->Radiobutton(-variable => \$to, -value => 'c',
											-text => 'Centimeters');
$toCentimeters->pack(-side => 'top', -anchor => 'w');

# create a radiobutton for converting to inches
my $toInches = $toFrame->Radiobutton(-variable => \$to, -value => 'i',
											-text => 'Inches');
$toInches->pack(-side => 'top', -anchor => 'w');

# create a radiobutton for converting to feet
my $toFeet = $toFrame->Radiobutton(-variable => \$to, -value => 'f',
											-text => 'Feet');
$toFeet->pack(-side => 'top', -anchor => 'w');

#create a radio button for converting to yards
my $toYards = $toFrame->Radiobutton(-variable => \$to, -value => 'y',
											-text => 'Yards');
$toYards->pack(-side => 'top', -anchor => 'w');																																																					

# implement the Tk box
MainLoop;

######################################################################
### convertMeasurement() - converts between distance measurements  ###
### @param: None                                                   ###
### Return: a converted distance measurement                       ###
######################################################################

sub convertMeasurement {

	# create a local variable to receive the input the user entered
	my $var = $convertValue->get;

	#check if the user entered anthing
	while ($var) { # taken from http://www.perlmonks.org/?node_id=598879
		# make sure the user entered a number
		if (looks_like_number($var)) {
			# convert to meters
			my $meterValue = $multiple{$from} * $var;
			printf("From $var ($from) to $meterValue (m)\n");

			# convert to the specified value
			my $answer = ($meterValue) / ($multiple{$to});
			printf("From $var ($from) to $answer ($to)\n");


			# input the answer
			$answerValue->delete('0', 'end'); #taken from http://perldoc.perl.org/functions/delete.html
			$answerValue->insert('0', $answer);


			# create a dialogbox for displaying the final answer
			my $dialog = $mw->DialogBox(-title => "Measurement Converter", 
										-buttons => ["Awesome!"]);
			$dialog->add("Label", -text => "$var $measurements{$from} is $answer $measurements{$to}")->pack;
			$dialog->Show;
			last; #taken from http://stackoverflow.com/questions/303216/how-do-i-break-out-of-a-loop-in-perl
		} else {
			# display a dialog box if the user entered something other than a number
			my $secondDialog = $mw->DialogBox(-title => "Measurement Converter",
												-buttons => ["Got it"]);
			$secondDialog->add("Label", -text => "$var is not a number")->pack;
			$secondDialog->Show;
			last;
		}
	}	
	
} 